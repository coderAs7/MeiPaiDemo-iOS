//
//  ShortVideoController.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "ShortVideoController.h"
#import "RecordEngine.h"
#import "RecordProgressView.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PrefixHeader.pch"

typedef NS_ENUM(NSUInteger, UploadVieoStyle) {
    VideoRecord = 0,
    VideoLocation,
};


@interface ShortVideoController ()<RecordEngineDelagate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIButton *flashLightBT;
@property (strong, nonatomic)  UIButton *changeCameraBT;
@property (strong, nonatomic)  UIButton *recordNextBT;
@property (strong, nonatomic)  UIButton *recordBt;
@property (strong, nonatomic)  UIButton *locationVideoBT;
@property (strong, nonatomic) RecordProgressView *progressView;

@property (strong, nonatomic) RecordEngine         *recordEngine;
@property (assign, nonatomic) BOOL                    allowRecord;//允许录制
@property (assign, nonatomic) UploadVieoStyle         videoStyle;//视频的类型
@property (strong, nonatomic) UIImagePickerController *moviePicker;//视频选择器
@property (strong, nonatomic) AVPlayerViewController *playerVC;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIView *topView;

@end

@implementation ShortVideoController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _topView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_topView];
    _topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(48);
    }];
    
    _flashLightBT = [[UIButton alloc] init];
    [_topView addSubview:_flashLightBT];
    [_flashLightBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_topView.mas_centerY);
        make.centerX.mas_equalTo(_topView.mas_centerX).offset(-80);
    }];
    [_flashLightBT setImage:[UIImage imageNamed:@"flashlightOn"] forState:UIControlStateNormal];
    [_flashLightBT setImage:[UIImage imageNamed:@"flashlightOff"] forState:UIControlStateSelected];
    [_flashLightBT addTarget:self action:@selector(flashLightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _changeCameraBT = [[UIButton alloc] init];
    [_topView addSubview:_changeCameraBT];
    [_changeCameraBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
        make.left.mas_equalTo(_flashLightBT.mas_right).offset(60);
    }];
    [_changeCameraBT setImage:[UIImage imageNamed:@"changeCamera"] forState:UIControlStateNormal];
    [_changeCameraBT addTarget:self action:@selector(changeCameraAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _recordNextBT = [[UIButton alloc] init];
    [_topView addSubview:_recordNextBT];
    [_recordNextBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
        make.right.mas_equalTo(_topView.mas_right).offset(-20);
    }];
    [_recordNextBT setImage:[UIImage imageNamed:@"videoNext"] forState:UIControlStateNormal];
    [_recordNextBT addTarget:self action:@selector(recordNextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeBtn = [[UIButton alloc] init];

    [_topView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
        make.left.mas_equalTo(_topView.mas_left).offset(20);
    }];

    [closeBtn setImage:[UIImage imageNamed:@"closeVideo"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    _progressView = [[RecordProgressView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 104, self.view.bounds.size.width, 4)];
    [self.view addSubview:_progressView];
    _recordBt = [[UIButton alloc] init];
    [bottomView addSubview:_recordBt];
    [_recordBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.centerX.mas_equalTo(bottomView.mas_centerX);
    }];

    [_recordBt setImage:[UIImage imageNamed:@"videoRecord"] forState:UIControlStateNormal];
    [_recordBt setImage:[UIImage imageNamed:@"videoPause"] forState:UIControlStateSelected];
    [_recordBt addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _locationVideoBT = [[UIButton alloc] init];
    [bottomView addSubview:_locationVideoBT];
    [_locationVideoBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.centerX.mas_equalTo(bottomView.mas_centerX).offset(80);
    }];
    

    [_locationVideoBT setImage:[UIImage imageNamed:@"locationVideo"] forState:UIControlStateNormal];
    
    [_locationVideoBT addTarget:self action:@selector(locationVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.allowRecord = YES;
}


- (void)dealloc {
    _recordEngine = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.recordEngine shutdown];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_recordEngine == nil) {
        [self.recordEngine previewLayer].frame = self.view.bounds;
        [self.view.layer insertSublayer:[self.recordEngine previewLayer] atIndex:0];
    }
    [self.recordEngine startUp];
}

//根据状态调整view的展示情况
//- (void)adjustViewFrame {
//    //[self.view layoutIfNeeded];
//    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        if (self.recordBt.selected) {
//            _topView.frame = CGRectMake(0, -48, self.view.bounds.size.width, 48);
//        }else {
//            _topView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 48);
//        }
//        if (self.videoStyle == VideoRecord) {
//            self.locationVideoBT.hidden = YES;
//        }
//        [self.view layoutIfNeeded];
//    } completion:nil];
//}

#pragma mark - set、get方法
- (RecordEngine *)recordEngine {
    if (_recordEngine == nil) {
        _recordEngine = [[RecordEngine alloc] init];
        _recordEngine.delegate = self;
    }
    return _recordEngine;
}

- (UIImagePickerController *)moviePicker {
    if (_moviePicker == nil) {
        _moviePicker = [[UIImagePickerController alloc] init];
        _moviePicker.delegate = self;
        _moviePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _moviePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
    }
    return _moviePicker;
}

#pragma mark - Apple相册选择代理
//选择了某个照片的回调函数/代理回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie]) {
        //获取视频的名称
        NSString * videoPath=[NSString stringWithFormat:@"%@",[info objectForKey:UIImagePickerControllerMediaURL]];
        NSRange range =[videoPath rangeOfString:@"trim."];//匹配得到的下标
        NSString *content=[videoPath substringFromIndex:range.location+5];
        //视频的后缀
        NSRange rangeSuffix=[content rangeOfString:@"."];
        NSString * suffixName=[content substringFromIndex:rangeSuffix.location+1];
        //如果视频是mov格式的则转为MP4的
        if ([suffixName isEqualToString:@"MOV"]) {
            NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
            __weak typeof(self) weakSelf = self;
            [self.recordEngine changeMovToMp4:videoUrl dataBlock:^(UIImage *movieImage) {
                
                [weakSelf.moviePicker dismissViewControllerAnimated:YES completion:^{
                    weakSelf.playerVC = [[AVPlayerViewController alloc] init];
                    
                    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:weakSelf.recordEngine.videoPath]];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player];
                    weakSelf.player = [[AVPlayer alloc] initWithPlayerItem:item];
                    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
                    
                    layer.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
                    layer.backgroundColor = [UIColor blackColor].CGColor;
                    layer.videoGravity = AVLayerVideoGravityResize;
                    //weakSelf.playerVC.view.translatesAutoresizingMaskIntoConstraints = YES;
                    [weakSelf presentViewController:self.playerVC animated:YES completion:nil];
                    [self.player play];
                    
                }];
            }];
        }
    }
}

#pragma mark - RecordEngineDelegate
- (void)recordProgress:(CGFloat)progress {
    if (progress >= 1) {
        [self recordAction:self.recordBt];
        self.allowRecord = NO;
    }
    self.progressView.progressValue = progress;
}

#pragma mark - 各种点击事件
//返回点击事件
- (void)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开关闪光灯
- (void)flashLightAction:(id)sender {
    if (self.changeCameraBT.selected == NO) {
        self.flashLightBT.selected = !self.flashLightBT.selected;
        if (self.flashLightBT.selected == YES) {
            [self.recordEngine openFlashLight];
        }else {
            [self.recordEngine closeFlashLight];
        }
    }
}

//切换前后摄像头
- (void)changeCameraAction:(id)sender {
    self.changeCameraBT.selected = !self.changeCameraBT.selected;
    if (self.changeCameraBT.selected == YES) {
        //前置摄像头
        [self.recordEngine closeFlashLight];
        self.flashLightBT.selected = NO;
        [self.recordEngine changeCameraInputDeviceisFront:YES];
    }else {
        [self.recordEngine changeCameraInputDeviceisFront:NO];
    }
}

//录制下一步点击事件
- (void)recordNextAction:(UIButton *)sender {
    if (_recordEngine.videoPath.length > 0) {
        __weak typeof(self) weakSelf = self;
        
        [self.recordEngine stopCaptureHandler:^(UIImage *movieImage) {
            weakSelf.playerVC = [[AVPlayerViewController alloc] init];
            
            AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:weakSelf.recordEngine.videoPath]];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player];
            weakSelf.player = [[AVPlayer alloc] initWithPlayerItem:item];
            AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
            
            layer.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
            layer.backgroundColor = [UIColor blackColor].CGColor;
            layer.videoGravity = AVLayerVideoGravityResize;
            weakSelf.playerVC.view.translatesAutoresizingMaskIntoConstraints = YES;
            [weakSelf presentViewController:self.playerVC animated:YES completion:nil];
            [self.player play];
            
        }];
        
    }else {
//        [PromptView showInWindow:@"请先录制视频"];
    }
}

//当点击Done按键或者播放完毕时调用此函数
- (void) playVideoFinished:(NSNotification *)theNotification {
    // AVPlayerViewController *vc = [theNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player];
    [self.player pause];
    [self.playerVC dismissViewControllerAnimated:YES completion:nil];
    self.playerVC = nil;
}

//本地视频点击视频
- (void)locationVideoAction:(id)sender {
    self.videoStyle = VideoLocation;
    [self.recordEngine shutdown];
    [self presentViewController:self.moviePicker animated:YES completion:nil];
}

//开始和暂停录制事件
- (void)recordAction:(UIButton *)sender {
    if (self.allowRecord) {
        self.videoStyle = VideoRecord;
        self.recordBt.selected = !self.recordBt.selected;
        if (self.recordBt.selected) {
            if (self.recordEngine.isCapturing) {
                [self.recordEngine resumeCapture];
            }else {
                [self.recordEngine startCapture];
            }
        }else {
            [self.recordEngine pauseCapture];
        }
       // [self adjustViewFrame];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
