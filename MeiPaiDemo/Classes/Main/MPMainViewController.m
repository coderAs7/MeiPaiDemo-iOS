//
//  MPMainViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/12.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainViewController.h"

#import "CollectionViewLayout.h"
#import "MPMainViewCell.h"
#import "PrefixHeader.pch"

@interface MPMainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewLayoutDelegate>
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CollectionViewLayout *layout = [[CollectionViewLayout alloc] init];
    layout.delegate = self;
    layout.columnCount = 2;
    layout.rowSpacing = 4;
    layout.columnSpacing = 4;
    layout.sectionInset = UIEdgeInsetsMake(64, 0, 10, 0);

    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MPMainViewCell class] forCellWithReuseIdentifier:@"MPMainCollectionViewCell"];
    _collectionView.backgroundColor = MPColor_VCBackgroundGray;
    UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    _effectView = [[UIVisualEffectView alloc] initWithEffect:eff];
    
    _effectView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    [self.view addSubview:_effectView];
    
}
//
//-(void)viewWillAppear:(BOOL)animated  {
//    [super viewWillAppear:animated];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//}

- (CGFloat)collectionViewLayout:(CollectionViewLayout *)layout itemHeightForIndexPath:(NSIndexPath *)indexPath {
    return 280;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MPMainViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MPMainCollectionViewCell" forIndexPath:indexPath];
//    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Effects2"]];
//    [cell.contentView addSubview:img];
    //cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
