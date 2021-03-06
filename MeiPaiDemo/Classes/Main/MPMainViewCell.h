//
//  MPMainViewCell.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPMainViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UIImageView *userIcon;

@property (nonatomic, strong) UILabel *prompt;
@property (nonatomic, strong) UILabel *number;
@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *live;

@property (nonatomic, strong) UILabel *watch;

@end
