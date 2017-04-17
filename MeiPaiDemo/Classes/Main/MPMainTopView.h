//
//  MPMainTopView.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPMainTopViewDelegate <NSObject>

- (void)topViewBtnClick:(UIButton *)sender;


@end

@interface MPMainTopView : UIView

@property (nonatomic, weak) id <MPMainTopViewDelegate> delegate;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
- (void)btnInTag:(NSInteger)tag;

- (void)updateBottomLineViewPosition:(CGFloat)value;

@end
