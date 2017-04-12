/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageCompat.h"
#import "SDWebImageOperation.h"
#import "SDWebImageDownloader.h"
#import "SDImageCache.h"

typedef NS_OPTIONS(NSUInteger, SDWebImageOptions) {
    
    //默认情况下，当URL下载失败，该URL会被列入黑名单，库就不会再去尝试获取该URL，该标记用来禁用黑名单
    SDWebImageRetryFailed = 1 << 0,
    
    //默认情况下，图片下载是在UI交互的时候，该标记用来禁用这个情况，这样子下载会延迟到UIScrollView减速的时候
    SDWebImageLowPriority = 1 << 1,
    
    //该标记禁用磁盘缓存
    SDWebImageCacheMemoryOnly = 1 << 2,
    
    //该标记用来渐进式下载，如果浏览器一样，图片在下载过程中渐渐显示。默认情况下是下载完一次性显示
    SDWebImageProgressiveDownload = 1 << 3,
    
    //即使图片已经缓存，也期望进行HTTP响应cache control并且如果有需要的话从远程地址更新图片数据
    //磁盘缓存将被NSURLCache处理而不是SDWebImage，因为SDWebImage会导致轻微的性能下载。
    //该标记帮助处理在请求同样的URL后面改变的图片。如果缓存图片被刷新，则完成的block会使用缓存图片再调用一次
    SDWebImageRefreshCached = 1 << 4,
    
    //IOS4+，程序进入后台后仍然进行下载图片，请求系统给予额外的时间进行下载，如果请求超时了，操作就会被取消
    SDWebImageContinueInBackground = 1 << 5,
    
    //通过设定NSMutableURLRequest.HTTPShouldHandleCookies = YES;来处理存储在NSHTTPCookieStore的cookies
    SDWebImageHandleCookies = 1 << 6,
    
    //该标记允许不受信任的SSL认证
    SDWebImageAllowInvalidSSLCertificates = 1 << 7,
    
    //默认情况下是按入队顺序下载，该标记可以让其优先下载
    SDWebImageHighPriority = 1 << 8,
    
    //默认情况下，占位图片在图片被加载时同时被加载，这个标记会让占位图片在图片加载完后再加载
    SDWebImageDelayPlaceholder = 1 << 9,
    
    // 我们通常不调用动画图片的transformDownloadedImage代理方法，因为大多数转换代码可以使它变得糟糕。
    // 使用这个标记则在任何情况下都进行转换。
    SDWebImageTransformAnimatedImage = 1 << 10,
    
    /**
     * By default, image is added to the imageView after download. But in some cases, we want to
     * have the hand before setting the image (apply a filter or add it with cross-fade animation for instance)
     * Use this flag if you want to manually set the image in the completion when success
     */
    SDWebImageAvoidAutoSetImage = 1 << 11
};

typedef void(^SDWebImageCompletionBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);

typedef void(^SDWebImageCompletionWithFinishedBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL);

typedef NSString *(^SDWebImageCacheKeyFilterBlock)(NSURL *url);


@class SDWebImageManager;

@protocol SDWebImageManagerDelegate <NSObject>

@optional

/**选择控制哪个image该被下载，当发现image不在cache中的时候*/
- (BOOL)imageManager:(SDWebImageManager *)imageManager shouldDownloadImageForURL:(NSURL *)imageURL;

/**允许对图片下载完后并且在存入缓存和磁盘前进行转换*/
- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL;

@end

/**
 * The SDWebImageManager is the class behind the UIImageView+WebCache category and likes.
 * It ties the asynchronous downloader (SDWebImageDownloader) with the image cache store (SDImageCache).
 * You can use this class directly to benefit from web image downloading with caching in another context than
 * a UIView.
 *
 * Here is a simple example of how to use SDWebImageManager:
 *
 * @code
 
 SDWebImageManager *manager = [SDWebImageManager sharedManager];
 [manager downloadImageWithURL:imageURL
 options:0
 progress:nil
 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
 if (image) {
 // do something with image
 }
 }];
 
 * @endcode
 */
@interface SDWebImageManager : NSObject

@property (weak, nonatomic) id <SDWebImageManagerDelegate> delegate;

@property (strong, nonatomic, readonly) SDImageCache *imageCache;
@property (strong, nonatomic, readonly) SDWebImageDownloader *imageDownloader;

/**
 * The cache filter is a block used each time SDWebImageManager need to convert an URL into a cache key. This can
 * be used to remove dynamic part of an image URL.
 *
 * The following example sets a filter in the application delegate that will remove any query-string from the
 * URL before to use it as a cache key:
 *
 * @code
 
 [[SDWebImageManager sharedManager] setCacheKeyFilter:^(NSURL *url) {
 url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
 return [url absoluteString];
 }];
 
 * @endcode
 */
@property (nonatomic, copy) SDWebImageCacheKeyFilterBlock cacheKeyFilter;

/**
 * Returns global SDWebImageManager instance.
 *
 * @return SDWebImageManager shared instance
 */
+ (SDWebImageManager *)sharedManager;


/**SDWebImageManager主要下载图片的方法，返回值是一个遵循SDWebImageOperation协议类型的值*/
- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url
                                         options:(SDWebImageOptions)options
                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                       completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

/**保存图片到cache*/
- (void)saveImageToCache:(UIImage *)image forURL:(NSURL *)url;

/**取消所有操作*/
- (void)cancelAll;

/**检查是否有下载图片操作在运行*/
- (BOOL)isRunning;

/**检查图片是否在cache中*/
- (BOOL)cachedImageExistsForURL:(NSURL *)url;

/**检查图片是否在磁盘中*/
- (BOOL)diskImageExistsForURL:(NSURL *)url;

/**检查图片是否在cache中，检查结束后进行block操作*/
- (void)cachedImageExistsForURL:(NSURL *)url
                     completion:(SDWebImageCheckCacheCompletionBlock)completionBlock;

/**检查图片是否在磁盘中，检查结束后进行block操作*/
- (void)diskImageExistsForURL:(NSURL *)url
                   completion:(SDWebImageCheckCacheCompletionBlock)completionBlock;


/**根据url返回cache的key值*/
- (NSString *)cacheKeyForURL:(NSURL *)url;

@end


#pragma mark - Deprecated

typedef void(^SDWebImageCompletedBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType) __deprecated_msg("Block type deprecated. Use `SDWebImageCompletionBlock`");
typedef void(^SDWebImageCompletedWithFinishedBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) __deprecated_msg("Block type deprecated. Use `SDWebImageCompletionWithFinishedBlock`");


@interface SDWebImageManager (Deprecated)

/**
 *  Downloads the image at the given URL if not present in cache or return the cached version otherwise.
 *
 *  @deprecated This method has been deprecated. Use `downloadImageWithURL:options:progress:completed:`
 */
- (id <SDWebImageOperation>)downloadWithURL:(NSURL *)url
                                    options:(SDWebImageOptions)options
                                   progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                  completed:(SDWebImageCompletedWithFinishedBlock)completedBlock __deprecated_msg("Method deprecated. Use `downloadImageWithURL:options:progress:completed:`");

@end
