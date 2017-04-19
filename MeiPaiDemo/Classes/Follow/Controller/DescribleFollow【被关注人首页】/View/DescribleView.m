//
//  DescribleView.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/19.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "DescribleView.h"
#import "DescribleTableViewCell.h"
@interface DescribleView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIView *butView;

@end

@implementation DescribleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    
    [self addSubview:self.tableView];
    
    
    [self tableHeadView];
}


#pragma mark -- headView 

- (void)tableHeadView {
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
    self.tableView.tableHeaderView = backgroundView;
    
    UIImageView *backgroundImage = [[UIImageView alloc]init];
    backgroundImage.image = [UIImage imageNamed:@"mv10"];
    backgroundImage.clipsToBounds = YES;
    backgroundImage.backgroundColor = [UIColor blackColor];
    [backgroundView addSubview:backgroundImage];
    
    
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
//    self.tableView.tableHeaderView = headView;
    [backgroundView addSubview:headView];
    
   
    
    UIImageView *headImage = [[UIImageView alloc]init];
    headImage.backgroundColor = [UIColor whiteColor];
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = FN(50);
    headImage.image = [UIImage imageNamed:@"mv10"];
    [headView addSubview:headImage];
    
    
    UILabel *headLabel = [[UILabel alloc]init];
    headLabel.font = [UIFont systemFontOfSize:FN(13)];
    headLabel.textColor = [UIColor whiteColor];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.text = @"关注26   |   粉丝57.1万";
    [headView addSubview:headLabel];
    
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.titleLabel.font = [UIFont systemFontOfSize:FN(12)];
    [headButton setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateNormal];
    [headButton setImage:[UIImage imageNamed:@"icon_cell_likesmall_a"] forState:UIControlStateNormal];
    headButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [headButton setTitle:@"被赞205.4万次" forState:UIControlStateNormal];
    [headView addSubview:headButton];
    
    
    UIButton *silkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    silkButton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    [silkButton setTitle:@"粉丝榜" forState:UIControlStateNormal];
    [silkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    silkButton.layer.masksToBounds = YES;
    silkButton.layer.cornerRadius = 15;
    silkButton.titleLabel.font = [UIFont systemFontOfSize:FN(15)];
    [headView addSubview:silkButton];
    
    NSString *labelString = @"这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述这是我的描述";
    
    CGFloat heiY = [self calculateRowHeight:labelString fontSize:FN(13)] + FN(365);
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.offset(FN(heiY));
    }];
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.offset(FN(260));
    }];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.offset(FN(260));
    }];
    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView).offset(FN(20));
        make.size.mas_equalTo(CGSizeMake(FN(100), FN(100)));
    }];
    
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImage.mas_bottom).offset(10);
        make.centerX.equalTo(headView.mas_centerX);
    }];
    
    [headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headLabel.mas_bottom).offset(10);
        make.centerX.equalTo(headView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(FN(300), FN(20)));
    }];
    
    [silkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headButton.mas_bottom).offset(10);
        make.centerX.equalTo(headView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(FN(200), FN(30)));
    }];
    
    
    //私信  关注
    NSArray *array = @[@"私信",@"关注"];
    CGFloat wid = (SCREEN_WIDTH - FN(40))/2;
    for (int i = 0; i < 2; i ++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(FN(10), CGRectGetHeight(headView.frame) + FN(10), wid, FN(38));
        [but setTitle:array[i] forState:UIControlStateNormal];
        but.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        but.layer.masksToBounds = YES;
        but.layer.cornerRadius = FN(8);
        [backgroundView addSubview:but];
        CGFloat butX = FN(10) + i * (FN(10) + wid);
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView).offset(butX);
            make.top.equalTo(headView.mas_bottom).offset(FN(20));
            make.size.mas_equalTo(CGSizeMake(FN(wid), FN(32)));
        }];
    }
    
    //简介
    UILabel *describleLabel = [[UILabel alloc]init];
    describleLabel.font = [UIFont systemFontOfSize:FN(13)];
    describleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    describleLabel.text = labelString;
    describleLabel.numberOfLines = 0;
    [backgroundView addSubview:describleLabel];
    [describleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(5);
        make.right.equalTo(backgroundView).offset(-5);
        make.top.equalTo(headView.mas_bottom).offset(FN(55));
    }];
    
    __weak typeof(self)weakSelf = self;
    //切换
    NSArray *qieArray = @[@"98美拍",@"25转发"];
    for (int i = 0; i < 2; i ++) {
        CGFloat butX = FN(10) + i * (FN(10) + wid);
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(FN(10), CGRectGetHeight(describleLabel.frame) + FN(10), wid, FN(38));
        [but setTitle:qieArray[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        but.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -FN(10), 0);
        [but backMethod:^{
            if (i == 0) {
                [weakSelf.butView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(backgroundView).offset(FN(butX));
                    make.top.equalTo(describleLabel.mas_bottom).offset(FN(42));
                    make.size.mas_equalTo(CGSizeMake(FN(wid), FN(3)));
                }];
            }else{
                [weakSelf.butView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(backgroundView).offset(FN(butX));
                    make.top.equalTo(describleLabel.mas_bottom).offset(FN(42));
                    make.size.mas_equalTo(CGSizeMake(FN(wid), FN(3)));
                }];
            }
        }];
        [backgroundView addSubview:but];
        
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView).offset(butX);
            make.top.equalTo(describleLabel.mas_bottom).offset(FN(10));
            make.size.mas_equalTo(CGSizeMake(FN(wid), FN(32)));
        }];
    }
    self.butView = [[UIView alloc]init];
    self.butView.backgroundColor = [UIColor redColor];
    [backgroundView addSubview:self.butView];
    [self.butView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView).offset(FN(10));
        make.top.equalTo(describleLabel.mas_bottom).offset(FN(42));
        make.size.mas_equalTo(CGSizeMake(FN(wid), FN(3)));
    }];

}


- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - FN(20), 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}
#pragma mark -- tableView and delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DescribleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (!cell) {
        cell = [[DescribleTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    }
    return cell;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(45, 47, 55);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
