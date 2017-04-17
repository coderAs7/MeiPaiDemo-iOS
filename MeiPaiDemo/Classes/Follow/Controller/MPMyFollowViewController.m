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
@interface MPMyFollowViewController ()

@end

@implementation MPMyFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"我的关注";
    self.view.backgroundColor = RGB(45, 47, 55);
    
//    __weak typeof(self)weakSelf = self;
//    NotFollowView *notView = [[NotFollowView alloc]initWithFrame:self.view.frame];
//    notView.block = ^(){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            WantFollowViewController *vc = [[WantFollowViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        });
//    };
//    [self.view addSubview:notView];
    
    
    
    FollowTableView *followView = [[FollowTableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:followView];
}



@end
