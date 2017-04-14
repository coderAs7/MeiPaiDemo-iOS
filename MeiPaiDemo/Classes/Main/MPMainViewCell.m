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
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-50);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    
}

@end
