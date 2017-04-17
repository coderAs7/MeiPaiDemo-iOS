//
//  FollowTableViewCell.h
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (nonatomic,strong)UIImageView *playImage;//播放与暂停图

- (void)dataSourceArray:(NSArray *)array withIndex:(NSIndexPath *)index;

- (void)computeCellHeight;

- (void)changeHidden;
@end
