//
//  WantTableViewCell.h
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WantTableViewCell : UITableViewCell

- (void)dataSource:(NSArray *)dataArray With:(NSIndexPath *)index;

@end
