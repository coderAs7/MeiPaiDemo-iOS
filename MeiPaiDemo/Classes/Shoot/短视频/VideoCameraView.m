
#import "VideoCameraView.h"
#import "GPUImageBeautifyFilter.h"
#import "PrefixHeader.pch"
#import "RecordButton.h"
#import "RecordProgressView.h"


typedef NS_ENUM(NSUInteger, UploadVieoStyle) {
    VideoRecord = 0,
    VideoLocation,
};


@interface VideoCameraView ()
@property (nonatomic, strong) UIButton *beautifyButton;
@property (strong, nonatomic) UIButton *flashLightBT;
@property (strong, nonatomic)  UIButton *changeCameraBT;
@property (strong, nonatomic)  UIButton *recordNextBT;
@property (strong, nonatomic)  RecordButton *recordBt;
@property (strong, nonatomic)  UIButton *locationVideoBT;
@property (nonatomic, strong) UILabel *timeLabel;

@property (strong, nonatomic) RecordProgressView *progressView;
@property (assign, nonatomic) BOOL                    allowRecord;//允许录制
@property (assign, nonatomic) UploadVieoStyle         videoStyle;//视频的类型

@end

@implementation VideoCameraView

- (instancetype) initWithFrame:(CGRect)frame{
    if (!(self = [super initWithFrame:frame]))
    {
        return nil;
    }
    mainScreenFrame = frame;
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [videoCamera addAudioInputsAndOutputs];
    filter = [[GPUImageSaturationFilter alloc] init];
    filteredVideoView = [[GPUImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [videoCamera addTarget:filter];
    [filter addTarget:filteredVideoView];
    [videoCamera startCameraCapture];
    [self addSomeView];
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraViewTapAction:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    //[filteredVideoView addGestureRecognizer:singleFingerOne];
    [self addSubview:filteredVideoView];
    
    return self;
}

- (void)beautify {
    if (self.beautifyButton.selected) {
        self.beautifyButton.selected = NO;
        [videoCamera removeAllTargets];
        [videoCamera addTarget:filteredVideoView];
    }
    else {
        self.beautifyButton.selected = YES;
        [videoCamera removeAllTargets];
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        [videoCamera addTarget:beautifyFilter];
        [beautifyFilter addTarget:filteredVideoView];
    }
}

- (void) addSomeView{
    
    _beautifyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_beautifyButton.layer setCornerRadius:8];
    _beautifyButton.frame = CGRectMake(50, mainScreenFrame.size.height - 70.0, 50.0, 40.0);
    
  //  _beautifyButton.backgroundColor = [UIColor whiteColor];
    [_beautifyButton setTitle:@"开启" forState:UIControlStateNormal];
    [_beautifyButton setTitle:@"关闭" forState:UIControlStateSelected];
    [_beautifyButton addTarget:self action:@selector(beautify) forControlEvents:UIControlEventTouchUpInside];
    
        _beautifyButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_beautifyButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [filteredVideoView addSubview:_beautifyButton];
    
        _flashLightBT = [[UIButton alloc] init];
        [filteredVideoView addSubview:_flashLightBT];
        [_flashLightBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(24);
            make.top.mas_equalTo(filteredVideoView.mas_top).offset(20);
            make.centerX.mas_equalTo(filteredVideoView.mas_centerX).offset(-80);
        }];
        [_flashLightBT setImage:[UIImage imageNamed:@"flashlightOn"] forState:UIControlStateNormal];
        [_flashLightBT setImage:[UIImage imageNamed:@"flashlightOff"] forState:UIControlStateSelected];
       // [_flashLightBT addTarget:self action:@selector(flashLightAction:) forControlEvents:UIControlEventTouchUpInside];
    
        _changeCameraBT = [[UIButton alloc] init];
        [filteredVideoView addSubview:_changeCameraBT];
        [_changeCameraBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(24);
            make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
            make.left.mas_equalTo(_flashLightBT.mas_right).offset(60);
        }];
        [_changeCameraBT setImage:[UIImage imageNamed:@"changeCamera"] forState:UIControlStateNormal];
        //[_changeCameraBT addTarget:self action:@selector(changeCameraAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
        _recordNextBT = [[UIButton alloc] init];
        [filteredVideoView addSubview:_recordNextBT];
        [_recordNextBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
            make.right.mas_equalTo(filteredVideoView.mas_right).offset(-20);
        }];
        [_recordNextBT setImage:[UIImage imageNamed:@"videoNext"] forState:UIControlStateNormal];
       // [_recordNextBT addTarget:self action:@selector(recordNextAction:) forControlEvents:UIControlEventTouchUpInside];
    
        _closeBtn = [[UIButton alloc] init];
    
        [filteredVideoView addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
            make.left.mas_equalTo(filteredVideoView.mas_left).offset(20);
        }];
    
        [_closeBtn setImage:[UIImage imageNamed:@"closeVideo"] forState:UIControlStateNormal];

    _progressView = [[RecordProgressView alloc] initWithFrame:CGRectMake(0, filteredVideoView.bounds.size.height - 4, filteredVideoView.bounds.size.width, 4)];
        [filteredVideoView addSubview:_progressView];
    
        _recordBt = [[RecordButton alloc] initWithFrame:CGRectMake(170, 20, 80, 80)];
        [filteredVideoView addSubview:_recordBt];
        _recordBt.center = CGPointMake(filteredVideoView.center.x, filteredVideoView.bounds.size.height - 80);
        _recordBt.type = LeafButtonTypeVideo;
        __weak typeof(self) weakSelf = self;
        _recordBt.clickedBlock = ^(RecordButton *button) {
            [weakSelf recordAction:weakSelf.recordBt];
        };
    
        _locationVideoBT = [[UIButton alloc] init];
        [filteredVideoView addSubview:_locationVideoBT];
        [_locationVideoBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(44);
            make.centerY.mas_equalTo(_recordBt.mas_centerY);
            make.centerX.mas_equalTo(filteredVideoView.mas_centerX).offset(filteredVideoView.bounds.size.width / 4);
        }];
    
        [_locationVideoBT setImage:[UIImage imageNamed:@"locationVideo"] forState:UIControlStateNormal];
    
        //[_locationVideoBT addTarget:self action:@selector(locationVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    
        //self.allowRecord = YES;
    
        _timeLabel = [[UILabel alloc] init];
        [filteredVideoView addSubview:_timeLabel];
        _timeLabel.layer.cornerRadius = 6;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.clipsToBounds = YES;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:10];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(filteredVideoView.mas_right).offset(-20);
            make.bottom.mas_equalTo(filteredVideoView.mas_bottom).offset(-20);
            make.height.mas_equalTo(24);
            make.width.mas_equalTo(40);
        }];
}

//开始和暂停录制事件
- (void)recordAction:(RecordButton *)sender {
    //if (self.allowRecord) {
       // self.videoStyle = VideoRecord;
        if (self.recordBt.state == LeafButtonStateSelected) {

            [self hiddenButton:YES];
            [self startRecording:sender];
        }else {
            [self hiddenButton:NO];
            [self stopRecording:sender];
        }
        
   // }
}

- (void)hiddenButton:(BOOL)value {
    _recordNextBT.hidden = value;
    _changeCameraBT.hidden = value;
    _closeBtn.hidden = value;
    _locationVideoBT.hidden = value;
}

- (void)updateSliderValue:(id)sender
{
    //调整图像的饱和度
    [(GPUImageSaturationFilter *)filter setSaturation:[(UISlider *)sender value]];
}

- (void)stopRecording:(id)sender {

   // videoCamera.audioEncodingTarget = nil;
   // [movieWriter finishRecording];
    //[filter removeTarget:movieWriter];

}

- (void)startRecording:(id)sender {

    //    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(360.0, 640.0)];
//    
//    movieWriter.encodingLiveVideo = YES;
//    movieWriter.shouldPassthroughAudio = YES;
//    [filter addTarget:movieWriter];
    //videoCamera.audioEncodingTarget = movieWriter;
    //[movieWriter startRecording];
}

- (void)setfocusImage{
    UIImage *focusImage = [UIImage imageNamed:@"camera_focus_bg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, focusImage.size.width, focusImage.size.height)];
    imageView.image = focusImage;
    CALayer *layer = imageView.layer;
    layer.hidden = YES;
    [filteredVideoView.layer addSublayer:layer];
    _focusLayer = layer;
}

- (void)layerAnimationWithPoint:(CGPoint)point {
    if (_focusLayer) {
        CALayer *focusLayer = _focusLayer;
        focusLayer.hidden = NO;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [focusLayer setPosition:point];
        focusLayer.transform = CATransform3DMakeScale(1.5f,1.5f,1.0f);
        [CATransaction commit];
        
        
        CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
        animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0f,1.0f,1.0f)];
        animation.delegate = self;
        animation.duration = 0.3f;
        animation.repeatCount = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [focusLayer addAnimation: animation forKey:@"animation"];
        
        // 0.5秒钟延时
        [self performSelector:@selector(focusLayerNormal) withObject:self afterDelay:0.5f];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
}


- (void)focusLayerNormal {
    filteredVideoView.userInteractionEnabled = YES;
    _focusLayer.hidden = YES;
}


-(void)cameraViewTapAction:(UITapGestureRecognizer *)tgr
{
    if (tgr.state == UIGestureRecognizerStateRecognized && (_focusLayer == NO || _focusLayer.hidden)) {
        CGPoint location = [tgr locationInView:filteredVideoView];
        [self setfocusImage];
        [self layerAnimationWithPoint:location];
        AVCaptureDevice *device = videoCamera.inputCamera;
        CGPoint pointOfInterest = CGPointMake(0.5f, 0.5f);
        NSLog(@"taplocation x = %f y = %f", location.x, location.y);
        CGSize frameSize = [filteredVideoView frame].size;
        
        if ([videoCamera cameraPosition] == AVCaptureDevicePositionFront) {
            location.x = frameSize.width - location.x;
        }
        
        pointOfInterest = CGPointMake(location.y / frameSize.height, 1.f - (location.x / frameSize.width));
        
        
        if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            NSError *error;
            if ([device lockForConfiguration:&error]) {
                [device setFocusPointOfInterest:pointOfInterest];
                
                [device setFocusMode:AVCaptureFocusModeAutoFocus];
                
                if([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
                {
                    
                    
                    [device setExposurePointOfInterest:pointOfInterest];
                    [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
                }
                
                [device unlockForConfiguration];
                
                NSLog(@"FOCUS OK");
            } else {
                NSLog(@"ERROR = %@", error);
            }
        }
    }
}

@end
