//
//  MPUserCenterHeaderTableViewCell.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPUserCenterHeaderTableViewCell.h"

#import "MPTopNameButtonView.h"

#import "MPDataManager.h"

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
    self.userView.backgroundColor = [UIColor greenColor];
    
    CGFloat topButtonWidth = SCREEN_WIDTH / 4;
    
    self.meiPaiButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(0, nameHeight, topButtonWidth, buttonHeight) title:@"美拍" number:@"0"];
    self.relayButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth, nameHeight, topButtonWidth, buttonHeight) title:@"转发" number:@"0"];
    self.followButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth * 2, nameHeight, topButtonWidth, buttonHeight) title:@"关注" number:@"0"];
    self.fansButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth * 3, nameHeight, topButtonWidth, buttonHeight) title:@"粉丝" number:@"0"];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 30)];
    view.backgroundColor = [UIColor yellowColor];
    
    CGFloat buttonX = 150;
    
    self.upvoteButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(0, buttonX, topButtonWidth * 2, buttonHeight) title:@"美拍" image:[UIImage imageNamed:@""]];
    self.atMeButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth * 2, buttonX, topButtonWidth * 2, buttonHeight) title:@"美拍" image:[UIImage imageNamed:@""]];
    self.commentButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(0, buttonX + buttonHeight, topButtonWidth * 2, buttonHeight) title:@"美拍" image:[UIImage imageNamed:@""]];
    self.privateLatterButton = [[MPTopNameButtonView alloc]initWithFrame:CGRectMake(topButtonWidth * 2, buttonX + buttonHeight, topButtonWidth * 2, buttonHeight) title:@"美拍" image:[UIImage imageNamed:@""]];
    
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
