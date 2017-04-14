//
//  MPMainViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/12.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainViewController.h"

#import "MPMainViewBigCell.h"
#import "PrefixHeader.pch"
#import "MPMainTopView.h"

@interface MPMainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, MPMainTopViewDelegate>

@property (nonatomic, strong) MPMainTopView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MPMainViewBigCell class] forCellWithReuseIdentifier:@"MPMainViewBigCell"];
    [self.view addSubview:_collectionView];
    
    _topView = [[MPMainTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_topView];
    _topView.delegate = self;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MPMainViewBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MPMainViewBigCell" forIndexPath:indexPath];
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)topViewBtnClick:(UIButton *)sender {

    NSIndexPath *path = [NSIndexPath indexPathForItem:sender.tag-1 inSection:0];
    
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger i = scrollView.contentOffset.x / SCREEN_WIDTH;

    [_topView btnInTag:i + 1];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat x = scrollView.contentOffset.x;
    if (x < 0 || x > SCREEN_WIDTH * 2) {
        return;
    }
    CGFloat f =  x / SCREEN_WIDTH * 80 + SCREEN_WIDTH / 2 - 120;
    [_topView updateBottomLineViewPosition:f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
