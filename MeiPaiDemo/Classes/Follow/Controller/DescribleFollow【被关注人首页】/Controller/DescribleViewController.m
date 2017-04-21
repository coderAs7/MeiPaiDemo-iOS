//
//  DescribleViewController.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/19.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "DescribleViewController.h"
#import "DescribleView.h"
@interface DescribleViewController () {
    DescribleView *view;
}

@end

@implementation DescribleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_bar_back_b"] style:UIBarButtonItemStyleDone target:self action:@selector(action_back)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
}
- (void)action_back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(45, 47, 55);
    
    view = [[DescribleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
    [self.view addSubview:view];
}


- (void)dealloc {
    [view removeFromSuperview];
    view = nil;
}

@end
