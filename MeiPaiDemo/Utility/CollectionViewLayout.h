//
//  CollectionViewLayout.h
//  Control
//
//  Created by 李明 on 2017/1/20.
//  Copyright © 2017年 李明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionViewLayout;

@protocol CollectionViewLayoutDelegate <NSObject>

@required

- (CGFloat)collectionViewLayout:(CollectionViewLayout *)layout itemHeightForIndexPath:(NSIndexPath *)indexPath;//item高

@optional

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountInSection:(NSInteger)section;//有多少列

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minmumCloumnSpacingForSection:(NSInteger)section;//列间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minmumRowSpacingForSection:(NSInteger)section;//行间距

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectoin:(NSInteger)section;//所有item组成的整体与屏幕的间距

@end

@interface CollectionViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id <CollectionViewLayoutDelegate> delegate;

@property (nonatomic, assign) NSInteger columnCount;//多少列

@property (nonatomic, assign) CGFloat rowSpacing;//行间距

@property (nonatomic, assign) CGFloat columnSpacing;//列间距

@property (nonatomic, assign) UIEdgeInsets sectionInset;//所有item组成的整体与屏幕的间距

@property (nonatomic, assign) CGFloat itemWidth;

@end
