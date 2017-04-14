//
//  MPNavigationBar.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPNavigationBar.h"

@interface MPNavigationBar ()

@property(nonatomic,strong)UIViewController * viewController;

@end

@implementation MPNavigationBar

+(MPNavigationBar *)navigationBarInViewController:(UIViewController *)viewController
{
    return [[MPNavigationBar alloc]initWithViewController:viewController];
}


-(instancetype)initWithViewController:(UIViewController *)viewController
{
    if (!viewController)
    {
        return nil;
    }
    self.viewController = viewController;
    
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0)])
    {
        if (!self.viewController.navigationController)
        {
            return nil;
        }
        [self insertNavigationBarWithViewController:viewController];
    }
    return self;
}

-(void)insertNavigationBarWithViewController:(UIViewController *)viewController
{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"title";
    self.titleLabel.font = [UIFont systemFontOfSize:16.0F];
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height + 20);
    [self addSubview:self.titleLabel];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    self.leftButton.userInteractionEnabled = YES;
    [self.leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(clickedLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
    
    NSArray * VCArray = self.viewController.navigationController.viewControllers;
    
    if (VCArray[0] == self.viewController)
    {
        [self.leftButton removeFromSuperview];
    }
    [self.viewController.view addSubview:self];
    [self.viewController.view bringSubviewToFront:self];
    //[self.viewController.view addObserver:self forKeyPath:@"subviews.count" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.backgroundColor = [UIColor redColor];
}

-(void)clickedLeftButton:(UIButton *)button
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if([keyPath isEqualToString:@"subviews.count"])
//    {
//        [self.viewController.view bringSubviewToFront: self];
//    }
//}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
