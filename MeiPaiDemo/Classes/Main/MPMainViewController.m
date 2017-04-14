//
//  MPMainViewController.m
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/12.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainViewController.h"

#import "CollectionViewLayout.h"

@interface MPMainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewLayoutDelegate>
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    CollectionViewLayout *layout = [[CollectionViewLayout alloc] init];
//    
//    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    [self.view addSubview:_collectionView];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MPMainCollectionViewCell"];
//    
//    UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    
//    _effectView = [[UIVisualEffectView alloc] initWithEffect:eff];
//    
//    _effectView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
//    [self.view addSubview:_effectView];
    
}

-(void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (CGFloat)collectionViewLayout:(CollectionViewLayout *)layout itemHeightForIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MPMainCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
