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
    
    if (self = [super initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 64.0)])
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
    self.titleLabel.text = viewController.title;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0F];
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + 10);
    [self addSubview:self.titleLabel];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    self.leftButton.userInteractionEnabled = YES;
    self.leftButton.backgroundColor = [UIColor blueColor];
    [self.leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(clickedLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
    
    NSArray * VCArray = self.viewController.navigationController.viewControllers;
    
    if (VCArray[0] == self.viewController)
    {
        [self.leftButton removeFromSuperview];
    }
    //[self.window addSubview:self];
    //[self.viewController.view bringSubviewToFront:self];
    //[self.viewController.view addObserver:self forKeyPath:@"subviews.count" options:NSKeyValueObservingOptionNew context:NULL];
    //viewController.navigationController.navigationBar.tintColor = [UIColor redColor];
    //self.backgroundColor = [UIColor redColor];
    //self.viewController.navigationController.navigationBar = self;
    
    [self.viewController addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(void)clickedLeftButton:(UIButton *)button
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"title"])
    {
        self.titleLabel.text = @"111";
        //[self.viewController.view bringSubviewToFront: self];
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
