//
//  NotFollowView.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "NotFollowView.h"

@implementation NotFollowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}


- (void)loadUI {
    UILabel *label = [[UILabel alloc]init];
//    label.center = self.center;
    label.numberOfLines = 2;
    label.text = @"咦？没内容啦？快去添加关注，看更多好玩有趣的美拍！";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:FN(14)];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.backgroundColor = RGB(100, 177, 138);
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setTitle:@"你可能想关注的人" forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:FN(16)];
    [but addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    but.layer.cornerRadius = 5;
    [self addSubview:but];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FN(35));
        make.right.equalTo(self).offset(-FN(35));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(FN(35));
        make.right.equalTo(self).offset(-FN(35));
        make.height.offset(FN(40));
        make.top.equalTo(label.mas_bottom).offset(FN(20));
        
    }];
}

- (void)action_back {
    if (self.block) {
        self.block();
    }
}

@end
