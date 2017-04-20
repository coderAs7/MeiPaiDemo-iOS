//
//  MPChannelsHeaderTableViewCell.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPTopChannelsCollectionViewCell.h"

@protocol MPChannelsHeaderTableViewCellDelegate <NSObject>

-(void)channelsHeaderTableViewCellDidSelected:(MPTopChannelsCollectionViewCell *)sender;
-(void)channelsHeaderTopbuttonDidClicked:(UIButton *)sender;


@end

@interface MPChannelsHeaderTableViewCell : UITableViewCell

@property(nonatomic,weak)id <MPChannelsHeaderTableViewCellDelegate> delegate;

@end
