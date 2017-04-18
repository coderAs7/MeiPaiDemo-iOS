//
//  MPTopNameButtonView.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPTopNameButtonView;

@protocol MPTopNameButtonViewDelegate <NSObject>

-(void)buttonClicked:(MPTopNameButtonView *)sender;

@end

@interface MPTopNameButtonView : UIView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title number:(NSString *)number;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * number;

@property(nonatomic,weak)id <MPTopNameButtonViewDelegate> delegate;


@end
