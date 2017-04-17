//
//  MPPhotoViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPPhotoViewController.h"

@interface MPPhotoViewController ()

@end

@implementation MPPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MPColor_VCBackgroundGray;
    
    [self insertViewController];
}

-(void)insertViewController
{
    UIButton * closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    [closeButton addTarget:self action:@selector(clickedCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:[UIImage imageNamed:@"btn_banner_a"] forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    
}

-(void)clickedCloseButton:(UIButton *)sender
{
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
