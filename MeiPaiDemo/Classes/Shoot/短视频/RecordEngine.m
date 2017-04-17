//
//  MPRecordEngine.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "RecordEngine.h"
#import "RecordEncoder.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface RecordEngine ()<AVCaptureAudioDataOutputSampleBufferDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, CAAnimationDelegate> {
    
    CMTime _timeOffset;
    
    CMTime _lastVideo;
}

@end
@implementation RecordEngine

@end
