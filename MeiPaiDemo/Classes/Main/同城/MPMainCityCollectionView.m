//
//  MPMainCityCollectionView.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainCityCollectionView.h"
#import "CollectionViewLayout.h"
#import "MPMainViewCell.h"
#import "MPMainViewCityCell.h"

@interface MPMainCityCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arr;

@end

@implementation MPMainCityCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CollectionViewLayout *layout = [[CollectionViewLayout alloc] init];
        layout.delegate = self;
        layout.columnCount = 2;
        layout.rowSpacing = 0;
        layout.columnSpacing = 3;
        layout.sectionInset = UIEdgeInsetsMake(60, 0, 10, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MPMainViewCell class] forCellWithReuseIdentifier:@"MPMainCollectionViewCell"];
        [_collectionView registerClass:[MPMainViewCityCell class] forCellWithReuseIdentifier:@"MPMainViewCityCell"];
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
    if (indexPath.item % 2 == 0) {
        MPMainViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MPMainCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    MPMainViewCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MPMainViewCityCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 2 == 0) {
        if ([self.delegate respondsToSelector:@selector(cityCollectionViewDidSelectItemAtIndexPath:inIdentifier:)]) {
            [self.delegate cityCollectionViewDidSelectItemAtIndexPath:indexPath inIdentifier:0];
        }

    } else {
        if ([self.delegate respondsToSelector:@selector(cityCollectionViewDidSelectItemAtIndexPath:inIdentifier:)]) {
            [self.delegate cityCollectionViewDidSelectItemAtIndexPath:indexPath inIdentifier:1];
        }

    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
}

@end
