//
//  MPChannelsTableViewCell.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPChannelsTableViewCell.h"

@interface MPChannelsTableViewCell ()

@property(nonatomic,strong)UIImageView * leftImageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * subTitleLabel;

@end

@implementation MPChannelsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    self.backgroundColor = MPColor_VCForgroundGray;
    
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, self.bounds.size.width - 60, 20)];
    self.subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 35, self.bounds.size.width - 60, 15)];
    
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.subTitleLabel.font = [UIFont systemFontOfSize:12.0];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.textColor = MPColor_Gray;
    
    
    [self addSubview:self.leftImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
}

-(void)insertCellWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image
{
    self.titleLabel.text = title;
    self.subTitleLabel.text = subTitle;
    self.imageView.image = image;
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
