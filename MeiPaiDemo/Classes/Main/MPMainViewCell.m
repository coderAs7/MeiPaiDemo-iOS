//
//  MPMainViewCell.m
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "MPMainViewCell.h"
#import "PrefixHeader.pch"

@implementation MPMainViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
        _img.contentMode = UIViewContentModeScaleAspectFill;
        _img.image = [UIImage imageNamed:@"fli311"];
        self.clipsToBounds = YES;
        
        _userIcon = [[UIImageView alloc] init];
        _userIcon.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_userIcon];
        _userIcon.layer.cornerRadius = 16;
        _userIcon.clipsToBounds = YES;
        
        _name = [[UILabel alloc] init];
        _name.text = @"哈哈哈哈哈";
        _name.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_name];
        
        _prompt = [[UILabel alloc] init];
        _prompt.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_prompt];
        _prompt.text = @"哈哈😄阿境内发生东方的方式";

        _number = [[UILabel alloc] init];
        _number.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_number];
        _number.text = @"5785";



    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-44);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_img.mas_left).offset(6);
        make.width.height.mas_equalTo(32);
        make.top.mas_equalTo(_img.mas_bottom).offset(-18);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userIcon.mas_right).offset(6);
        make.top.mas_equalTo(_img.mas_bottom).offset(6);
    }];
    
    [_prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userIcon.mas_left);
        make.top.mas_equalTo(_userIcon.mas_bottom).offset(6);
    }];

    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_img.mas_right).offset(-6);
        make.top.mas_equalTo(_img.mas_bottom).offset(6);
    }];
    
}

@end
