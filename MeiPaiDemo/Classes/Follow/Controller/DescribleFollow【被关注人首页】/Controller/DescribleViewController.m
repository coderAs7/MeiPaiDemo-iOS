//
//  DescribleViewController.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/19.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "DescribleViewController.h"
#import "DescribleView.h"
@interface DescribleViewController ()

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
    
    DescribleView *view = [[DescribleView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:view];
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
