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

-(void)shootCellClicked:(MPShootViewScrollCell *)sender;

@end

@interface MPShootViewScrollCell : UIView

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title;

@property(nonatomic,weak)id <MPShootViewScrollCellDelegate> delegate;

@end
