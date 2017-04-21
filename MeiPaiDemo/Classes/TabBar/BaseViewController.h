//
//  BaseViewController.h
//  仿写战旗TV
//
//  Created by liuhu on 2017/4/5.
//  Copyright © 2017年 liuhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//有title
- (void)showNavWithTitle:(NSString *)title controller:(UIViewController *)controller;

//隐藏nav
- (void)hideNavigationController;

- (UIButton *)showLeftBackButton;
@end
