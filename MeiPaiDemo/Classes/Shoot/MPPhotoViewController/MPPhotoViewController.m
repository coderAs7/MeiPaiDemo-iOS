//
//  MPPhotoViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPPhotoViewController.h"

#import "GPUImage.h"

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
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 100, 30, 30)];
    button.backgroundColor = MPColor_Pink;
    [button addTarget:self action:@selector(clickedImageButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage * inputImage = [UIImage imageNamed:@"btn_record_big_b"];
    //使用黑白素描滤镜
    GPUImageSketchFilter *disFilter = [[GPUImageSketchFilter alloc] init];
    
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];
    
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,50,inputImage.size.width ,inputImage.size.height);
    [self.view addSubview:imageView];
    
}

-(void)clickedCloseButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickedImageButton:(UIButton *)sender
{
    UIViewController * VC = [[UIViewController alloc]init];
    VC.title = sender.titleLabel.text;
    VC.view.backgroundColor = MPColor_VCBackgroundGray;
    [self.navigationController pushViewController:VC animated:YES];
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
