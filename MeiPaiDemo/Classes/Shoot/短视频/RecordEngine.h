//
//  MPRecordEngine.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>

@protocol RecordEngineDelagate <NSObject>

- (void)recordProgress:(CGFloat)progress;

@end

@interface RecordEngine : NSObject

@property (atomic, assign, readonly) BOOL isCapturing;

@property (atomic, assign, readonly) BOOL isPaused;

@property (atomic, assign, readonly) CGFloat currentRecordTime;

@property (atomic, assign) CGFloat maxRecordTime;

@property (atomic, strong) NSString *videoPath;

@property (weak, nonatomic) id <RecordEngineDelagate> delegate;


- (AVCaptureVideoPreviewLayer *)previewLayer;

- (void)startRecord;

- (void)shutDownRecord;

- (void)startCapture;

- (void)pauseCapture;

- (void)stopCaptureHandler:(void (^)(UIImage *movieImage))handler;

- (void)resumeCapture;

- (void)openFlashLight;

- (void)closeFlashLight;

- (void)changeCameraInputDeviceisFront:(BOOL)idFront;

- (void)changeMovToMp4:(NSURL *)mediaURL dataBlock:(void (^)(UIImage *movieImage))handler;

@end
