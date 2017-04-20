//
//  MPUserCenterHeaderTableViewCell.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPTopNameButtonView.h"

@class MPUserCenterHeaderTableViewCell;

@protocol MPUserCenterHeaderTableViewCellDelegate <NSObject>

-(void)topNameButtonClicked:(MPTopNameButtonView *)sender;

@end


@interface MPUserCenterHeaderTableViewCell : UITableViewCell

@property(nonatomic,weak)id <MPUserCenterHeaderTableViewCellDelegate> delegate;

@end
