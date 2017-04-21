//
//  MPPhotoViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPPhotoViewController.h"
#import "MPPhotoImagePickerViewController.h"
#import "GPUImage.h"

@interface MPPhotoViewController () < UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate >

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
    
    UIButton * imagePickerButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 100, 30, 30)];
    imagePickerButton.backgroundColor = MPColor_Pink;
    [imagePickerButton addTarget:self action:@selector(clickedImageButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imagePickerButton];
    
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
    
    
//    UIImageView *labView = [UIImageView new];
//    [self.view addSubview:labView];
//    labView.image = [UIImage imageNamed:@"7D73C4EE6FDD715A6DBB8C5F563625AC"];
//    labView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    UILabel * label = [UILabel new];
//    label.text = @"拉伸测试";
//    labView.frame = CGRectMake(10, 200, 240, 120);
//    
//    label.frame = labView.bounds;
//
//    [labView addSubview:label];
    
//    UIImageView *labView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 200, 320, 400)];
//    [self.view addSubview:labView];
//    labView.contentMode = UIViewContentModeScaleAspectFit;
//    UIImage *image = [UIImage imageNamed:@"7D73C4EE6FDD715A6DBB8C5F563625AC"];
//    
//    // 设置端盖的值
//    CGFloat top = image.size.height * 0.5 - 1;
//    CGFloat left = image.size.width * 0.5 - 1;
//    CGFloat bottom = image.size.height * 0.5 - 1;
//    CGFloat right = image.size.width * 0.5 - 1;
//    
//    // 设置端盖的值
//    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
//    // 设置拉伸的模式
//    UIImageResizingMode mode = UIImageResizingModeStretch;
//    
//    // 拉伸图片
//    UIImage *overImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
//    
//    labView.image = overImage;
//    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
//    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
//
//    
}

-(void)clickedCloseButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickedImageButton:(UIButton *)sender
{
//    MPPhotoImagePickerViewController * imagePickerVC = [[MPPhotoImagePickerViewController alloc]init];
//    imagePickerVC.title = sender.titleLabel.text;
//    imagePickerVC.view.backgroundColor = MPColor_VCBackgroundGray;
//    [self.navigationController pushViewController:imagePickerVC animated:YES];
    UIActionSheet *choosePhotoActionSheet;

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        choosePhotoActionSheet = [[UIActionSheet alloc]initWithTitle:NSLocalizedString(@"选取图片",@"")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString (@"取消",@"")
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:NSLocalizedString (@"相机",@""),NSLocalizedString (@" 相册 ",@""),nil];
    }
    else
    {
        choosePhotoActionSheet = [[UIActionSheet alloc ]initWithTitle:NSLocalizedString(@"选取图片",@"")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString (@" 取消 " , @"")
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:NSLocalizedString (@" 相册 " , @""), nil ];
    }
    [choosePhotoActionSheet showInView:self.view];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera ])
    {
        switch (buttonIndex) {
            case 0:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    }
    else
    {
        if (buttonIndex == 1) {
            return;
        }
        else
        {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
    
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
//    self . tmpHeaderImg = [info objectForKey:UIImagePickerControllerEditedImage ];
//    
//    [self . imageViewUserHead setImage:self . tmpHeaderImg ];
//    
//    [self uploadImage ];
//    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
