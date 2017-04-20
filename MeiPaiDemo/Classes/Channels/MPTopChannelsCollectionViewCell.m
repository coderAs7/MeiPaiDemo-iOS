//
//  MPTopChannelsCollectionViewCell.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPTopChannelsCollectionViewCell.h"

@interface MPTopChannelsCollectionViewCell ()

@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * titleLabel;

@end

@implementation MPTopChannelsCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
    
}
- (void)prepareUI
{
    self.backgroundColor = MPColor_VCForgroundGray;
    
    //写布局
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width - 40) / 2, 10, 40, 40)];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.bounds.size.width, 15)];
    self.titleLabel.textColor = MPColor_Gray;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    
}

-(void)insertCellWithTitle:(NSString *)title image:(UIImage *)image
{
    self.titleLabel.text = title;
    self.imageView.image = title ? [UIImage imageNamed:@"icon_cell_like"] : nil;//image;
    self.title = title;
}

@end
