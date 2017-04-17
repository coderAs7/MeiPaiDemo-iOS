//
//  [cell creatCollectionView:_layout forInteger:indexPath.item]; MPMainLiveCollectionView.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LiveCollectionViewDelegate <NSObject>

- (void)liveCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath inIdentifier:(NSInteger)integer;


@end

@interface MPMainLiveCollectionView : UIView
@property (nonatomic, weak) id <LiveCollectionViewDelegate> delegate;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
