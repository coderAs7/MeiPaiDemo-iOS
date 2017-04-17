//
//  MPMainCityCollectionView.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityCollectionViewDelegate <NSObject>

- (void)cityCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath inIdentifier:(NSInteger)integer;

@end

@interface MPMainCityCollectionView : UIView
@property (nonatomic, weak) id <CityCollectionViewDelegate> delegate;
@end
