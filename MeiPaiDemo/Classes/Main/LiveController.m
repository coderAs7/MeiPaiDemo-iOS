//
//  LiveController.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "LiveController.h"

@interface LiveController ()

@end

@implementation LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 36, 44, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 22;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(clickBtndismissVC) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"X" forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)clickBtndismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
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
