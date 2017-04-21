//
//  GPUImageBeautifyFilter.h
//  BeautifyFaceDemo
//
//  Created by guikz on 16/4/28.
//  Copyright © 2016年 guikz. All rights reserved.
//

#import "GPUImage.h"

@class GPUImageCombinationFilter;

@interface GPUImageBeautifyFilter : GPUImageFilterGroup {
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}

@end




//        //  1. 创建视频摄像头
//        // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
//        // cameraPosition:摄像头方向
//        // 最好使用AVCaptureSessionPresetHigh，会自动识别，如果用太高分辨率，当前设备不支持会直接报错
//        GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
//
//        //  2. 设置摄像头输出视频的方向
//        videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
//        _videoCamera = videoCamera;
//
//        //  3. 创建用于展示视频的GPUImageView
//        GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
//        [self.view insertSubview:captureVideoPreview atIndex:0];
//
//        //  4.创建磨皮、美白组合滤镜
//        GPUImageFilterGroup *groupFliter = [[GPUImageFilterGroup alloc] init];
//
//        //  5.磨皮滤镜
//        GPUImageBilateralFilter *bilateralFilter = [[GPUImageBilateralFilter alloc] init];
//        [groupFliter addFilter:bilateralFilter];
//        _bilateralFilter = bilateralFilter;
//
//        //  6.美白滤镜
//        GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
//        [groupFliter addFilter:brightnessFilter];
//        _brightnessFilter = brightnessFilter;
//
//
//          //7.设置滤镜组链
//        [bilateralFilter addTarget:brightnessFilter];
//        [groupFliter setInitialFilters:@[bilateralFilter]];
//        groupFliter.terminalFilter = brightnessFilter;
//
//        //  8.设置GPUImage处理链 从数据源->滤镜->界面展示
//        [videoCamera addTarget:groupFliter];
//        [groupFliter addTarget:captureVideoPreview];
//
//        //  9.调用startCameraCapture采集视频,底层会把采集到的视频源，渲染到GPUImageView上，接着界面显示
//        [videoCamera startCameraCapture];
//
//
