//
//  MPMainPopularCollectionView.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopularCollectionViewDelegate <NSObject>

- (void)popularCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath inIdentifier:(NSInteger)integer;
@end

@interface MPMainPopularCollectionView : UIView
@property (nonatomic, weak) id <PopularCollectionViewDelegate> delegate;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
