//
//  RecordEncoder.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "RecordEncoder.h"

@interface RecordEncoder ()

@property (nonatomic, strong) AVAssetWriter *writer;

@property (nonatomic, strong) AVAssetWriterInput *videoInput;

@property (nonatomic, strong) AVAssetWriterInput *audioInput;

@property (nonatomic, strong) NSString *path;

@end

@implementation RecordEncoder

+ (RecordEncoder *)encoderForPath:(NSString *)path height:(NSInteger)y width:(NSInteger)x channels:(int)h samples:(Float64)rate {
    RecordEncoder *encoder = [RecordEncoder alloc];
    
    return [encoder initPath:path height:y width:x channels:h samples:rate];
}

- (instancetype)initPath:(NSString *)path height:(NSInteger)y width:(NSInteger)w channels:(int)h
                 samples:(Float64)rate {
    if (self = [super init]) {
        self.path = path;
        [[NSFileManager defaultManager] removeItemAtPath:self.path error:nil];
        
        NSURL *url = [NSURL fileURLWithPath:self.path];
        _writer = [AVAssetWriter assetWriterWithURL:url fileType:AVFileTypeMPEG4 error:nil];
        _writer.shouldOptimizeForNetworkUse = YES;
        
        if (rate != 0 && h != 0) {
            [self initAudioInputChannels:h samples:rate];
        }
    }
    return self;
}

- (void)initVideoInputHeight:(NSInteger)y width:(NSInteger)x {
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey,
                              [NSNumber numberWithInteger:x], AVVideoWidthKey,
                              [NSNumber numberWithInteger:y], AVVideoHeightKey, nil];
    _videoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:settings];
    _videoInput.expectsMediaDataInRealTime = YES;
    [_writer addInput:_videoInput];
}

- (void)initAudioInputChannels:(int)h samples:(Float64)rate {

    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey, //音乐格式
        [NSNumber numberWithInt:h], AVNumberOfChannelsKey,//音乐通道数
                              
        [NSNumber numberWithFloat:rate], AVSampleRateKey,//音乐采样率
                              
        [NSNumber numberWithInt:128000], AVEncoderBitRateKey,//音频比特率
                              nil];
    
    _audioInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:settings];
    _audioInput.expectsMediaDataInRealTime = YES;
    [_writer addInput:_audioInput];
}

- (void)finishWithCompletionHandler:(void (^)(void))handler {
    [_writer finishWritingWithCompletionHandler:handler];
}

- (BOOL)encoderFrame:(CMSampleBufferRef) sampleBuffer isVideo:(BOOL)isVideo {
    if (CMSampleBufferDataIsReady(sampleBuffer)) {
        if (_writer.status == AVAssetWriterStatusUnknown && isVideo) {
            CMTime startTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
            [_writer startWriting];
            [_writer startSessionAtSourceTime:startTime];
        }
        if (_writer.status == AVAssetWriterStatusFailed) {
            //
            return NO;
        }
        if (isVideo) {
            if (_videoInput.readyForMoreMediaData == YES) {
                [_videoInput appendSampleBuffer:sampleBuffer];
                return YES;
            }
        } else {
            if (_audioInput.readyForMoreMediaData == YES) {
                [_audioInput appendSampleBuffer:sampleBuffer];
                return YES;
            }
        }
    }
    return NO;
}

- (void)dealloc {
    _writer = nil;
    _videoInput = nil;
    _audioInput = nil;
    _path = nil;
}

@end
