//
//  MPChannelsHeaderTableViewCell.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPChannelsHeaderTableViewCell.h"
//#import "MPTopChannelsButtonView.h"
#import "MPTopChannelsCollectionViewCell.h"

@interface MPChannelsHeaderTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * topChannelsCollectionView;

@property(nonatomic,strong)UIButton * videoListButton;
@property(nonatomic,strong)UIButton * newerReportsButton;

@end

@implementation MPChannelsHeaderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self insertCell];
    
    return self;
}

NSString * topChannelsCollectionViewIdentifire = @"topChannelsCollectionViewIdentifire";

-(void)insertCell
{
    self.backgroundColor = MPColor_VCForgroundGray;
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 1;
    
    self.topChannelsCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 320) collectionViewLayout:flowLayout];
    self.topChannelsCollectionView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    self.topChannelsCollectionView.delegate = self;
    self.topChannelsCollectionView.dataSource = self;
    [self.topChannelsCollectionView registerClass:[MPTopChannelsCollectionViewCell class] forCellWithReuseIdentifier:topChannelsCollectionViewIdentifire];
    [self addSubview:self.topChannelsCollectionView];
    
    self.topChannelsCollectionView.contentSize = CGSizeMake(0, 0);
    self.topChannelsCollectionView.bounces = NO;
    self.topChannelsCollectionView.showsHorizontalScrollIndicator = NO;
    self.topChannelsCollectionView.showsVerticalScrollIndicator = NO;
    
    self.videoListButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, (SCREEN_WIDTH - 30) / 2, 40)];
    self.newerReportsButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 5, 10, self.videoListButton.frame.size.width, self.videoListButton.frame.size.height)];
    self.videoListButton.backgroundColor = MPColor_Pink;
    self.newerReportsButton.backgroundColor = MPColor_Purple;
    [self.videoListButton setTitle:@"视频排行榜" forState:UIControlStateNormal];
    [self.newerReportsButton setTitle:@"新人报道" forState:UIControlStateNormal];
    self.videoListButton.layer.cornerRadius = 5;
    self.newerReportsButton.layer.cornerRadius = 5;
    self.videoListButton.clipsToBounds = YES;
    self.newerReportsButton.clipsToBounds = YES;
    [self.videoListButton addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.newerReportsButton addTarget:self action:@selector(topButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.videoListButton];
    [self addSubview:self.newerReportsButton];
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 380, SCREEN_WIDTH, 30)];
    lineView.backgroundColor = MPColor_VCBackgroundGray;
    [self addSubview:lineView];
    
    UILabel * hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, lineView.frame.size.width, lineView.frame.size.height)];
    hotLabel.textColor = MPColor_Gray;
    hotLabel.text = @"  热门话题";
    hotLabel.font = [UIFont systemFontOfSize:13.0];
    [lineView addSubview:hotLabel];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MPTopChannelsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:topChannelsCollectionViewIdentifire forIndexPath:indexPath];
    
    switch (indexPath.item) {
        case 0:
            [cell insertCellWithTitle:@"直播" image:[UIImage imageNamed:@""]];
            break;
        case 1:
            [cell insertCellWithTitle:@"搞笑" image:[UIImage imageNamed:@""]];
            break;
        case 2:
            [cell insertCellWithTitle:@"吃秀" image:[UIImage imageNamed:@""]];
            break;
        case 3:
            [cell insertCellWithTitle:@"美食" image:[UIImage imageNamed:@""]];
            break;
        case 4:
            [cell insertCellWithTitle:@"音乐" image:[UIImage imageNamed:@""]];
            break;
        case 5:
            [cell insertCellWithTitle:@"舞蹈" image:[UIImage imageNamed:@""]];
            break;
        case 6:
            [cell insertCellWithTitle:@"女神男神" image:[UIImage imageNamed:@""]];
            break;
        case 7:
            [cell insertCellWithTitle:@"明星" image:[UIImage imageNamed:@""]];
            break;
        case 8:
            [cell insertCellWithTitle:@"宝宝" image:[UIImage imageNamed:@""]];
            break;
        case 9:
            [cell insertCellWithTitle:@"萌宠" image:[UIImage imageNamed:@""]];
            break;
        case 10:
            [cell insertCellWithTitle:@"手工" image:[UIImage imageNamed:@""]];
            break;
        case 11:
            [cell insertCellWithTitle:@"美妆" image:[UIImage imageNamed:@""]];
            break;
        case 12:
            [cell insertCellWithTitle:@"穿秀" image:[UIImage imageNamed:@""]];
            break;
        case 13:
            [cell insertCellWithTitle:@"游戏" image:[UIImage imageNamed:@""]];
            break;
        case 14:
            [cell insertCellWithTitle:nil image:nil];
            break;
        case 15:
            [cell insertCellWithTitle:nil image:nil];
            break;
        default:
            break;
    }
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH - 3) / 4, 79);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate channelsHeaderTableViewCellDidSelected:(MPTopChannelsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath]];
}

-(void)topButtonClicked:(UIButton *)button
{
    [self.delegate channelsHeaderTopbuttonDidClicked:button];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
