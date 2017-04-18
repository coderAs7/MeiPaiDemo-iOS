//
//  MPTopChannelsButtonView.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPTopChannelsButtonView.h"

@interface MPTopChannelsButtonView ()

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIButton * button;

@end

@implementation MPTopChannelsButtonView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image
{
    self = [self initWithFrame:frame];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, self.bounds.size.width - 40, self.bounds.size.height)];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.button = [[UIButton alloc]initWithFrame:self.bounds];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    self.backgroundColor = MPColor_VCForgroundGray;
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    self.title = title;
    self.imageView.image = image;
    
    
    
    return self;
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    _title = title;
}

-(void)buttonClicked:(UIButton *)button
{
    [self.delegate buttonClicked:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
