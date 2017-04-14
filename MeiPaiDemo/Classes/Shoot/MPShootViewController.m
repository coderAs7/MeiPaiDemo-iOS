//
//  MPShootViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPShootViewController.h"

@interface MPShootViewController ()

@property(nonatomic,strong)UIButton * closeButton;
@property(nonatomic,strong)UIView * bottomView;

@end

@implementation MPShootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self insertViewController];
    
    
}

-(void)insertViewController
{
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 400, SCREEN_WIDTH, 400)];
    self.bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:self.bottomView];
    
    self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.closeButton.center = CGPointMake(self.bottomView.bounds.size.width/2, self.bottomView.bounds.size.height - 30);
    self.closeButton.backgroundColor = [UIColor grayColor];
    [self.closeButton addTarget:self action:@selector(clickedCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.closeButton];
}

-(void)clickedCloseButton:(UIButton *)button
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
