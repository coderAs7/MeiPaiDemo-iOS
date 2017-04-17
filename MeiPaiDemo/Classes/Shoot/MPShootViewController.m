//
//  MPShootViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPShootViewController.h"
#import "MPShootViewScrollCell.h"

@interface MPShootViewController ()

@property(nonatomic,strong)UIButton * closeButton;
@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UIScrollView * scrollView;

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
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150, SCREEN_WIDTH, 150)];
    self.bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:self.bottomView];
    
    self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.closeButton.center = CGPointMake(self.bottomView.bounds.size.width/2, self.bottomView.bounds.size.height - 30);
    self.closeButton.backgroundColor = [UIColor grayColor];
    [self.closeButton addTarget:self action:@selector(clickedCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.closeButton];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 80)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH / 4 * 5 + 30 * 2, 80);
    self.scrollView.bounces = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.scrollView];
    
    
    MPShootViewScrollCell * liveCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"直播"];
    MPShootViewScrollCell * shootVideoCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"短视频"];
    MPShootViewScrollCell * DBChallengeCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 * 2, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"分贝挑战"];
    MPShootViewScrollCell * tenSPosterCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 * 3, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"10秒海报"];
    MPShootViewScrollCell * photoCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 * 4, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"照片"];
    
    [self.scrollView addSubview:liveCell];
    [self.scrollView addSubview:shootVideoCell];
    [self.scrollView addSubview:DBChallengeCell];
    [self.scrollView addSubview:tenSPosterCell];
    [self.scrollView addSubview:photoCell];
    
    
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
