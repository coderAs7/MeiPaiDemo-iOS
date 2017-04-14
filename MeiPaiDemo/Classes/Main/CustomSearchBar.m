//
//  CustomSearchBar.m
//  Control
//
//  Created by 李明 on 2017/3/23.
//  Copyright © 2017年 李明. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBarStyle:UIBarStyleBlackTranslucent];
        UIImage* searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
        //设置背景图片
        [self setBackgroundImage:searchBarBg];
        //设置背景色
        [self setBackgroundColor:[UIColor clearColor]];
        //设置文本框背景
        [self setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        //self.translucent= YES;
       // self.placeholder = @"搜索地点或公交路线";

        [self setSearchTextPositionAdjustment:UIOffsetMake(10, 0)];// 设置搜索框中文本框的文本偏移量
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        for (UIView *subView in view.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)subView;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
            }
            if ([subView isKindOfClass:[UITextField class]]) {
                subView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
                UITextField *field = (UITextField *)subView;
                field.font = [UIFont systemFontOfSize:16];
                field.textColor = [UIColor darkTextColor];
                field.layer.cornerRadius = 4;
                field.clipsToBounds = YES;
                if ([field isEditing]) {
                    subView.frame = CGRectMake(0, 0, self.bounds.size.width - 60, self.bounds.size.height);
                } else {
                    subView.frame = self.bounds;
                }
            }
        }
    }
}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height {
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
