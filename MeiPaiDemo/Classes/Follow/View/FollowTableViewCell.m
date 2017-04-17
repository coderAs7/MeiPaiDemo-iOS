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
    self.nameLabel.text = array[index.row][@"title"];
    self.messageLabel.text = @"04-12 19:28";
    [self.giftButton setBackgroundImage:[UIImage imageNamed:@"bg_directMessage_alertview"] forState:UIControlStateNormal];
    self.backImage.contentMode = UIViewContentModeScaleToFill;
    [self.backImage sd_setImageWithURL:array[index.row][@"bpic"] placeholderImage:[UIImage imageNamed:@""]];
    
    
    
    CGFloat wid = (SCREEN_WIDTH/4 - FN(15));
    [self.loveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(wid);
        make.top.equalTo(self.backImage.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(FN(30), FN(30)));
    }];
    
    
    [self.separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loveButton.mas_right).offset(FN(20));
        make.top.equalTo(self.loveButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(5, FN(30)));
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(wid * 2);
        make.top.equalTo(self.backImage.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(FN(30), FN(30)));
    }];
    
    [self.separateNextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageButton.mas_right).offset(FN(20));
        make.top.equalTo(self.messageButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(5, FN(30)));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(wid * 3);
        make.top.equalTo(self.backImage.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(FN(30), FN(30)));
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
