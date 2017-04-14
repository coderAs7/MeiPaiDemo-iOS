//
//  MPMainTopView.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainTopView.h"
#import "PrefixHeader.pch"

#define lineViewWidth 80
@interface MPMainTopView ()
@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation MPMainTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        _effectView = [[UIVisualEffectView alloc] initWithEffect:eff];
        
        _effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        [self addSubview:_effectView];
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 120, 61, lineViewWidth, 3)];
        _bottomLineView.backgroundColor = MPColor_Pink;
        [self addSubview:_bottomLineView];
        
        _btn1 = [self creatBtn:@"直播" normalImg:nil helitedImg:nil];
        [self addSubview:_btn1];
        _btn1.tag = 1;
        _btn1.selected = YES;
        [_btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn2 = [self creatBtn:@"热门" normalImg:nil helitedImg:nil];
        [self addSubview:_btn2];
        _btn2.tag = 2;
        [_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn3 = [self creatBtn:@"同城" normalImg:nil helitedImg:nil];
        [self addSubview:_btn3];
        _btn3.tag = 3;
        [_btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


- (UIButton *)creatBtn:(NSString *)title normalImg:(UIImage *)img helitedImg:(UIImage *)hImg {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:hImg forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:MPColor_Gray forState:UIControlStateNormal];
    [btn setTitleColor:MPColor_Pink forState:UIControlStateSelected];
    return btn;
}

- (void)btnClick:(UIButton *)sender {

    [self btnInTag:sender.tag];
    [self updateBottmLineViewCenter:sender.center.x];
    if ([self.delegate respondsToSelector:@selector(topViewBtnClick:)]) {
        [self.delegate topViewBtnClick:sender];
    }
}

- (void)btnInTag:(NSInteger)tag {

    if (tag == 1) {
        _btn1.selected = YES;
        _btn2.selected = NO;
        _btn3.selected = NO;
        
        
    }
    if (tag == 2) {
        _btn1.selected = NO;
        _btn2.selected = YES;
        _btn3.selected = NO;
    }
    
    if (tag == 3) {
        _btn3.selected = YES;
        _btn2.selected = NO;
        _btn1.selected = NO;
    }
}


- (void)updateBottmLineViewCenter:(CGFloat)value {
    _bottomLineView.center = CGPointMake(value, _bottomLineView.center.y);
}

- (void)updateBottomLineViewPosition:(CGFloat)value {
    _bottomLineView.frame = CGRectMake(value, 61, lineViewWidth, 3);
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
        make.width.mas_equalTo(lineViewWidth);
    }];
    
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_btn2.mas_centerY);
        make.right.mas_equalTo(_btn2.mas_left).offset(0);
        make.width.mas_equalTo(lineViewWidth);
    }];
    
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_btn2.mas_centerY);
        make.left.mas_equalTo(_btn2.mas_right).offset(0);
        make.width.mas_equalTo(lineViewWidth);
    }];
}


@end
