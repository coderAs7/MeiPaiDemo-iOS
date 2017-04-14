//
//  MPNavigationBar.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPNavigationBar : UIView

@property(nonatomic,strong)UIButton * leftButton;
@property(nonatomic,strong)UILabel * titleLabel;

+(MPNavigationBar *)navigationBarInViewController:(UIViewController *)viewController;

@end
