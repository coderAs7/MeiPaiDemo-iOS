/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"
#import "SDWebImageOperation.h"

typedef NS_OPTIONS(NSUInteger, SDWebImageDownloaderOptions) {
    SDWebImageDownloaderLowPriority = 1 << 0,
    SDWebImageDownloaderProgressiveDownload = 1 << 1,
    
    /**
     * 默认，request不使用NSURLCache。如果设置该选项，则以默认的缓存策略来使用NSURLCache
     */
    SDWebImageDownloaderUseNSURLCache = 1 << 2,
    
    /**
     * 如果从NSURLCache缓存中读取图片，则使用nil传递给imageData参数来调用完成block
     */
    
    SDWebImageDownloaderIgnoreCachedResponse = 1 << 3,
    /**
     * 在iOS 4+系统中，允许程序进入后台继续下载图片。该操作通过向系统申请额外的时间来完成后台下载。如果后台任务超时，则此操作会被取消。
     */
    
    SDWebImageDownloaderContinueInBackground = 1 << 4,
    
    /**
     * 通过设置NSMutableURLRequest.HTTPShouldHandleCookies = YES来处理存储在NSHTTPCookieStore中的cookie
     */
    SDWebImageDownloaderHandleCookies = 1 << 5,
    
    /**
     * 设置允许非信任的SSL证书。主要用于测试目的
     */
    SDWebImageDownloaderAllowInvalidSSLCertificates = 1 << 6,
    
    /**
     * 将图像下载放到高优先级队列中
     */
    SDWebImageDownloaderHighPriority = 1 << 7,
};

typedef NS_ENUM(NSInteger, SDWebImageDownloaderExecutionOrder) {
    /**先进先出*/
    SDWebImageDownloaderFIFOExecutionOrder,
    
    /**后进先出*/
    SDWebImageDownloaderLIFOExecutionOrder
};

extern NSString *const SDWebImageDownloadStartNotification;
extern NSString *const SDWebImageDownloadStopNotification;

/**progressBlock在图片正在下载的时候进行处理,对于下载进度进行反馈--下载进度*/
typedef void(^SDWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

/**completedBlock当图片下载完成后进行的处理,完成后对图片和数据进行处理，如果出错，则进行出错处理--下载完成*/
typedef void(^SDWebImageDownloaderCompletedBlock)(UIImage *image, NSData *data, NSError *error, BOOL finished);
/**headers过滤*/
typedef NSDictionary *(^SDWebImageDownloaderHeadersFilterBlock)(NSURL *url, NSDictionary *headers);

/**
 * Asynchronous downloader dedicated and optimized for image loading.
 */
@interface SDWebImageDownloader : NSObject

/**与cache相同,默认YES*/
@property (assign, nonatomic) BOOL shouldDecompressImages;

/**最大下载线程数*/
@property (assign, nonatomic) NSInteger maxConcurrentDownloads;

/**当前下载线程数*/
@property (readonly, nonatomic) NSUInteger currentDownloadCount;


/**下载时间限制,默认15秒*/
@property (assign, nonatomic) NSTimeInterval downloadTimeout;


/**下载方式，即FIFO、LIFO,默认SDWebImageDownloaderFIFOExecutionOrder*/
@property (assign, nonatomic) SDWebImageDownloaderExecutionOrder executionOrder;

/**
 *  Singleton method, returns the shared instance
 *
 *  @return global shared instance of downloader class
 */
+ (SDWebImageDownloader *)sharedDownloader;

/**
 * Set username
 */
@property (strong, nonatomic) NSString *username;

/**
 * Set password
 */
@property (strong, nonatomic) NSString *password;

/**
 * Set filter to pick headers for downloading image HTTP request.
 *
 * This block will be invoked for each downloading image request, returned
 * NSDictionary will be used as headers in corresponding HTTP request.
 */
@property (nonatomic, copy) SDWebImageDownloaderHeadersFilterBlock headersFilter;

/**
 * Set a value for a HTTP header to be appended to each download HTTP request.
 *
 * @param value The value for the header field. Use `nil` value to remove the header.
 * @param field The name of the header field to set.
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 * Returns the value of the specified HTTP header field.
 *
 * @return The value associated with the header field field, or `nil` if there is no corresponding header field.
 */
- (NSString *)valueForHTTPHeaderField:(NSString *)field;

/**
 * Sets a subclass of `SDWebImageDownloaderOperation` as the default
 * `NSOperation` to be used each time SDWebImage constructs a request
 * operation to download an image.
 *
 * @param operationClass The subclass of `SDWebImageDownloaderOperation` to set
 *        as default. Passing `nil` will revert to `SDWebImageDownloaderOperation`.
 */
- (void)setOperationClass:(Class)operationClass;

/***/
- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url
                                         options:(SDWebImageDownloaderOptions)options
                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                       completed:(SDWebImageDownloaderCompletedBlock)completedBlock;

/**
 * Sets the download queue suspension state
 */
- (void)setSuspended:(BOOL)suspended;

@end
