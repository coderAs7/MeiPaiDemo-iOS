//
//  ShortVideoController.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/17.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortVideoController : UIViewController

@end



/*
 GPUImage介绍
 
 * GPUImageFilter就是用来接收源图像，通过自定义的顶点、片元着色器来渲染新的图像，并在绘制完成后通知响应链的下一个对象。GPUImageFramebuffer就是用来管理纹理缓存的格式与读写帧缓存的buffer。
 *
 * 1、GPUImageFilterGroup
 *
 * GPUImageFilterGroup是多个filter的集合，terminalFilter为最终的filter，initialFilters为filter数组。GPUImageFilterGroup本身不绘制图像，对GPUImageFilterGroup添加删除Target操作的操作都会转为terminalFilter的操作。
 *
 * 2、GPUImageTwoInputFilter
 *
 * GPUImageTwoInputFilter是GPUImageFilter的子类，对两个输入纹理进行通用的处理，需要继承它并准备自己的片元着色器。
 *
 * 两个输入纹理默认为inputImageTexture和inputImageTexture2。
 * 重写了下面的函数，修改GPUImageFilter绘制的逻辑。- (void)renderToTextureWithVertices:(const GLfloat *)verticestextureCoordinates:(const GLfloat *)textureCoordinates;下面这部分是核心的绘制逻辑：glActiveTexture()是选择纹理单元，glBindTexture()是把纹理单元和firstInputFramebuffer、secondInputFramebuffer管理的纹理内存绑定。glUniform1i()告诉GLSL选择的纹理单元是2。这部分在上一篇介绍也有提到，再详细阐述：glActiveTexture()选择的是纹理单元，和glGenTextures()返回的数字没有关系，可以在纹理单元2上面绑定纹理12。glGenTextures()返回的纹理可以是GL_TEXTURE_2D类型也可以是GL_TEXTURE_CUBE_MAP类型，取决于glBindTexture()第一次绑定纹理的是GL_TEXTURE_2D还是GL_TEXTURE_CUBE_MAP。 glActiveTexture(GL_TEXTURE2); glBindTexture(GL_TEXTURE_2D, [firstInputFramebuffer texture]); glUniform1i(filterInputTextureUniform, 2); glActiveTexture(GL_TEXTURE3); glBindTexture(GL_TEXTURE_2D, [secondInputFramebuffer texture]); glUniform1i(filterInputTextureUniform2, 3);
 *
 * nextAvailableTextureIndex用于获取下一个纹理索引- (NSInteger)nextAvailableTextureIndex;{if (hasSetFirstTexture) {return 1; }else {return 0; }}setInputFramebuffer: atIndex:会根据上面获取的textureIndex设置firstInputFramebuffer和secondInputFramebuffer。如果是textureIndex = 0，设置hasSetFirstTexture表示已经设置第一个纹理。
 *
 *
 * 3、GPUImageThreeInputFilter
 *
 * GPUImageThreeInputFilter的逻辑与GPUImageTwoInputFilter类似，增加了thirdInputFramebuffer作为第三个纹理inputImageTexture3的输入。
 *
 * 4、GPUImageBeautifyFilter
 *
 * GPUImageBeautifyFilter是基于GPUImage的实时美颜滤镜中的美颜滤镜，包括GPUImageBilateralFilter、GPUImageCannyEdgeDetectionFilter、GPUImageCombinationFilter、GPUImageHSBFilter。
 *
 * 绘制流程
 
 * 1、GPUImageVideoCamera捕获摄像头图像调用newFrameReadyAtTime: atIndex:通知GPUImageBeautifyFilter；
 *
 * 2、GPUImageBeautifyFilter调用newFrameReadyAtTime: atIndex:通知GPUImageBilateralFliter输入纹理已经准备好；
 *
 * 3、GPUImageBilateralFliter 绘制图像后在informTargetsAboutNewFrameAtTime()，调用setInputFramebufferForTarget: atIndex:把绘制的图像设置为GPUImageCombinationFilter输入纹理，并通知GPUImageCombinationFilter纹理已经绘制完毕；
 *
 * 4、GPUImageBeautifyFilter调用newFrameReadyAtTime: atIndex:通知 GPUImageCannyEdgeDetectionFilter输入纹理已经准备好；
 *
 * 5、同3，GPUImageCannyEdgeDetectionFilter 绘制图像后，把图像设置为GPUImageCombinationFilter输入纹理；
 *
 * 6、GPUImageBeautifyFilter调用newFrameReadyAtTime: atIndex:通知 GPUImageCombinationFilter输入纹理已经准备好；
 *
 * 7、GPUImageCombinationFilter判断是否有三个纹理，三个纹理都已经准备好后调用GPUImageThreeInputFilter的绘制函数renderToTextureWithVertices: textureCoordinates:，图像绘制完后，把图像设置为GPUImageHSBFilter的输入纹理,通知GPUImageHSBFilter纹理已经绘制完毕；
 *
 * 8、GPUImageHSBFilter调用renderToTextureWithVertices: textureCoordinates:绘制图像，完成后把图像设置为GPUImageView的输入纹理，并通知GPUImageView输入纹理已经绘制完毕；
 *
 * 9、GPUImageView把输入纹理绘制到自己的帧缓存，然后通过[self.context presentRenderbuffer:GL_RENDERBUFFER];显示到UIView上。
 
 
 GPUImageView
 GPUImageView是响应链的终点，一般用于显示GPUImage的图像。
 1、填充模式
 GPUImageFillModeType fillMode图像的填充模式。
 sizeInPixels 像素区域大小。
 *
 * recalculateViewGeometry() 重新计算图像顶点位置数据。
 *
 * AVMakeRectWithAspectRatioInsideRect() 在保证宽高比不变的前提下，得到一个尽可能大的矩形。
 *
 * 如果是kGPUImageFillModeStretch
 *
 * 图像拉伸，直接使宽高等于1.0即可，原图像会直接铺满整个屏幕。
 * 如果是kGPUImageFillModePreserveAspectRatio
 *
 * 保持原宽高比，并且图像不超过屏幕。那么以当前屏幕大小为准。
 *
 * widthScaling = insetRect.size.width / currentViewSize.width;
 * 如果是kGPUImageFillModePreserveAspectRatioAndFill
 *
 * 保持原宽高比，并且图像要铺满整个屏幕。那么图像大小为准。
 *
 * widthScaling = currentViewSize.height / insetRect.size.height;
 * imageVertices存放着顶点数据，上面的修改都会存放在这个数组。
 *
 *
 
 GPUImageVideoCamera
 
 GPUImageVideoCamera是GPUImageOutput的子类，提供来自摄像头的图像数据作为源数据，一般是响应链的源头。
 
 1、视频图像采集 ：AVCaptureSession
 
 GPUImage使用AVFoundation框架来获取视频。
 
 AVCaptureSession类从AV输入设备的采集数据到制定的输出。
 
 为了实现实时的图像捕获，要实现AVCaptureSession类，添加合适的输入（AVCaptureDeviceInput）和输出（比如 AVCaptureMovieFileOutput）
 
 调用startRunning开始输入到输出的数据流，调用stopRunning停止数据流。
 
 需要注意的是startRunning函数会花费一定的时间，所以不能在主线程（UI线程）调用，防止卡顿。
 
 sessionPreset 属性可以自定义一些设置。
 
 特殊的选项比如说高帧率，可以通过 AVCaptureDevice来设置。
 
 AVCaptureSession使用的简单示例：
 _captureSession = [[AVCaptureSession alloc] init];
 [_captureSession beginConfiguration];
 // 中间可以实现关于session属性的设置
 [_captureSession commitConfiguration];
 * AVCaptureVideoDataOutputAVCaptureVideoDataOutput是AVCaptureOutput的子类，用来处理从摄像头采集的未压缩或者压缩过的图像帧。通过captureOutput:didOutputSampleBuffer:fromConnection: delegate，可以访问图像帧。通过下面这个方法，可以设置delegate。- (void)setSampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate>)sampleBufferDelegatequeue:(dispatch_queue_t)sampleBufferCallbackQueue;需要注意的是，当一个新的视频图像帧被采集后，它会被传送到output，调用这里设置的delegate。所有的delegate函数会在这个queue中调用。如果队列被阻塞，新的图像帧到达后会被自动丢弃(默认alwaysDiscardsLateVideoFrames = YES)。这允许app处理当前的图像帧，不需要去管理不断增加的内存，因为处理速度跟不上采集的速度，等待处理的图像帧会占用内存，并且不断增大。必须使用同步队列处理图像帧，保证帧的序列是顺序的。
 
 frameRenderingSemaphore 帧渲染的信号量下面有一个这样的调用，用于等待处理完一帧后，再接着处理下一帧。     if (dispatch_semaphore_wait(frameRenderingSemaphore, DISPATCH_TIME_NOW) != 0)     {         return;     }     runAsynchronouslyOnVideoProcessingQueue(^{dispatch_semaphore_signal(frameRenderingSemaphore);     });
 rotateCamera前后摄像头翻转：更改videoInput的设置。
 
 
 2、颜色空间：YUV
 
 YUV是被欧洲电视系统所采用的一种颜色编码方法。
 
 采用YUV色彩空间的重要性是它的亮度信号Y和色度信号U、V是分离的。如果只有Y信号分量而没有U、V分量，那么这样表示的图像就是黑白灰度图像。彩色电视采用YUV空间正是为了用亮度信号Y解决彩色电视机与黑白电视机的兼容问题，使黑白电视机也能接收彩色电视信号。
 YCbCr或Y'CbCr有的时候会被写作：YCBCR或是Y'CBCR，是色彩空间的一种，通常会用于影片中的影像连续处理，或是数字摄影系统中。Y'为颜色的亮度(luma)成分、而CB和CR则为蓝色和红色的浓度偏移量成份。
 
 YUV主要用于优化彩色视频信号的传输，使其向后相容老式黑白电视。与RGB视频信号传输相比，它最大的优点在于只需占用极少的频宽（RGB要求三个独立的视频信号同时传输）。
 CbCr 则是在世界数字组织视频标准研制过程中作为ITU - R BT.601 建议的一部分，其实是YUV经过缩放和偏移的翻版。其中Y与YUV 中的Y含义一致,Cb,Cr 同样都指色彩，只是在表示方法上不同而已。在YUV 家族中，YCbCr 是在计算机系统中应用最多的成员，其应用领域很广泛，JPEG、MPEG均采用此格式。一般人们所讲的YUV大多是指YCbCr。YCbCr 有许多取样格式，如4∶4∶4,4∶2∶2,4∶1∶1 和4∶2∶0。
 
 
 GPUImage中的YUV
 
 GLProgram *yuvConversionProgram; 将YUV颜色空间转换成RGB颜色空间的GLSL。
 
 CVPixelBufferGetPlaneCount()返回缓冲区的平面数。
 
 通过CVOpenGLESTextureCacheCreateTextureFromImage()创建两个纹理luminanceTextureRef（亮度纹理）和chrominanceTextureRef（色度纹理）。
 
 convertYUVToRGBOutput()把YUV颜色空间的纹理转换成RGB颜色空间的纹理
 
 顶点着色器-通用kGPUImageVertexShaderString
 
 片元着色器：
 
 1、kGPUImageYUVFullRangeConversionForLAFragmentShaderString
 
 2、kGPUImageYUVVideoRangeConversionForLAFragmentShaderString
 
 区别在不同的格式
 
 video-range (luma=[16,235] chroma=[16,240])
 
 full-range (luma=[0,255] chroma=[1,255])
 
 3、纹理绘制
 
 glActiveTextue 并不是激活纹理单元，而是选择当前活跃的纹理单元。每一个纹理单元都有GL_TEXTURE_1D, 2D, 3D 和 CUBE_MAP。
 
 glActiveTexture(GL_TEXTURE1);
 glGenTextures(1, &_texture);
 glBindTexture(GL_TEXTURE_2D, _texture);
 
 */
