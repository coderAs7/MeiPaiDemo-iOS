//
//  WBStatusComposeEmoticonView.h
//  YYKitExample
//
//  Created by ibireme on 15/9/6.
//  Copyright (C) 2015 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WBModel.h"

@protocol WBStatusComposeEmoticonViewDelegate <NSObject>
@optional
- (void)emoticonInputDidTapText:(NSString *)text;
- (void)emoticonInputDidTapBackspace;
- (void)emoticonInputDidTapSendButton;
@end

/// 表情输入键盘
@interface WBEmoticonInputView : UIView
@property (nonatomic, weak) id<WBStatusComposeEmoticonViewDelegate> delegate;
+ (instancetype)sharedView;

- (void)hiddenSendButton:(BOOL)hidden;
@end
