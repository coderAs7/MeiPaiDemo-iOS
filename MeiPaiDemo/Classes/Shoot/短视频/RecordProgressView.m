

#import "RecordProgressView.h"

@interface RecordProgressView ()

/**
 *  进度条 progressView
 */
@property (nonatomic, strong) CALayer *progressView;

/**
 *  progressView Rect
 */
@property (nonatomic) CGRect rect_progressView;

@end

@implementation RecordProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        _progressView = [[CALayer alloc] init];
        _progressView.backgroundColor = [UIColor purpleColor].CGColor;
        [self.layer addSublayer:_progressView];
        
        self.rect_progressView = CGRectMake(0, 0, 0, frame.size.height);
        self.progressView.frame = self.rect_progressView;
    }
    return self;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    
    self.backgroundColor = _progressTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor = trackTintColor;
    
    self.progressView.backgroundColor = _trackTintColor.CGColor;
}

- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    _rect_progressView.size.width = _progressValue * self.bounds.size.width;
    CGFloat maxValue = self.bounds.size.width;
    double durationValue = (_progressValue/2.0) / maxValue + .5;
    [UIView animateWithDuration:durationValue animations:^{
        self.progressView.frame = _rect_progressView;
    }];
}


@end
