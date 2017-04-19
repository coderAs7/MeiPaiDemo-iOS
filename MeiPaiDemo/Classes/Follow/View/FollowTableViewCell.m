//
//  FollowTableViewCell.m
//  MeiPaiDemo
//
//  Created by liuhu on 2017/4/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "FollowTableViewCell.h"

@interface FollowTableViewCell ()


@property (weak, nonatomic) IBOutlet UIView *separateView;

@property (weak, nonatomic) IBOutlet UIView *separateNextView;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIButton *giftButton;

@property (weak, nonatomic) IBOutlet UIButton *loveButton;

@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@end

@implementation FollowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.hidden = YES;
    self.backView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.playImage];
    
    [self.playImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (UIImageView *)playImage {
    if (!_playImage) {
        _playImage = [[UIImageView alloc]init];
        _playImage.image = [UIImage imageNamed:@"btn_play_bg_b"];
    }
    return _playImage;
}

- (void)dataSourceArray:(NSArray *)array withIndex:(NSIndexPath *)index {
    self.headImage.image = [UIImage imageNamed:@"Effects10"];
    self.nameLabel.text = array[index.row][@"nickname"];
    self.messageLabel.text = @"04-17 09:55";
    self.describeLabel.text = array[index.row][@"title"];
    [self.giftButton setBackgroundImage:[UIImage imageNamed:@"bg_directMessage_alertview"] forState:UIControlStateNormal];
    self.backImage.contentMode = UIViewContentModeScaleToFill;
    [self.backImage sd_setImageWithURL:array[index.row][@"bpic"] placeholderImage:[UIImage imageNamed:@""]];
    
//    [self.loveButton setImage:[UIImage imageNamed:@"icon_cell_likesmall_a"] forState:UIControlStateNormal];
    [self.loveButton setBackgroundImage:[UIImage imageNamed:@"icon_cell_likesmall_a"] forState:UIControlStateNormal];
    [self.messageButton setBackgroundImage:[UIImage imageNamed:@"icon_cell_nomusic"] forState:UIControlStateNormal];
    [self.shareButton setBackgroundImage:[UIImage imageNamed:@"icon_cell_share_a"] forState:UIControlStateNormal];
    
    
    CGFloat wid = (SCREEN_WIDTH/3.2 - FN(15));
    [self.loveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(wid);
        make.top.equalTo(self.describeLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(FN(20), FN(20)));
    }];
    
    
    [self.separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loveButton.mas_right).offset(FN(40));
        make.top.equalTo(self.loveButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(1, FN(20)));
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(wid * 2);
        make.top.equalTo(self.describeLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(FN(20), FN(20)));
    }];
    
    [self.separateNextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageButton.mas_right).offset(FN(40));
        make.top.equalTo(self.messageButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(1, FN(20)));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(wid * 3);
        make.top.equalTo(self.describeLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(FN(20), FN(20)));
    }];
    
}

- (void)changeHidden {
    self.backView.hidden = NO;
}




- (void)computeCellHeight {
    [self layoutIfNeeded];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(self.shareButton.frame));
//    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, MAXFLOAT);
//    CGSize size = [self sizeWithFont:[UIFont systemFontOfSize:13] maxSize:maxSize withString:string];
//    NSLog(@"\\\\\\ %f\n",size.height);
//    
//    //    NSLog(@"%f",_textButton.frame.size.height);
//    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, size.height + 20);
//    self.textButton.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , size.height + 20);
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
