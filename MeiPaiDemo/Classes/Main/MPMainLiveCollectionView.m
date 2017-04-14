//
//  [cell creatCollectionView:_layout forInteger:indexPath.item]; MPMainLiveCollectionView.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainLiveCollectionView.h"
#import "PrefixHeader.pch"

#import "CollectionViewLayout.h"
#import "MPMainViewCell.h"

@interface MPMainLiveCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arr;

@end
@implementation MPMainLiveCollectionView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CollectionViewLayout *layout = [[CollectionViewLayout alloc] init];
        layout.delegate = self;
        layout.columnCount = 2;
        layout.rowSpacing = 0;
        layout.columnSpacing = 3;
        layout.sectionInset = UIEdgeInsetsMake(280, 0, 10, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MPMainViewCell class] forCellWithReuseIdentifier:@"MPMainCollectionViewCell"];
        _collectionView.backgroundColor = MPRGB(42, 41, 55);
        
    }
    return self;
}

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


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
}


@end
