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

@interface MPTabBarController () <MPTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) MPTabBar *tabbar;

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
    // 自定义tabBar
//    MPTabBar *tabBar = [[MPTabBar alloc] initWithFrame:self.tabBar.bounds];
//    tabBar.backgroundColor = [UIColor whiteColor];
//    tabBar.delegate = self;
//    tabBar.items = self.items;
//    self.tabbar = tabBar;
    
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
    
//    for (UIView *view in self.tabBar.subviews) {
//        [view removeFromSuperview];
//    }
    
    //[self.tabBar addSubview:tabBar];
}


- (void)setUpAllChildViewController{
    
    self.viewControllers = @[
    [self createNCWithClass:[MPMainViewController class] title:@"美拍" image:[UIImage imageNamed:@"ARWatermark"] selectedImage:[UIImage imageNamed:@"ARWatermark"]],
    [self createNCWithClass:[MPMyFollowViewController class] title:@"我的关注" image:[UIImage imageNamed:@"ARWatermark"] selectedImage:[UIImage imageNamed:@"ARWatermark"]],
    [self createNCWithClass:[UIViewController class] title:@"" image:nil selectedImage:nil],
    [self createNCWithClass:[MPChannelsViewController class] title:@"频道" image:[UIImage imageNamed:@"ARWatermark"] selectedImage:[UIImage imageNamed:@"ARWatermark"]],
    [self createNCWithClass:[MPUserCenterViewController class] title:@"我" image:[UIImage imageNamed:@"ARWatermark"] selectedImage:[UIImage imageNamed:@"ARWatermark"]]];
    
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
    UINavigationController * NC = [[UINavigationController alloc]initWithRootViewController:VC];
    NC.title = title;
    NC.tabBarItem.image = image;
    NC.tabBarItem.selectedImage = selectedImage;
    
    //[self.items addObject:VC.tabBarItem];
    
    //[self addChildViewController:NC];
    
    return NC;
}

- (void)tabBarDidClickPlusButton
{
//    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, 250)];
//    _baseView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:_baseView];
//    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(romoveBaseView)];
//    [self.baseView addGestureRecognizer:tapGesture];
}

- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


//- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
//    vc.title = title;
//    vc.tabBarItem.image = image;
//    vc.tabBarItem.selectedImage = selectedImage;
//    
//    // 保存tabBarItem模型到数组
//    [self.items addObject:vc.tabBarItem];
//    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    vc.navigationController.navigationBarHidden = YES;
//    [self addChildViewController:nav];
//}

- (void)tabBar:(MPTabBar *)tabBar didClickButton:(NSInteger)index{
}

- (void)tabBarDidClickPlusButton:(MPTabBar *)tabBar  didClickButton:(UIButton *)button{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
