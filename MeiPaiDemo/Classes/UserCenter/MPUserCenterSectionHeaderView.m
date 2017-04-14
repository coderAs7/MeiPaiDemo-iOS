//
//  MPUserCenterSectionHeaderView.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPUserCenterSectionHeaderView.h"

@implementation MPUserCenterSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
        lineView.backgroundColor = MPColor_Gray;
        [self addSubview:lineView];
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end