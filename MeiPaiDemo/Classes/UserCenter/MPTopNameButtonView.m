//
//  MPTopNameButtonView.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPTopNameButtonView.h"

@interface MPTopNameButtonView ()

@property(nonatomic,strong)UILabel * numberLabel;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIButton * button;

@end

@implementation MPTopNameButtonView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title number:(NSString *)number
{
    self = [self initWithFrame:frame];
    
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 25)];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, self.bounds.size.width, 15)];
    
    self.numberLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.numberLabel.textColor = MPColor_Gray;
    self.titleLabel.textColor = MPColor_Gray;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.button = [[UIButton alloc]initWithFrame:self.bounds];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = MPColor_VCForgroundGray;
    
    [self addSubview:self.numberLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.button];
    
    self.title = title;
    self.number = number;
    
    UIView * vLineView = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width - 0.5, 5, 0.5, 30)];
    vLineView.backgroundColor = MPColor_Gray;
    [self addSubview:vLineView];

    return self;
    
}

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
    [self addSubview:self.button];
    
    self.title = title;
    self.imageView.image = image;

    return self;
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    _title = title;
}

-(void)setNumber:(NSString *)number
{
    self.numberLabel.text = number;
    _number = number;
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
