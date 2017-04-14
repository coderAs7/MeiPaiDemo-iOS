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
    
    self.title = title;
    self.number = number;
    
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    self.numberLabel.font = [UIFont systemFontOfSize:22];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.numberLabel.textColor = MPColor_Gray;
    self.titleLabel.textColor = MPColor_Gray;
    
    self.button = [[UIButton alloc]initWithFrame:self.bounds];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = MPColor_VCForgroundGray;
    
    [self addSubview:self.numberLabel];
    [self addSubview:self.titleLabel];

    self.backgroundColor = [UIColor redColor];
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image
{
    self = [self initWithFrame:frame];
    self.title = title;
    
    self.imageView = [[UIImageView alloc]initWithImage:image];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    self.backgroundColor = MPColor_VCForgroundGray;
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];

    self.backgroundColor = [UIColor redColor];
    return self;
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    _title = title;
    
    
}

-(void)setNumber:(NSString *)number
{
    self.numberLabel.text = number;
    [self.numberLabel sizeToFit];
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
