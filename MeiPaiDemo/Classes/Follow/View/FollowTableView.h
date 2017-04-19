//
//  FollowTableView.h
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowTableView : UIView

@property (nonatomic,copy)void(^headButtonBlock)();

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)array;

@end
