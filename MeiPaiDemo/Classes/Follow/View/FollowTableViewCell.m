//
//  FollowTableViewCell.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "FollowTableViewCell.h"

@interface FollowTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIButton *giftButton;

@property (weak, nonatomic) IBOutlet UIButton *loveButton;

@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@end

@implementation FollowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)dataSourceArray:(NSArray *)array withIndex:(NSIndexPath *)index {
    self.headImage.image = [UIImage imageNamed:@"wantHeadImage"];
    self.nameLabel.text = @"ps姐姐秀";
    self.messageLabel.text = @"04-12 19:28";
    [self.giftButton setBackgroundImage:[UIImage imageNamed:@"wantHeadImage"] forState:UIControlStateNormal];
    
}


@end
