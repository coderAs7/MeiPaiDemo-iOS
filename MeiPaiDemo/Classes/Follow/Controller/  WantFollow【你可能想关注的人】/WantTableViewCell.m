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

//@property (weak, nonatomic) IBOutlet UIButton *followButton;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation WantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = FN(25);
}

- (void)dataSource:(NSArray *)dataArray With:(NSIndexPath *)index {
    self.headImage.image = [UIImage imageNamed:dataArray[0][index.row]];
    self.nameLabel.text = dataArray[1][index.row];
    self.messageLabel.text = dataArray[2][index.row];
    self.sexImage.image = [UIImage imageNamed:@"icon_woman_mini"];
    [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
//    if (!self.dataArray) {
//        self.dataArray = [NSMutableArray array];
//    }
    
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
