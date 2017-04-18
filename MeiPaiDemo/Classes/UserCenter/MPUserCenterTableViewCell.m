//
//  MPUserCenterTableViewCell.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPUserCenterTableViewCell.h"

@interface MPUserCenterTableViewCell ()

//@property(nonatomic,strong)UILabel * titleLabel;
//@property(nonatomic,strong)UIImageView * leftImageView;
//@property(nonatomic,strong)UIButton * button;

@end


@implementation MPUserCenterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self insertCell];
    
    return self;
}

-(void)insertCell
{
    self.backgroundColor = MPColor_VCForgroundGray;
    self.textLabel.textColor = [UIColor whiteColor];
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
