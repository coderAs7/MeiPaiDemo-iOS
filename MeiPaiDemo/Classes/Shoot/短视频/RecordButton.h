//
//  RecordButton.h
//  MeiPaiDemo
//
//  Created by 李明 on 2017/4/19.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LeafButtonTypeCamera,
    LeafButtonTypeVideo,
}LeafButtonType;

typedef enum {
    LeafButtonStateNormal,
    LeafButtonStateSelected
}LeafButtonState;

@class RecordButton;

typedef  void(^ClickedBlock)(RecordButton *button);

@interface RecordButton : UIView

@property (nonatomic,assign) LeafButtonType type;

@property (nonatomic,assign) LeafButtonState state;

@property (nonatomic,strong) void (^clickedBlock)(RecordButton *button);

@end
