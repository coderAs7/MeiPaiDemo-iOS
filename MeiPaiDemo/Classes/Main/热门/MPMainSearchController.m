//
//  MPMainSearchController.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainSearchController.h"
#import "CustomSearchBar.h"

@interface MPMainSearchController ()<UISearchBarDelegate>
@property (nonatomic, strong) CustomSearchBar *searchBar;
@end

@implementation MPMainSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MPRGB(42, 41, 55);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:view];
    view.backgroundColor = MPColor_VCBackgroundGray;
    _searchBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(10, 24, SCREEN_WIDTH - 20, 32)];
    _searchBar.delegate = self;
    [view addSubview:_searchBar];
    [_searchBar becomeFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
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
