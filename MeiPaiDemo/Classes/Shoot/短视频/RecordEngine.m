//
//  RecordEngine.m
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
    
    CMTime _lastAudio;
    
    NSInteger _x;
    
    NSInteger _y;
    
    int _channels;
    
    Float64 _samplerate;
}

@property (nonatomic, strong) RecordEncoder *recordEncoder;

@property (nonatomic, strong) AVCaptureSession *recordSession;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) AVCaptureDeviceInput *backCameraInput;

@property (nonatomic, strong) AVCaptureDeviceInput *frontCameraInput;

@property (nonatomic, strong) AVCaptureDeviceInput *audioMicInput;

@property (nonatomic, copy)   dispatch_queue_t captureQueue;

@property (nonatomic, strong) AVCaptureConnection *audioConnection;

@property (nonatomic, strong) AVCaptureConnection *videoConnection;

@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;

@property (nonatomic, strong) AVCaptureAudioDataOutput *audioOutput;

@property (atomic, assign)    BOOL isCapturing;//正在录制

@property (atomic, assign)    BOOL isPaused;//是否暂停

@property (atomic, assign)    BOOL discont;//是否中断

@property (atomic, assign)    CMTime startTime;//开始录制的时间

@property (atomic, assign)    CGFloat currentRecordTime;//当前录制时间

@end

@implementation RecordEngine

- (void)dealloc {
    [_recordSession stopRunning];
    _captureQueue     = nil;
    _recordSession    = nil;
    _previewLayer     = nil;
    _backCameraInput  = nil;
    _frontCameraInput = nil;
    _audioOutput      = nil;
    _videoOutput      = nil;
    _audioConnection  = nil;
    _videoConnection  = nil;
    _recordEncoder    = nil;
}

- (instancetype)init {
    if (self = [super init]) {
        self.maxRecordTime = 60.0f;
    }
    return self;
}

- (void)startRecord {
    self.startTime = CMTimeMake(0, 0);
    self.isCapturing = NO;
    self.isPaused = NO;
    self.discont = NO;
    [self.recordSession startRunning];
}

- (void)shutDownRecord {
    _startTime = CMTimeMake(0, 0);
    if (_recordSession) {
        [_recordSession stopRunning];
    }
    [_recordEncoder finishWithCompletionHandler:^{
        
    }];
}

- (void)startCapture {
    @synchronized (self) {
        if (!self.isCapturing) {
            self.recordEncoder = nil;
            self.isPaused = NO;
            self.discont = NO;
            _timeOffset = CMTimeMake(0, 0);
            self.isCapturing = YES;
        }
    }
}

- (void)pauseCapture {
    @synchronized (self) {
        if (self.isCapturing) {
            self.isPaused = YES;
            self.discont = YES;
        }
    }
}

- (void)resumeCapture {
    @synchronized (self) {
        if (self.isPaused) {
            self.isPaused = NO;
        }
    }
}

- (void)stopCaptureHandler:(void (^)(UIImage *))handler {
    @synchronized (self) {
        if (self.isCapturing) {
            NSString *path = self.recordEncoder.path;
            NSURL *url = [NSURL fileURLWithPath:path];
            self.isCapturing = NO;
            dispatch_async(_captureQueue, ^{
               [self.recordEncoder finishWithCompletionHandler:^{
                   self.isCapturing = NO;
                   self.recordEncoder = nil;
                   self.startTime = CMTimeMake(0, 0);
                   self.currentRecordTime = 0;
                   if ([self.delegate respondsToSelector:@selector(recordProgress:)]) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [self.delegate recordProgress:self.currentRecordTime / self.maxRecordTime];
                       });
                   }
                   [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                       [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
                   } completionHandler:^(BOOL success, NSError * _Nullable error) {
                       //
                   }];
                   [self movieToImageHandler:handler];
               }];
            });
        }
    }
}

- (void)movieToImageHandler:(void (^)(UIImage *movieImage))handler {
    NSURL *url = [NSURL fileURLWithPath:self.videoPath];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = TRUE;
    CMTime thumbTime = CMTimeMakeWithSeconds(0, 60);
    generator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    AVAssetImageGeneratorCompletionHandler generatorHandler = ^(CMTime requestedTime, CGImageRef img, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error) {
        if (result == AVAssetImageGeneratorSucceeded) {
            UIImage *thumbImg = [UIImage imageWithCGImage:img];
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(thumbImg);
                });
            }
        }
    };
    [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:generatorHandler];
}

- (AVCaptureSession *)recordSession {
    if (_recordSession == nil) {
        _recordSession = [[AVCaptureSession alloc] init];
        if ([_recordSession canAddInput:self.backCameraInput]) {
            [_recordSession addInput:self.backCameraInput];
        }
        if ([_recordSession canAddInput:self.audioMicInput]) {
            [_recordSession addInput:self.audioMicInput];
        }
        if ([_recordSession canAddOutput:self.videoOutput]) {
            [_recordSession addOutput:self.videoOutput];
            _x = 720;
            _y = 1280;
        }
        if ([_recordSession canAddOutput:self.audioOutput]) {
            [_recordSession addOutput:self.audioOutput];
        }
        self.videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    }
    return _recordSession;
}

- (AVCaptureDeviceInput *)backCameraInput {
    if (_backCameraInput == nil) {
        NSError *error;
        _backCameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        if (error) {
            //
        }
        
    }
    return _backCameraInput;
}

- (AVCaptureDevice *)backCamera {
   return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (AVCaptureDeviceInput *)frontCameraInput {
    if (_frontCameraInput == nil) {
        NSError *error;
        _frontCameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        if (error) {
            //
        }
    }
    return _frontCameraInput;
}

- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

//用来返回是前置摄像头还是后置摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    //返回和视频录制相关的所有默认设备
//    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    //遍历这些设备返回跟position相关的设备
//    for (AVCaptureDevice *device in devices) {
//        if ([device position] == position) {
//            return device;
//        }
//    }
    AVCaptureDeviceDiscoverySession *devicesIOS10 = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:position];
    NSArray *deviceIOS10 = devicesIOS10.devices;
    for (AVCaptureDevice *device in deviceIOS10) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDeviceInput *)audioMicInput {
    if (_audioMicInput == nil) {
        AVCaptureDevice *mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        NSError *error;
        _audioMicInput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:&error];
        if (error) {
            //
        }
    }
    return _audioMicInput;
}

- (AVCaptureVideoDataOutput *)videoOutput {
    if (_videoOutput == nil) {
        _videoOutput = [[AVCaptureVideoDataOutput alloc] init];
        [_videoOutput setSampleBufferDelegate:self queue:self.captureQueue];
        NSDictionary *setCapSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange], kCVPixelBufferPixelFormatTypeKey, nil];
        _videoOutput.videoSettings = setCapSettings;
    }
    return _videoOutput;
}

- (AVCaptureAudioDataOutput *)audioOutput {
    if (_audioOutput == nil) {
        _audioOutput = [[AVCaptureAudioDataOutput alloc] init];
        [_audioOutput setSampleBufferDelegate:self queue:self.captureQueue];
    }
    return _audioOutput;
}

- (AVCaptureConnection *)videoConnection {
    if (_videoConnection == nil) {
        _videoConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
    }
    return _videoConnection;
}

- (AVCaptureConnection *)audioConnection {
    if (_audioConnection == nil) {
        _audioConnection = [self.audioOutput connectionWithMediaType:AVMediaTypeAudio];
    }
    return _audioConnection;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (_previewLayer == nil) {
        AVCaptureVideoPreviewLayer *preview = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.recordSession];
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer = preview;
    }
    return _previewLayer;
}

- (dispatch_queue_t)captureQueue {
    if (_captureQueue == nil) {
        _captureQueue = dispatch_queue_create("cn.jackli.im.recordengine.capture", DISPATCH_QUEUE_SERIAL);
    }
    return _captureQueue;
}

- (void)changeCameraAnimation {
    CATransition *changeAnimation = [CATransition animation];
    changeAnimation.delegate = self;
    changeAnimation.duration = 0.45;
    changeAnimation.type = @"oglFlip";
    changeAnimation.subtype = kCATransitionFromRight;
    changeAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
    [self.previewLayer addAnimation:changeAnimation forKey:@"changeAnimation"];
}

- (void)animationDidStart:(CAAnimation *)animation {
    self.videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    [self.recordSession startRunning];
}

- (void)changeMovToMp4:(NSURL *)mediaURL dataBlock:(void (^)(UIImage *))handler {
    AVAsset *video = [AVAsset assetWithURL:mediaURL];
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:video presetName:AVAssetExportPreset1280x720];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputFileType = AVFileTypeMPEG4;
    NSString *basePath = [self getVideoCachePath];
    self.videoPath = [basePath stringByAppendingPathComponent:[self getUploadFile_type:@"video" fileType:@"mp4"]];
    exportSession.outputURL = [NSURL fileURLWithPath:self.videoPath];
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        [self movieToImageHandler:handler];
    }];
}

- (NSString *)getVideoCachePath {
    NSString *videoCache = [NSTemporaryDirectory() stringByAppendingPathComponent:@"videos"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if (!(isDir == YES && existed == YES)) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return videoCache;
}


- (NSString *)getUploadFile_type:(NSString *)type fileType:(NSString *)fileType {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString *timeStr = [formatter stringFromDate:nowDate];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.%@", type, timeStr, fileType];
    return fileName;
}

- (void)changeCameraInputDeviceisFront:(BOOL)isFront {
    if (isFront) {
        [self.recordSession stopRunning];
        [self.recordSession removeInput:self.backCameraInput];
        if ([self.recordSession canAddInput:self.frontCameraInput]) {
            [self changeCameraAnimation];
            [self.recordSession addInput:self.frontCameraInput];
        }
    }else {
        [self.recordSession stopRunning];
        [self.recordSession removeInput:self.frontCameraInput];
        if ([self.recordSession canAddInput:self.backCameraInput]) {
            [self changeCameraAnimation];
            [self.recordSession addInput:self.backCameraInput];
        }
    }
}

- (void)openFlashLight {
    AVCaptureDevice *backCamera = [self backCamera];
    if (backCamera.torchMode == AVCaptureTorchModeOff) {
        [backCamera lockForConfiguration:nil];
        backCamera.torchMode = AVCaptureTorchModeOn;
        backCamera.flashMode = AVCaptureFlashModeOn;
        [backCamera unlockForConfiguration];
    }
}

- (void)closeFlashLight {
    AVCaptureDevice *backCamera = [self backCamera];
    if (backCamera.torchMode == AVCaptureTorchModeOn) {
        [backCamera lockForConfiguration:nil];
        backCamera.torchMode = AVCaptureTorchModeOff;
        backCamera.flashMode = AVCaptureFlashModeOff;
        [backCamera unlockForConfiguration];
    }
}

//- (NSString *)getVideoCachePath {
//    NSString *videoCache = [NSTemporaryDirectory() stringByAppendingPathComponent:@"videos"];
//    BOOL isDir = NO;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//}






@end
