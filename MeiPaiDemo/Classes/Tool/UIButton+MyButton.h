//
//  UIButton+MyButton.h
//  仿写战旗TV
//
//  Created by liuhu on 2017/4/5.
//  Copyright © 2017年 liuhu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)();

@interface UIButton (MyButton)

- (void)backMethod:(block)block;

@end
