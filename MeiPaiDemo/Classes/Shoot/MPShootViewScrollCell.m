//
//  MPShootViewScrollCell.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPShootViewScrollCell.h"

@interface MPShootViewScrollCell ()

@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIButton * button;

@end

@implementation MPShootViewScrollCell

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title
{
    self = [self initWithFrame:frame];
    self.imageView.image = image;
    self.titleLabel.text = title;
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 80, 20)];
        self.button = [[UIButton alloc]initWithFrame:self.bounds];
        
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.button];
    }
    return self;
}

-(void)buttonClicked:(UIButton *)sender
{
    [self.delegate shootCellClicked:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
