//
//  WantTableViewCell.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "WantTableViewCell.h"

@interface WantTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sexImage;

@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end

@implementation WantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImage.layer.masksToBounds = YES;
//    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(10);
//        make.top.equalTo(self).offset(10);
//        make.size.mas_equalTo(CGSizeMake(FN(50), FN(50)));
//    }];
    self.headImage.layer.cornerRadius = FN(25);
}

- (void)dataSource:(NSArray *)dataArray With:(NSIndexPath *)index {
    self.headImage.image = [UIImage imageNamed:dataArray[0][index.row]];
    self.nameLabel.text = dataArray[1][index.row];
    self.messageLabel.text = dataArray[2][index.row];
    self.sexImage.image = [UIImage imageNamed:@"icon_woman_mini"];
    [self.followButton setBackgroundImage:[UIImage imageNamed:@"followImage"] forState:UIControlStateNormal];
    
    
}


@end
