//
//  FollowTableView.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "FollowTableView.h"
#import "FollowTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
static NSString *const followIdentifier = @"followHomeIdentifier";

@interface FollowTableView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)AVPlayer *player;

@property (nonatomic,strong)AVPlayerItem *playItem;

@property (nonatomic,strong)AVPlayerLayer *avLayer;

//@property (nonatomic,strong)UIView   *playView;

@property (nonatomic ,strong) UIProgressView *videoProgress;

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation FollowTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
//        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(0);
//            make.right.equalTo(self).offset(0);
//            make.top.equalTo(self).offset(64);
//            make.bottom.equalTo(self).offset(0);
//        }];
    }
    return self;
}


//- (UIView *)playView {
//    if (!_playView) {
//        _playView = [[UIView alloc]init];
//        _playView.backgroundColor = [UIColor blackColor];
//    }
//    return _playView;
//}

#pragma mark -- avfoundtion

- (void)avfoundtion:(UIView *)backView {
    NSURL *videoUrl = [NSURL URLWithString:@"http://dlhls.cdn.zhanqi.tv/zqlive/76068_G5jGr.m3u8"];
    self.playItem = [AVPlayerItem playerItemWithURL:videoUrl];
    //监听status
    [self.playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监听loadedTimeRanges属性
    [self.playItem addObserver:self forKeyPath:@"loadedTimeRange" options:NSKeyValueObservingOptionNew context:nil];
    
//    self.player = [AVPlayer playerWithPlayerItem:self.playItem];
    
    
    self.avLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.avLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, FN(130));
//    //    self.layer.videoGravity = AVLayerVideoGravityResizeAspect;
    [backView.layer addSublayer:self.avLayer];
    
    //添加视频播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playItem];
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:self.playItem];
    }
    return _player;
}

- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"播放结束");
    
    __weak typeof(self)weakSelf = self;
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        
    }];
}


//KVO 方法

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"准备播放");
            //            CMTime duration = self.playItem.duration;//获取视频总长度
            //            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;//转换成秒
            [self.player play];
        }else if ([playerItem status] == AVPlayerStatusFailed){
            NSLog(@"播放失败");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRange"]){
        
        //缓存进度
        NSTimeInterval timeInterval = [self availabelDuration];
        CMTime duration = self.playItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
}

- (UIProgressView *)videoProgress {
    if (!_videoProgress) {
        _videoProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(100, 500, 100, 20)];
        _videoProgress.backgroundColor = [UIColor orangeColor];
        _videoProgress.tintColor = [UIColor greenColor];
    }
    return _videoProgress;
}

- (NSTimeInterval)availabelDuration {
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    //获取缓存区域
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    
    CGFloat startSecond = CMTimeGetSeconds(timeRange.start);
    CGFloat durationSeconds = CMTimeGetSeconds(timeRange.duration);
    //计算缓存总进度
    NSTimeInterval result = startSecond + durationSeconds;
    return result;
}




#pragma mark -- tableView  with delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:followIdentifier];
    if (!cell) {
        cell = [[FollowTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:followIdentifier];
    }
    [cell dataSourceArray:@[] withIndex:indexPath];
    [cell computeCellHeight];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowTableViewCell *cell = (FollowTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return CGRectGetHeight(cell.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowTableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
    cell.backView.hidden = NO;
    [self avfoundtion:cell.backView];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FN(80);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = RGB(45, 47, 55);
    
    
    return headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"FollowTableViewCell" bundle:[NSBundle bundleWithIdentifier:@"FollowTableViewCell"]] forCellReuseIdentifier:followIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
