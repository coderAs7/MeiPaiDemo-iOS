//
//  RecordEncoder.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordEncoder : NSObject

@property (nonatomic, readonly) NSString *path;

+ (RecordEncoder *)encoderForPath:(NSString *)path height:(NSInteger)y width:(NSInteger)x channels:(int)h samples:(Float64)rate;

- (instancetype)initPath:(NSString *)path height:(NSInteger)y width:(NSInteger)w channels:(int)h
                 samples:(Float64)rate;

- (void)finishWithCompletionHandler:(void (^)(void))handler ;

- (BOOL)encoderFrame:(CMSampleBufferRef) sampleBuffer isVideo:(BOOL)isVideo;

@end
