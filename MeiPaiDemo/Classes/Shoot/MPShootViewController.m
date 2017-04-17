//
//  MPShootViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPShootViewController.h"
#import "MPShootViewScrollCell.h"
#import "MPPhotoViewController/MPPhotoViewController.h"

@interface MPShootViewController () <MPShootViewScrollCellDelegate>

@property(nonatomic,strong)UIButton * closeButton;
@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)MPShootViewScrollCell * liveCell;
@property(nonatomic,strong)MPShootViewScrollCell * shootVideoCell;
@property(nonatomic,strong)MPShootViewScrollCell * DBChallengeCell;
@property(nonatomic,strong)MPShootViewScrollCell * tenSPosterCell;
@property(nonatomic,strong)MPShootViewScrollCell * photoCell;

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
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.scrollView];
    
    
    self.liveCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"直播"];
    self.shootVideoCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"短视频"];
    self.DBChallengeCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 * 2, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"分贝挑战"];
    self.tenSPosterCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 * 3, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"10秒海报"];
    self.photoCell = [[MPShootViewScrollCell alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 * 4, 0, SCREEN_WIDTH / 4, 80) image:[UIImage imageNamed:@""] title:@"照片"];
    
    self.liveCell.delegate = self;
    self.shootVideoCell.delegate = self;
    self.DBChallengeCell.delegate = self;
    self.tenSPosterCell.delegate = self;
    self.photoCell.delegate = self;
    
    [self.scrollView addSubview:self.liveCell];
    [self.scrollView addSubview:self.shootVideoCell];
    [self.scrollView addSubview:self.DBChallengeCell];
    [self.scrollView addSubview:self.tenSPosterCell];
    [self.scrollView addSubview:self.photoCell];
}

-(void)shootCellClicked:(MPShootViewScrollCell *)sender
{
    if (sender == self.liveCell)
    {
        //直播
        
    }
    else if (sender == self.shootVideoCell)
    {
        //短视频
        
    }
    else if (sender == self.DBChallengeCell)
    {
        //分贝挑战(暂空)
    }
    else if (sender == self.tenSPosterCell)
    {
        //十秒海报(暂空)
    }
    else if (sender == self.photoCell)
    {
        //照片
        MPPhotoViewController * photoVC = [[MPPhotoViewController alloc]init];
        [self presentViewController:photoVC animated:YES completion:^{
            
        }];
    }
    else
    {
        
    }
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
