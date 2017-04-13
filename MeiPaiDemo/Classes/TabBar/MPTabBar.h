//
//  MPTabBar.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPTabBar;

@protocol MPTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MPTabBar *)tabBar didClickButton:(NSInteger)index;
- (void)tabBarDidClickPlusButton:(MPTabBar *)tabBar didClickButton:(UIButton *)button;

@end


@interface MPTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, weak) id <MPTabBarDelegate> delegate;

- (void)setTabBarSelectedIndexButton:(NSUInteger)selectedIndex;

@end

