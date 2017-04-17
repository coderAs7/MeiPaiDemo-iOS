//
//  LineProgressView.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineProgressView : UIView

@property (assign, nonatomic) IBInspectable CGFloat progress;//当前进度
@property (strong, nonatomic) IBInspectable UIColor *progressBgColor;//进度条背景颜色
@property (strong, nonatomic) IBInspectable UIColor *progressColor;//进度条颜色
@property (assign, nonatomic) CGFloat loadProgress;//加载好的进度
@property (strong, nonatomic) UIColor *loadProgressColor;//已经加载好的进度颜色

@end
