//
//  NotFollowView.h
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^wantFollowBlock)();

@interface NotFollowView : UIView

@property (nonatomic,copy)wantFollowBlock block;

@end
