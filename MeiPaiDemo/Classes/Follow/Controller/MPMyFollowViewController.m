//
//  MPMyFollowViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMyFollowViewController.h"
#import "NotFollowView.h"
#import "WantFollowViewController.h"
#import "FollowTableView.h"
#import "DescribleViewController.h"
@interface MPMyFollowViewController () {
    FollowTableView *followView;
    NotFollowView  *notView;
}

@end

@implementation MPMyFollowViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationBar setBarTintColor:[UIColor colorWithRed:246/255.0f green:106/255.0f blue:108/255.0f alpha:1.000]];
//    [self.navigationController.navigationBar setBarTintColor:RGB(246, 106, 108)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的关注";
    
    [MPNavigationBar navigationBarInViewController:self];

    self.view.backgroundColor = RGB(45, 47, 55);
    
    __weak typeof(self)weakSelf = self;
    notView = [[NotFollowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64)];
    
    notView.block = ^(){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf loadWantVC];
            
        });
    };
    [self.view addSubview:notView];
    
}

- (void)loadWantVC {
    __weak typeof(self)weakSelf = self;
    WantFollowViewController *vc = [[WantFollowViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.backBlock = ^(NSArray *array){
        if (array.count > 0) {
            [weakSelf loadAnother:array];
        }
    };
    [weakSelf.navigationController pushViewController:vc animated:YES];
}

- (void)loadAnother:(NSArray *)array {
    __weak typeof(self)weakSelf = self;
    [notView removeFromSuperview];
    if (followView) {
        [followView removeFromSuperview];
        followView = nil;
    }
    followView = [[FollowTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64) withData:array];
    followView.headButtonBlock = ^(){
        DescribleViewController *vc = [[DescribleViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:followView];
}



@end
