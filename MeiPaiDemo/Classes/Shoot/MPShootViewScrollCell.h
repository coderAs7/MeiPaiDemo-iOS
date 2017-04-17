//
//  MPShootViewScrollCell.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPShootViewScrollCell;

@protocol MPShootViewScrollCellDelegate <NSObject>


@end

@interface MPShootViewScrollCell : UIView

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title;

@end
