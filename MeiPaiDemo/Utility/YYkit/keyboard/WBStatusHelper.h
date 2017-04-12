//
//  WBFeedHelper.h
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "YYKit.h"
#import "WBModel.h"

/**
 很多都写死单例了，毕竟只是 Demo。。
 */
@interface WBStatusHelper : NSObject

/// 微博图片资源 bundle
+ (NSBundle *)bundle;

/// 微博表情资源 bundle
+ (NSBundle *)emoticonBundle;

/// 微博表情 Array<WBEmotionGroup> (实际应该做成动态更新的)
+ (NSArray *)emoticonGroups;

/// 微博图片 cache
//+ (YYMemoryCache *)imageCache;

/// 从微博 bundle 里获取图片 (有缓存)
+ (UIImage *)imageNamed:(NSString *)name;

/// 从path创建图片 (有缓存)
+ (UIImage *)imageWithPath:(NSString *)path;




///// 表情正则 例如 [偷笑]
+ (NSRegularExpression *)regexEmoticon;
//
///// 表情字典 key:[偷笑] value:ImagePath
+ (NSDictionary *)emoticonDic;

@end
