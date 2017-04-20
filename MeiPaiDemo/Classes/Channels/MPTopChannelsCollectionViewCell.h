//
//  MPTopChannelsCollectionViewCell.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPTopChannelsCollectionViewCell : UICollectionViewCell

-(void)insertCellWithTitle:(NSString *)title image:(UIImage *)image;

@property(nonatomic,strong)NSString * title;

@end
