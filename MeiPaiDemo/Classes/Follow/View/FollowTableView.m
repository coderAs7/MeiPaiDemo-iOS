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

@property (nonatomic,copy)NSArray *dataSourceArray;

@property (nonatomic,assign)NSInteger saveIndexRow;//记录正在播放的cell

@property (nonatomic,assign)BOOL isPlay;//记录是否暂停

@property (nonatomic,strong)UIView *loadView;//加载动画

@property (nonatomic,assign)CGFloat scrStartY;//scroll开始的位置

@end

@implementation FollowTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isPlay = NO;
        self.saveIndexRow = -1;
        [self loadDataSource];
//        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(0);
//            make.right.equalTo(self).offset(0);
//            make.top.equalTo(self).offset(64);
//            make.bottom.equalTo(self).offset(0);
//        }];
    }
    return self;
}

#pragma mark -- 数据请求

- (void)loadDataSource {
    
    [LHScaleTool GET:HOME_URL dict:nil succeed:^(id data) {
        
        if ([data[@"data"] isKindOfClass:[NSArray class]]) {
            self.dataSourceArray = data[@"data"];
            [self addSubview:self.tableView];
        }else{
            NSLog(@"%@",data);
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


#pragma mark -- avfoundtion

- (void)avfoundtion:(UIView *)backView url:(NSString *)urlString{
    
    
    NSURL *videoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,urlString]];
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
            self.isPlay = YES;
            
            [self.loadView removeFromSuperview];
            self.loadView = nil;
        }else if ([playerItem status] == AVPlayerStatusFailed){
            NSLog(@"播放失败");
            [self.loadView removeFromSuperview];
            self.loadView = nil;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRange"]){
        [self.loadView removeFromSuperview];
        self.loadView = nil;
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
    NSArray *array = self.dataSourceArray[section][@"lists"];
    return array.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.indexString = [NSString stringWithFormat:@"%ld",indexPath.row];
    FollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:followIdentifier];
    if (!cell) {
        cell = [[FollowTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:followIdentifier];
    }
    [cell dataSourceArray:self.dataSourceArray[indexPath.section][@"lists"] withIndex:indexPath];
    [cell computeCellHeight];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowTableViewCell *cell = (FollowTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return CGRectGetHeight(cell.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadData];
    FollowTableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
    
    //加载动画
    self.loadView = [LHScaleTool backLoadingView:cell.contentView];
    
    self.loadView.hidden = NO;
    if (self.saveIndexRow == indexPath.row) {
        if (self.isPlay) {
            [self.player pause];
            self.loadView.hidden = YES;
            cell.playImage.hidden = NO;
            self.isPlay = NO;
        }else {
            [self.player play];
            self.loadView.hidden = NO;
            cell.playImage.hidden = YES;
            self.isPlay = YES;
        }
    }else{
        if (self.player) {
            [self.player pause];
            
            self.player = nil;
            self.playItem = nil;
            self.avLayer = nil;
            [self.avLayer removeFromSuperlayer];
        }
        self.isPlay = NO;
        self.saveIndexRow = indexPath.row;
        cell.backView.hidden = NO;
        NSString *videoString = [NSString stringWithFormat:@"%@",self.dataSourceArray[indexPath.section][@"lists"][indexPath.row][@"videoId"]];
        cell.playImage.hidden = YES;
        [self avfoundtion:cell.backView url:videoString];
    }
    
}

//加载动画
- (void)loadingAnimation {
//    UIView *loadView = [LHScaleTool backLoadingView];
    
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

#pragma mark -UIScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    NSUInteger num = 0;
    if (self.saveIndexRow > -1) {
        num = self.saveIndexRow;
    }
    NSIndexPath *index = [NSIndexPath indexPathForRow:num inSection:1];
//    FollowTableViewCell *cell = (FollowTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:index];
//    FollowTableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
    
    
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:index];
    
    
    CGRect rect = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
//    NSLog(@"%f      ----------   X:::%f",rect.origin.y,rect.origin.x);
    if (num == 0) {
        num = 1;
    }
    CGFloat cellY = (-30 - (FN(216) * num));
    CGFloat scrY = scrollView.contentOffset.y;
    if (rect.origin.y < cellY  && self.playItem) {
        [self.player pause];
        self.player = nil;
        self.playItem = nil;
        self.avLayer = nil;
        [self.avLayer removeFromSuperlayer];
        [self.tableView reloadData];
    }else if (self.scrStartY - scrY > cellY && self.playItem){
        [self.player pause];
        self.player = nil;
        self.playItem = nil;
        self.avLayer = nil;
        [self.avLayer removeFromSuperlayer];
        [self.tableView reloadData];
    }
    
    
    
//    if (self.scrStartY - scrY > cellY) {
//        [self.player pause];
//        self.player = nil;
//        self.playItem = nil;
//        self.avLayer = nil;
//        [self.avLayer removeFromSuperlayer];
//        [self.tableView reloadData];
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.scrStartY = scrollView.contentOffset.y;
}

- (void)dealloc {
    [self.avLayer removeFromSuperlayer];
    self.player = nil;
    self.playItem = nil;
    self.avLayer = nil;
    
    [self.playItem removeObserver:self forKeyPath:@"status"];
    [self.playItem removeObserver:self forKeyPath:@"loadedTimeRange"];
}

@end
