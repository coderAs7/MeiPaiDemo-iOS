//
//  DescribleView.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/19.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "DescribleView.h"
#import "DescribleTableViewCell.h"
#import <AVFoundation/AVFoundation.h>

static NSString *const descrbileIdentifier = @"descrbileIdentifier";

@interface DescribleView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIView *butView;


@property (nonatomic,strong)AVPlayer *player;

@property (nonatomic,strong)AVPlayerItem *playItem;

@property (nonatomic,strong)AVPlayerLayer *avLayer;

@property (nonatomic,strong)UIScrollView   *scrollView;//headView 滚动试图

@property (nonatomic ,strong) UIProgressView *videoProgress;


@property (nonatomic,copy)NSArray *dataSourceArray;

@property (nonatomic,copy)NSArray *scrollViewArray;

@property (nonatomic,assign)NSInteger saveIndexRow;//记录正在播放的cell

@property (nonatomic,assign)BOOL isPlay;//记录是否暂停

@property (nonatomic,strong)UIView *loadView;//加载动画

@property (nonatomic,assign)CGFloat scrStartY;//scroll开始的位置
@end

@implementation DescribleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(45, 47, 55);
        self.isPlay = NO;
        self.saveIndexRow = -1;
        [self loadDataSource];
    }
    return self;
}

- (void)loadUI {
    
    [self addSubview:self.tableView];
    
    
//    [self tableHeadView];
}


#pragma mark -- 数据请求

- (void)loadDataSource {
    
    [LHScaleTool GET:HOME_URL dict:nil succeed:^(id data) {
        
        if ([data[@"data"] isKindOfClass:[NSArray class]]) {
            self.dataSourceArray = data[@"data"];
            [self loadUI];
        }else{
            NSLog(@"%@",data);
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

#pragma mark -- headView 

- (UIView *)tableHeadView {
    NSString *labelString = @"这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述";
    CGFloat heiY = [self calculateRowHeight:labelString fontSize:FN(13)] + FN(365);
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heiY)];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
//    self.tableView.tableHeaderView = backgroundView;
    
    UIImageView *backgroundImage = [[UIImageView alloc]init];
    backgroundImage.image = [UIImage imageNamed:@"mv10"];
    backgroundImage.clipsToBounds = YES;
    backgroundImage.backgroundColor = [UIColor blackColor];
    [backgroundView addSubview:backgroundImage];
    
    
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
//    self.tableView.tableHeaderView = headView;
    [backgroundView addSubview:headView];
    
   
    
    UIImageView *headImage = [[UIImageView alloc]init];
    headImage.backgroundColor = [UIColor whiteColor];
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = FN(50);
    headImage.image = [UIImage imageNamed:@"mv10"];
    [headView addSubview:headImage];
    
    
    UILabel *headLabel = [[UILabel alloc]init];
    headLabel.font = [UIFont systemFontOfSize:FN(13)];
    headLabel.textColor = [UIColor whiteColor];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.text = @"关注26   |   粉丝57.1万";
    [headView addSubview:headLabel];
    
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.titleLabel.font = [UIFont systemFontOfSize:FN(12)];
    [headButton setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateNormal];
    [headButton setImage:[UIImage imageNamed:@"icon_cell_likesmall_a"] forState:UIControlStateNormal];
    headButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [headButton setTitle:@"被赞205.4万次" forState:UIControlStateNormal];
    [headView addSubview:headButton];
    
    
    UIButton *silkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    silkButton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    [silkButton setTitle:@"粉丝榜" forState:UIControlStateNormal];
    [silkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    silkButton.layer.masksToBounds = YES;
    silkButton.layer.cornerRadius = 15;
    silkButton.titleLabel.font = [UIFont systemFontOfSize:FN(15)];
    [headView addSubview:silkButton];
    
    
    
    
    
//    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(0);
//        make.right.equalTo(self).offset(0);
//        make.top.equalTo(self).offset(0);
//        make.height.offset(FN(heiY));
//    }];
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(0);
        make.right.equalTo(backgroundView).offset(0);
        make.top.equalTo(backgroundView).offset(0);
        make.height.offset(FN(260));
    }];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(0);
        make.right.equalTo(backgroundView).offset(0);
        make.top.equalTo(backgroundView).offset(0);
        make.height.offset(FN(260));
    }];
    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView).offset(FN(20));
        make.size.mas_equalTo(CGSizeMake(FN(100), FN(100)));
    }];
    
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImage.mas_bottom).offset(10);
        make.centerX.equalTo(headView.mas_centerX);
    }];
    
    [headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headLabel.mas_bottom).offset(10);
        make.centerX.equalTo(headView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(FN(300), FN(20)));
    }];
    
    [silkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headButton.mas_bottom).offset(10);
        make.centerX.equalTo(headView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(FN(200), FN(30)));
    }];
    
    
    //私信  关注
    NSArray *array = @[@"私信",@"关注"];
    CGFloat wid = (SCREEN_WIDTH - FN(40))/2;
    for (int i = 0; i < 2; i ++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(FN(10), CGRectGetHeight(headView.frame) + FN(10), wid, FN(38));
        [but setTitle:array[i] forState:UIControlStateNormal];
        but.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        but.layer.masksToBounds = YES;
        but.layer.cornerRadius = FN(8);
        [backgroundView addSubview:but];
        CGFloat butX = FN(10) + i * (FN(10) + wid);
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView).offset(butX);
            make.top.equalTo(headView.mas_bottom).offset(FN(20));
            make.size.mas_equalTo(CGSizeMake(FN(wid), FN(32)));
        }];
    }
    
    //简介
    UILabel *describleLabel = [[UILabel alloc]init];
    describleLabel.font = [UIFont systemFontOfSize:FN(13)];
    describleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    describleLabel.text = labelString;
    describleLabel.numberOfLines = 0;
    [backgroundView addSubview:describleLabel];
    [describleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(5);
        make.right.equalTo(backgroundView).offset(-5);
        make.top.equalTo(headView.mas_bottom).offset(FN(55));
    }];
    
    __weak typeof(self)weakSelf = self;
    //切换
    NSArray *qieArray = @[@"98美拍",@"25转发"];
    for (int i = 0; i < 2; i ++) {
        CGFloat butX = FN(10) + i * (FN(10) + wid);
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(FN(10), CGRectGetHeight(describleLabel.frame) + FN(10), wid, FN(38));
        [but setTitle:qieArray[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        but.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -FN(10), 0);
        [but backMethod:^{
            if (i == 0) {
                [weakSelf.butView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(backgroundView).offset(FN(butX));
                    make.top.equalTo(describleLabel.mas_bottom).offset(FN(42));
                    make.size.mas_equalTo(CGSizeMake(FN(wid), FN(3)));
                }];
            }else{
                [weakSelf.butView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(backgroundView).offset(FN(butX));
                    make.top.equalTo(describleLabel.mas_bottom).offset(FN(42));
                    make.size.mas_equalTo(CGSizeMake(FN(wid), FN(3)));
                }];
            }
        }];
        [backgroundView addSubview:but];
        
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView).offset(butX);
            make.top.equalTo(describleLabel.mas_bottom).offset(FN(10));
            make.size.mas_equalTo(CGSizeMake(FN(wid), FN(32)));
        }];
    }
    self.butView = [[UIView alloc]init];
    self.butView.backgroundColor = [UIColor redColor];
    [backgroundView addSubview:self.butView];
    [self.butView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(FN(10));
        make.top.equalTo(describleLabel.mas_bottom).offset(FN(42));
        make.size.mas_equalTo(CGSizeMake(FN(wid), FN(3)));
    }];
    
    return backgroundView;
}


- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - FN(20), 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return FN(rect.size.height);
}


#pragma mark -- avfoundtion

- (void)avfoundtion:(UIView *)backView url:(NSString *)urlString{
    
    
    NSURL *videoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,urlString]];
    self.playItem = [AVPlayerItem playerItemWithURL:videoUrl];
    //监听status
    [self.playItem addObserver:self forKeyPath:@"describleStatus" options:NSKeyValueObservingOptionNew context:nil];
    //监听loadedTimeRanges属性
    [self.playItem addObserver:self forKeyPath:@"describleLoadedTimeRange" options:NSKeyValueObservingOptionNew context:nil];
    
    
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
    if ([keyPath isEqualToString:@"describleStatus"]) {
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
    }else if ([keyPath isEqualToString:@"describleLoadedTimeRange"]){
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataSourceArray[section][@"lists"];
    return array.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    self.indexString = [NSString stringWithFormat:@"%ld",indexPath.row];
    DescribleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:descrbileIdentifier];
    if (!cell) {
        cell = [[DescribleTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:descrbileIdentifier];
    }
    [cell dataSourceArray:self.dataSourceArray[indexPath.section][@"lists"] withIndex:indexPath];
    [cell computeCellHeight];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DescribleTableViewCell *cell = (DescribleTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return CGRectGetHeight(cell.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadData];
    DescribleTableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
    
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
    NSString *labelString = @"这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述";
    CGFloat heiY = [self calculateRowHeight:labelString fontSize:FN(13)] + FN(365);
    return heiY;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc]init];
//    headerView.backgroundColor = RGB(45, 47, 5/5);

    UIView *headerView = [self tableHeadView];
    return headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(45, 47, 55);
        [_tableView registerNib:[UINib nibWithNibName:@"FollowTableViewCell" bundle:[NSBundle bundleWithIdentifier:@"FollowTableViewCell"]] forCellReuseIdentifier:descrbileIdentifier];
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
    [self.playItem removeObserver:self forKeyPath:@"describleStatus"];
    [self.playItem removeObserver:self forKeyPath:@"describleLoadedTimeRange"];
    [self.avLayer removeFromSuperlayer];
    self.player = nil;
    self.playItem = nil;
    self.avLayer = nil;
    
}
@end
