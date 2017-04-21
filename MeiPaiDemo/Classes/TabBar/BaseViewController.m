//
//  BaseViewController.m
//  仿写战旗TV
//
//  Created by liuhu on 2017/4/5.
//  Copyright © 2017年 liuhu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic,strong)UIView *navView;

@property (nonatomic,strong)UIImageView *image;

@property (nonatomic,strong)UIButton    *button;

@property (nonatomic,strong)UISearchBar *searchBar;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self replaceNavigationController];
}

- (void)hideNavigationController {
    self.navView.hidden = YES;
}

-(void)dealloc{
    NSLog(@"★★★★★★★★★★释放类%@★★★★★★★★★★",[NSString stringWithUTF8String:object_getClassName(self)]);
}

- (UIButton *)showLeftBackButton{
    __weak typeof(self)weakSelf = self;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, (64 - 40)/2 + 5, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton backMethod:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:backButton];
    return backButton;
}


- (void)showNavWithTitle:(NSString *)title controller:(UIViewController *)controller{
    [controller.view addSubview:self.navView];
    for (UIView *view in self.navView.subviews) {
        [view removeFromSuperview];
    }
    self.navView.hidden = NO;
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:FN(18)];
    label.textColor = [UIColor blackColor];
    [self.navView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navView.mas_centerY);
        make.centerX.equalTo(self.navView.mas_centerX);
    }];
    
}


- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _navView.backgroundColor = RGB(80, 130, 212);
    }
    return _navView;
}

//顶部nav
- (void)replaceNavigationController {
//    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];//113 158 242
//    self.navView.backgroundColor = COLOR(80, 130, 212);
    [self.view addSubview:self.navView];
    
    self.image = [[UIImageView alloc]init];
    self.image.image = [UIImage imageNamed:@"nav_home_logo"];
    self.image.clipsToBounds = YES;
    [self.navView addSubview:self.image];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.navView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.barStyle = 0;
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.layer.cornerRadius = 33;
    self.searchBar.barTintColor = RGB(80, 130, 212);
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.tintColor = [UIColor whiteColor];
    [self.navView addSubview:self.searchBar];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).offset(5);
        make.bottom.equalTo(self.navView.mas_bottom).offset(-5);
        make.height.offset(35);
        make.right.equalTo(self.view).offset(-40);
    }];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setBackgroundImage:[UIImage imageNamed:@"nav_home_sao"] forState:UIControlStateNormal];
    [self.button backMethod:^{
        NSLog(@"点击了扫一扫");
    }];
    [self.navView addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-5);
        make.bottom.equalTo(self.navView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
}

@end
