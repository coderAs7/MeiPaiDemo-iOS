//
//  MPChannelsTableViewCell.h
//  MeiPaiDemo
//
//  Created by dongxiaowei on 2017/4/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPChannelsTableViewCell : UITableViewCell

-(void)insertCellWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image;

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * subTitleLabel;

@end
