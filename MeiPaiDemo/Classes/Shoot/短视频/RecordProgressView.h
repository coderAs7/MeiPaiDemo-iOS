

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RecordProgressView : UIView

//@property (assign, nonatomic) IBInspectable CGFloat progress;//当前进度
//@property (strong, nonatomic) IBInspectable UIColor *progressBgColor;//进度条背景颜色
//@property (strong, nonatomic) IBInspectable UIColor *progressColor;//进度条颜色
//@property (assign, nonatomic) CGFloat loadProgress;//加载好的进度
//@property (strong, nonatomic) UIColor *loadProgressColor;//已经加载好的进度颜色
//

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
