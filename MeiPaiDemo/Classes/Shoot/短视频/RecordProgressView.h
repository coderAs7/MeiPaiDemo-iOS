

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RecordProgressView : UIView

/**
 *  进度值  maxValue:  <= ProgressView.width
 0.8
 */

@property (nonatomic) CGFloat progressValue;

/**
 *   动态进度条颜色  Dynamic progress
 */
@property (nonatomic, strong) UIColor *trackTintColor;
/**
 *  静态背景颜色    static progress
 */
@property (nonatomic, strong) UIColor *progressTintColor;

@end
