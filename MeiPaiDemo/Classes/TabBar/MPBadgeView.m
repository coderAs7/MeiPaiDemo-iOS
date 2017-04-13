//
//  MPBadgeView.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPBadgeView.h"

#define YJBadgeViewFont [UIFont systemFontOfSize:11]

@implementation MPBadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        // 设置字体大小
        self.titleLabel.font = YJBadgeViewFont;
        
        [self sizeToFit];
        
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) { // 没有内容或者空字符串,等于0
        dispatch_async(dispatch_get_main_queue(), ^{
            self.hidden = YES;
            
        });
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.hidden = NO;
            
        });
        
        
    }
    
    //    CGSize size = [badgeValue sizeWithFont:YJBadgeViewFont];
    CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName:YJBadgeViewFont}];
    if (size.width > self.bounds.size.width) { // 文字的尺寸大于控件的宽度
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
    
}




@end

