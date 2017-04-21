//
//  PlayViewController.m
//  仿写战旗TV
//
//  Created by liuhu on 2017/4/6.
//  Copyright © 2017年 liuhu. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayViewController ()

@property (nonatomic,strong)AVPlayer *player;

@property (nonatomic,strong)AVPlayerItem *playerItem;

@property (nonatomic,strong)AVPlayerLayer *AVPlayer;

@end

@implementation PlayViewController


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.AVPlayer removeFromSuperlayer];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self hideNavigationController];
    [self showNavWithTitle:@"精彩视频" controller:self];
    UIButton *but = [self showLeftBackButton];
    __weak typeof(self)weakSelf = self;
    [but backMethod:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [weakSelf.player.currentItem cancelPendingSeeks];
        [weakSelf.player.currentItem.asset cancelLoading];
    }];
    [self playVideo];
    [self loadUI];
}

#pragma mark olayer

- (void)playVideo {
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.videoString]]];//@"76068_G5jGr"
    self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
    
    _AVPlayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    _AVPlayer.frame = CGRectMake(0, 64 + 5, SCREEN_WIDTH, FN(180));
    _AVPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:_AVPlayer];
    [self.player play];
    
}


- (void)loadUI {
    NSArray *titleArray = @[@"简介",@"聊天",@"视频",@"排行"];
    NSArray *imageArray = @[@"ic_broadcastroom_chat_default",@"ic_broadcastroom_intro_default",@"ic_broadcastroom_video_default",@"ic_broadcastroom_rank_default",
                            @"ic_broadcastroom_chat_pressed",@"ic_broadcastroom_intro_pressed",@"ic_broadcastroom_video_pressed",@"ic_broadcastroom_rank_pressed"];
    __weak typeof(self)weakSelf = self;
    for (int i = 0; i < 4; i ++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(30 + i * (SCREEN_WIDTH - FN(20))/4, 64 + FN(190), FN(30), FN(30));
        [but setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        but.tag = 300 + i;
        [but backMethod:^{
            for (int i = 0; i < 4; i ++) {
                UIButton *button = [weakSelf.view viewWithTag:300 + i];
                [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            }
            [but setImage:[UIImage imageNamed:imageArray[4 + but.tag - 300]] forState:UIControlStateNormal];
        }];
        [self.view addSubview:but];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(but.frame.origin.x + 35, 64 + FN(195), 50, 20)];
        label.text = titleArray[i];
        label.textColor = [UIColor whiteColor];
        [self.view addSubview:label];
    }
    
    
    UIButton *fullScreenBut = [UIButton buttonWithType:UIButtonTypeCustom];
    fullScreenBut.frame = CGRectMake(SCREEN_WIDTH - FN(70), 64 + FN(140), FN(60),FN(60));
    [fullScreenBut setTitle:@"全屏" forState:UIControlStateNormal];
    fullScreenBut.layer.masksToBounds = YES;
    fullScreenBut.layer.cornerRadius = FN(30);
    [self.view addSubview:fullScreenBut];
    [fullScreenBut backMethod:^{
        
        fullScreenBut.selected = !fullScreenBut.selected;
//        self.isFullScreen = fullScreenBut.selected;
        if (fullScreenBut.selected) {
            for (UIView *view in weakSelf.view.subviews) {
                if ([view isKindOfClass:[UIButton class]] || [view isKindOfClass:[UILabel class]]) {
                    view.hidden = YES;
                }
            }
            fullScreenBut.hidden = NO;
            [fullScreenBut setTitle:@"退出" forState:UIControlStateNormal];
            fullScreenBut.frame = CGRectMake(SCREEN_HEIGHT - 60, SCREEN_WIDTH - 60, 60, 60);
            if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
                
                SEL selector = NSSelectorFromString(@"setOrientation:");
                
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                
                [invocation setSelector:selector];
                
                [invocation setTarget:[UIDevice currentDevice]];
                
                int val = UIInterfaceOrientationLandscapeRight;
                
                [invocation setArgument:&val atIndex:2];
                
                [invocation invoke];
                
                //                    设置横屏
                weakSelf.AVPlayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//                viewWidth = Device_Width;
//                viewHeight = Device_Height;
//                [self.view layoutSubviews];
            }
            
        }else
        {
           
            
            
            for (UIView *view in weakSelf.view.subviews) {
                view.hidden = NO;
            }
            fullScreenBut.hidden = NO;
            [fullScreenBut setTitle:@"全屏" forState:UIControlStateNormal];
            if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
                
                SEL selector = NSSelectorFromString(@"setOrientation:");
                
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                
                [invocation setSelector:selector];
                
                [invocation setTarget:[UIDevice currentDevice]];
                
                int val = UIInterfaceOrientationPortrait;
                [invocation setArgument:&val atIndex:2];
                
                [invocation invoke];
                
                //设置竖屏
//                self.AVPlayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *9/16);
                weakSelf.AVPlayer.frame = CGRectMake(0, 64 + 5, SCREEN_WIDTH, FN(180));
//                viewWidth = Device_Width;
//                viewHeight = Device_Width *9/16;
//                
//                [self.view layoutSubviews];
                fullScreenBut.frame = CGRectMake(SCREEN_WIDTH - FN(70), 64 + FN(140), FN(60),FN(60));
            }
            
        }
        
    }];
    
}


@end
