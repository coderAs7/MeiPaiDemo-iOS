//
//  MPTabBarController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/12.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPTabBarController.h"
#import "MPTabBar.h"
#import "MPMainViewController.h"
#import "MPMyFollowViewController.h"
#import "MPChannelsViewController.h"
#import "MPUserCenterViewController.h"
#import "MPShootViewController.h"
#import "MPNavigationBar.h"

@interface MPTabBarController () <MPTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;
//@property (nonatomic, strong) MPTabBar *tabbar;

@end

@implementation MPTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 自定义tabBar
    [self setUpTabBar];
    // 添加所有子控制器
    [self setUpAllChildViewController];
}


- (void)setUpTabBar{
    
    //去除tabbar顶部的线
    CGRect rect = CGRectMake(0,0,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame));
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
    
    self.tabBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.tabBar.tintColor = MPColor_Pink;
    
    // 自定义tabBar
//    MPTabBar *tabBar = [[MPTabBar alloc] initWithFrame:self.tabBar.bounds];
//    tabBar.backgroundColor = [UIColor whiteColor];
//    tabBar.delegate = self;
//    tabBar.items = self.items;
//    self.tabbar = tabBar;

//    for (UIView *view in self.tabBar.subviews) {
//        [view removeFromSuperview];
//    }
    
    //[self.tabBar addSubview:tabBar];
}


- (void)setUpAllChildViewController{
    
    self.viewControllers = @[
    [self createNCWithClass:[MPMainViewController class] title:@"美拍" image:[UIImage imageNamed:@"emoji_flower_n"] selectedImage:[UIImage imageNamed:@"emoji_flower_s"]],
    [self createNCWithClass:[MPMyFollowViewController class] title:@"我的关注" image:[UIImage imageNamed:@"emoji_flower_n"] selectedImage:[UIImage imageNamed:@"emoji_flower_s"]],
    [self createNCWithClass:[MPShootViewController class] title:@"" image:nil selectedImage:nil],
    [self createNCWithClass:[MPChannelsViewController class] title:@"频道" image:[UIImage imageNamed:@"emoji_flower_n"] selectedImage:[UIImage imageNamed:@"emoji_flower_s"]],
    [self createNCWithClass:[MPUserCenterViewController class] title:@"我" image:[UIImage imageNamed:@"emoji_flower_n"] selectedImage:[UIImage imageNamed:@"emoji_flower_s"]]];
    
    //自定义按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 0, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"AppIcon40x40"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"AppIcon29x29"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(tabBarDidClickPlusButton) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:btn];
}

-(UINavigationController *)createNCWithClass:(Class)class title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    UIViewController * VC = [[class alloc]init];
    VC.view.backgroundColor = MPColor_VCBackgroundGray;
    UINavigationController * NC = [[UINavigationController alloc]initWithRootViewController:VC];
    NC.title = title;
    NC.tabBarItem.image = image;
    NC.tabBarItem.selectedImage = selectedImage;
    NC.navigationBarHidden = YES;
    [MPNavigationBar navigationBarInViewController:VC];
    //NC.navigationBar.barStyle = UIStatusBarStyleLightContent;
    //[VC setNeedsStatusBarAppearanceUpdate];
    return NC;
}

- (void)tabBarDidClickPlusButton
{
    MPShootViewController * shootVC = [[MPShootViewController alloc]init];
    shootVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    [self presentViewController:shootVC animated:NO completion:nil];
}

- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)tabBar:(MPTabBar *)tabBar didClickButton:(NSInteger)index{
    
}

- (void)tabBarDidClickPlusButton:(MPTabBar *)tabBar  didClickButton:(UIButton *)button{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
