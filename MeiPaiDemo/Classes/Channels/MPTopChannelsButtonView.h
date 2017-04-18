//
//  MPTopChannelsButtonView.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPTopChannelsButtonView;

@protocol MPTopNameButtonViewDelegate <NSObject>

-(void)buttonClicked:(MPTopChannelsButtonView *)sender;

@end

@interface MPTopChannelsButtonView : UIView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image;
@property(nonatomic,strong)NSString * title;

@property(nonatomic,weak)id <MPTopNameButtonViewDelegate> delegate;

@end
