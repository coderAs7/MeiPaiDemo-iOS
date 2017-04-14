//
//  MPMainViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/12.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainViewController.h"

@interface MPMainViewController ()
@property (nonatomic, strong) UIVisualEffectView *effectView;
@end

@implementation MPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    _effectView = [[UIVisualEffectView alloc] initWithEffect:eff];
    
    _effectView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    [self.view addSubview:_effectView];
    
}

-(void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
