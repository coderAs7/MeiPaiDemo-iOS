//
//  MPTabBar.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPTabBar.h"
#import "MPTabBarButton.h"

@interface MPTabBar()

@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation MPTabBar

- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    for (UITabBarItem * item in _items) {
        
        MPTabBarButton *btn = [MPTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}


- (UIButton *)plusButton{
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"icon_wechat_share"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_wechat_share"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        // 监听按钮的点击
        [btn addTarget:self action:@selector(plusClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _plusButton = btn;
        
        [self addSubview:_plusButton];
        
    }
    return _plusButton;
}

// 点击加号按钮的时候调用
- (void)plusClick:(UIButton *)sender{
    // modal出控制器
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:didClickButton:)]) {
        [_delegate tabBarDidClickPlusButton:self didClickButton:sender];
    }
    
}

// self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
// 调整子控件的位置
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    
    
    int i = 0;
    // 设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    
    
    
    self.plusButton.frame = CGRectMake(0, 0, btnW, CGRectGetHeight(self.plusButton.frame));
    // 设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5 - 5);
    
    //    self.layer.masksToBounds = YES;
}

- (void)setTabBarSelectedIndexButton:(NSUInteger)selectedIndex{
    for (int i = 0; i < self.subviews.count; ++i) {
        UIButton *button = [self.subviews objectAtIndex:i];
        if (i == selectedIndex) {
            _selectedButton.selected = NO;
            button.selected = YES;
            _selectedButton = button;
        }
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    UIColor *color = UIColorFromRGB(0xdddddd);
    [color set];
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 2;
    
    [aPath moveToPoint:CGPointMake(0,0)];
    [aPath addLineToPoint:CGPointMake(CGRectGetWidth(rect),0)];
    
    [aPath stroke];
}

@end

