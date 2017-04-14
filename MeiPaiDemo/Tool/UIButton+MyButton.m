//
//  UIButton+MyButton.m
//  仿写战旗TV
//
//  Created by liuhu on 2017/4/5.
//  Copyright © 2017年 liuhu. All rights reserved.
//

#import "UIButton+MyButton.h"

#import <objc/runtime.h>

static const char btnKey;

@implementation UIButton (MyButton)

- (void)backMethod:(block)block {
    
    if (block) {
        objc_setAssociatedObject(self, &btnKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    [self addTarget:self action:@selector(action_but) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)action_but {
    block blok = objc_getAssociatedObject(self, &btnKey);
    blok();
}



@end
