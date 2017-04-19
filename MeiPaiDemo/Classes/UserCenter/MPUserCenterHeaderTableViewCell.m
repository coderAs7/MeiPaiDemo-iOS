//
//  MPUserCenterHeaderTableViewCell.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPUserCenterHeaderTableViewCell.h"

#import "MPDataManager.h"
#import "MPUserCenterSectionHeaderView.h"

@interface MPUserCenterHeaderTableViewCell ()

@property(nonatomic,strong)UIView * userView;

@property(nonatomic,strong)MPTopNameButtonView * meiPaiButton;
@property(nonatomic,strong)MPTopNameButtonView * relayButton;
@property(nonatomic,strong)MPTopNameButtonView * followButton;
@property(nonatomic,strong)MPTopNameButtonView * fansButton;

@property(nonatomic,strong)MPTopNameButtonView * upvoteButton;
@property(nonatomic,strong)MPTopNameButtonView * atMeButton;
@property(nonatomic,strong)MPTopNameButtonView * commentButton;
@property(nonatomic,strong)MPTopNameButtonView * privateLatterButton;

@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * subIDLabel;

@end

@implementation MPUserCenterHeaderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self insertCell];
    
    return self;
}

-(void)insertCell
{
    CGFloat nameHeight = 80;
    CGFloat buttonHeight = 40;
    
    
    self.userView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nameHeight)];
    self.userView.backgroundColor = MPColor_VCForgroundGray;
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    self.headerImageView.layer.cornerRadius = 30;
    self.headerImageView.clipsToBounds = YES;
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, SCREEN_WIDTH - 80, 20)];
    self.subIDLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 45, SCREEN_WIDTH - 80, 15)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.subIDLabel.textColor = [UIColor lightGrayColor];
    self.subIDLabel.font = [UIFont systemFontOfSize:15.0];
    [self.userView addSubview:self.headerImageView];
    [self.userView addSubview:self.nameLabel];
    [self.userView addSubview:self.subIDLabel];
    
    self.headerImageView.image = [UIImage imageNamed:@"AppIcon29x29"];
    self.nameLabel.text = @"董小伟🍚";
    self.subIDLabel.text = [NSString stringWithFormat:@"美拍ID: 1507546710"];
    
    CGFloat topButtonWidth = SCREEN_WIDTH / 4;
    
    self.meiPaiButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(0, nameHeight, topButtonWidth, buttonHeight) title:@"美拍" number:@"0"];
    self.relayButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth, nameHeight, topButtonWidth, buttonHeight) title:@"转发" number:@"666"];
    self.followButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth * 2, nameHeight, topButtonWidth, buttonHeight) title:@"关注" number:@"12"];
    self.fansButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth * 3, nameHeight, topButtonWidth, buttonHeight) title:@"粉丝" number:@"666"];
    
    MPUserCenterSectionHeaderView * view = [[MPUserCenterSectionHeaderView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 30)];
    
    CGFloat buttonX = 150;
    self.upvoteButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(0, buttonX, topButtonWidth * 2, buttonHeight) title:@"赞" image:[UIImage imageNamed:@"icon_cell_likesmall_a"]];
    self.atMeButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth * 2, buttonX, topButtonWidth * 2, buttonHeight) title:@"@我的" image:[UIImage imageNamed:@"icon_cell_likesmall_a"]];
    self.commentButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(0, buttonX + buttonHeight, topButtonWidth * 2, buttonHeight) title:@"评论" image:[UIImage imageNamed:@"icon_cell_likesmall_a"]];
    self.privateLatterButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth * 2, buttonX + buttonHeight, topButtonWidth * 2, buttonHeight) title:@"私信" image:[UIImage imageNamed:@"icon_cell_likesmall_a"]];
    
    [self addSubview:self.userView];
    [self addSubview:self.meiPaiButton];
    [self addSubview:self.relayButton];
    [self addSubview:self.followButton];
    [self addSubview:self.fansButton];
    [self addSubview:self.upvoteButton];
    [self addSubview:self.atMeButton];
    [self addSubview:self.commentButton];
    [self addSubview:self.privateLatterButton];
    [self addSubview:view];
    
    UIView * hLineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 80 - 0.5, SCREEN_WIDTH, 0.5)];
    hLineView1.backgroundColor = MPColor_Gray;
    
    UIView * hLineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 190 - 0.5, SCREEN_WIDTH, 0.5)];
    hLineView2.backgroundColor = MPColor_Gray;
    
    UIView * vLineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 0.5, 150 - 0.5, 0.5, 80)];
    vLineView.backgroundColor = MPColor_Gray;
    
    //[self.userView addSubview:hLineView1];
    [self.userView addSubview:hLineView2];
    [self.userView addSubview:vLineView];
    
    //[self.userView bringSubviewToFront:hLineView1];
    [self.userView bringSubviewToFront:hLineView2];
    [self.userView bringSubviewToFront:vLineView];
    
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
