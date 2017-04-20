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
#import "RecordButton.h"

typedef NS_ENUM(NSUInteger, UploadVieoStyle) {
    VideoRecord = 0,
    VideoLocation,
};


@interface ShortVideoController ()<RecordEngineDelagate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIButton *flashLightBT;
@property (strong, nonatomic)  UIButton *changeCameraBT;
@property (strong, nonatomic)  UIButton *recordNextBT;
@property (strong, nonatomic)  RecordButton *recordBt;
@property (strong, nonatomic)  UIButton *locationVideoBT;
@property (strong, nonatomic) RecordProgressView *progressView;

@property (strong, nonatomic) RecordEngine         *recordEngine;
@property (assign, nonatomic) BOOL                    allowRecord;//允许录制
@property (assign, nonatomic) UploadVieoStyle         videoStyle;//视频的类型
@property (strong, nonatomic) UIImagePickerController *moviePicker;//视频选择器
@property (strong, nonatomic) AVPlayerViewController *playerVC;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation ShortVideoController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    
    _flashLightBT = [[UIButton alloc] init];
    [self.view addSubview:_flashLightBT];
    [_flashLightBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(24);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(-80);
    }];
    [_flashLightBT setImage:[UIImage imageNamed:@"flashlightOn"] forState:UIControlStateNormal];
    [_flashLightBT setImage:[UIImage imageNamed:@"flashlightOff"] forState:UIControlStateSelected];
    [_flashLightBT addTarget:self action:@selector(flashLightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _changeCameraBT = [[UIButton alloc] init];
    [self.view addSubview:_changeCameraBT];
    [_changeCameraBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
        make.left.mas_equalTo(_flashLightBT.mas_right).offset(60);
    }];
    [_changeCameraBT setImage:[UIImage imageNamed:@"changeCamera"] forState:UIControlStateNormal];
    [_changeCameraBT addTarget:self action:@selector(changeCameraAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _recordNextBT = [[UIButton alloc] init];
    [self.view addSubview:_recordNextBT];
    [_recordNextBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
    }];
    [_recordNextBT setImage:[UIImage imageNamed:@"videoNext"] forState:UIControlStateNormal];
    [_recordNextBT addTarget:self action:@selector(recordNextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _closeBtn = [[UIButton alloc] init];

    [self.view addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_flashLightBT.mas_centerY);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
    }];

    [_closeBtn setImage:[UIImage imageNamed:@"closeVideo"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    
    

    _progressView = [[RecordProgressView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 4, self.view.bounds.size.width, 4)];
    [self.view addSubview:_progressView];
    
    _recordBt = [[RecordButton alloc] initWithFrame:CGRectMake(170, 20, 80, 80)];
    [self.view addSubview:_recordBt];
    _recordBt.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 80);
    _recordBt.type = LeafButtonTypeVideo;
    __weak typeof(self) weakSelf = self;
    _recordBt.clickedBlock = ^(RecordButton *button) {
        [weakSelf recordAction:weakSelf.recordBt];
    };
    
    _locationVideoBT = [[UIButton alloc] init];
    [self.view addSubview:_locationVideoBT];
    [_locationVideoBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.centerY.mas_equalTo(_recordBt.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(self.view.bounds.size.width / 4);
    }];
    
    [_locationVideoBT setImage:[UIImage imageNamed:@"locationVideo"] forState:UIControlStateNormal];
    
    [_locationVideoBT addTarget:self action:@selector(locationVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.allowRecord = YES;
    
    _timeLabel = [[UILabel alloc] init];
    [self.view addSubview:_timeLabel];
    _timeLabel.layer.cornerRadius = 6;
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.clipsToBounds = YES;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:10];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(40);
    }];
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
                    
                    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:weakSelf.recordEngine.videoPath]];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player];
                    weakSelf.player = [[AVPlayer alloc] initWithPlayerItem:item];
                    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
                    
                    layer.frame = self.view.bounds;
                    layer.backgroundColor = [UIColor blackColor].CGColor;
                    layer.videoGravity = AVLayerVideoGravityResize;
                    weakSelf.playerVC.view.translatesAutoresizingMaskIntoConstraints = YES;
                    weakSelf.playerVC.player = self.player;
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
    _timeLabel.text = [NSString stringWithFormat:@"%.1f秒", self.recordEngine.currentRecordTime];
}

#pragma mark - 各种点击事件
//返回点击事件
- (void)dismissAction:(id)sender {
    if (_recordEngine.videoPath.length > 0) {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定放弃这段视频吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];

    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
        [alert addAction:action1];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
            
            AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:weakSelf.recordEngine.videoPath]];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player];
            weakSelf.player = [[AVPlayer alloc] initWithPlayerItem:item];
            AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
            
            layer.frame = self.view.bounds;
            layer.backgroundColor = [UIColor blackColor].CGColor;
            layer.videoGravity = AVLayerVideoGravityResize;
            weakSelf.playerVC.view.translatesAutoresizingMaskIntoConstraints = YES;
            weakSelf.playerVC.player = self.player;
            [weakSelf presentViewController:self.playerVC animated:YES completion:nil];
            [self.player play];
            
        }];
        
    }else {
//        [PromptView showInWindow:@"请先录制视频"];
    }
}

//当点击Done按键或者播放完毕时调用此函数
- (void)playVideoFinished:(NSNotification *)theNotification {
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
- (void)recordAction:(RecordButton *)sender {
    if (self.allowRecord) {
        self.videoStyle = VideoRecord;
        if (self.recordBt.state == LeafButtonStateSelected) {
            if (self.recordEngine.isCapturing) {
                [self.recordEngine resumeCapture];
            }else {
                [self.recordEngine startCapture];
                self.timeLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
            }
            [self hiddenButton:YES];

        }else {
            [self hiddenButton:NO];
            [self.recordEngine pauseCapture];
        }
        
    }
}

- (void)hiddenButton:(BOOL)value {
    _recordNextBT.hidden = value;
    _changeCameraBT.hidden = value;
    _closeBtn.hidden = value;
    _locationVideoBT.hidden = value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
