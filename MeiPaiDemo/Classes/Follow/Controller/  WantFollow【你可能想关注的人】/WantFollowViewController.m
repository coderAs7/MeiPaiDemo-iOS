//
//  WantFollowViewController.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "WantFollowViewController.h"
#import "WantTableViewCell.h"

static NSString *const wantFollowIdentifier = @"wantFollowIdentifier";

@interface WantFollowViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSArray *imageDataArray;

@property (nonatomic,copy)NSArray *titleDataArray;

@property (nonatomic,copy)NSArray *messageDataArray;

@property (nonatomic,strong)NSMutableArray *scrollViewArray;

//@property (nonatomic,strong)NSMutableArray *blockArray;

@end

@implementation WantFollowViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_bar_back_b"] style:UIBarButtonItemStyleDone target:self action:@selector(action_back)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(45, 47, 55);
    self.title = @"你可能想关注的人";
    self.scrollViewArray = [NSMutableArray array];
    [self loadUI];
}

- (void)action_back {
    if (self.backBlock) {
        self.backBlock(self.scrollViewArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- loadUI

- (void)loadUI {
    self.imageDataArray = @[@"Effects10",@"Effects10",@"Effects10",@"Effects10",@"Effects10",@"Effects10",@"Effects10",@"Effects10",@"Effects10",@"Effects10"];
    self.titleDataArray = @[@"周杰伦",@"孙燕姿",@"周杰伦",@"孙燕姿",@"周杰伦",@"孙燕姿",@"周杰伦",@"孙燕姿",@"周杰伦",@"周杰伦"];
    self.messageDataArray = @[@"哇塞哇塞",@"哇塞哇塞哇塞哇塞",@"哇塞哇塞",@"哇塞哇塞哇塞哇塞",@"哇塞哇塞",@"哇塞哇塞哇塞哇塞",@"哇塞哇塞哇塞哇塞",@"哇塞哇塞",@"哇塞哇塞哇塞哇塞",@"哇塞哇塞"];
    [self.view addSubview:self.tableView];
    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.top.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view).offset(0);
//    }];
    
    
    UIView *tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, FN(50))];
    tableHeadView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    self.tableView.tableHeaderView = tableHeadView;

    
    UISearchBar *search = [[UISearchBar alloc]init];
    search.searchBarStyle = UISearchBarStyleProminent;
    search.layer.masksToBounds = YES;
    search.layer.cornerRadius = 5;
    search.placeholder = @"搜索美拍用户（昵称/ID号）";
    search.backgroundColor = RGB(45, 47, 55);
    [tableHeadView addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableHeadView).offset(5);
        make.right.equalTo(tableHeadView).offset(-5);
        make.top.equalTo(tableHeadView).offset(5);
    }];
    
    for (UIView *view in search.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
}

#pragma mark -- tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FN(70);
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return FN(50);
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headView = [[UIView alloc]init];
//    headView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
//    return headView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wantFollowIdentifier];
    if (!cell) {
        cell = [[WantTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:wantFollowIdentifier];
    }
    cell.backgroundColor = RGB(45, 47, 55);
    [cell dataSource:@[self.imageDataArray,self.titleDataArray,self.messageDataArray] With:indexPath];
//    __weak typeof(self)weakSelf = self;
    [cell.followButton backMethod:^{
        if ([cell.followButton.titleLabel.text isEqualToString:@"关注"]) {
            [cell.followButton setTitle:@"已关注" forState:UIControlStateNormal];
            cell.followButton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
            [self.scrollViewArray addObject:@"1"];
        }else{
            [cell.followButton setTitle:@"关注" forState:UIControlStateNormal];
            cell.followButton.backgroundColor = RGB(84, 151, 90);
            if (self.scrollViewArray.count > 0) {
                [self.scrollViewArray removeObjectAtIndex:0];
            }
        }
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"WantTableViewCell" bundle:[NSBundle bundleWithIdentifier:@"WantTableViewCell"]] forCellReuseIdentifier:wantFollowIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
