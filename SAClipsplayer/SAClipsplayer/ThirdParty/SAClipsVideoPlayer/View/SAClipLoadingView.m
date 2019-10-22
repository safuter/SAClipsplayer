//
//  SAClipLoadingView.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/20.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAClipLoadingView.h"

@interface SAClipLoadingView()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) BOOL isAnimating;
@end

@implementation SAClipLoadingView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
        self.hidden = YES;
    }
    return self;
}

- (void)initialize {
    [self.layer addSublayer:self.shapeLayer];
    self.duration = 1;
    self.lineWidth = 1;
    self.lineColor = [UIColor whiteColor];
    self.userInteractionEnabled = NO;
}

- (void)startActivity {
    if (self.isAnimating) {
        return;
    }
    self.hidden = NO;
    self.isAnimating = YES;
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnim.toValue = [NSNumber numberWithFloat:2 * M_PI];
    rotationAnim.duration = self.duration;
    rotationAnim.repeatCount = CGFLOAT_MAX;
    rotationAnim.removedOnCompletion = NO;
    [self.shapeLayer addAnimation:rotationAnim forKey:@"rotation"];
    if (self.hidesWhenStopped) {
        self.hidden = NO;
    }
}

- (void)stopActivity {
    if (!self.isAnimating) return;
    self.hidden = YES;
    self.isAnimating = NO;
    [self.shapeLayer removeAllAnimations];
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = MIN(self.bounds.size.width, self.bounds.size.height);
    CGFloat height = width;
    self.shapeLayer.frame = CGRectMake(0, 0, width, height);
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.shapeLayer.lineWidth / 2;
    CGFloat startAngle = (CGFloat)(0);
    CGFloat endAngle = (CGFloat)(2*M_PI);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.shapeLayer.path = path.CGPath;
}

#pragma mark - Getter
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = self.lineColor.CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeStart = 0.1;
        _shapeLayer.strokeEnd = 1;
        _shapeLayer.lineCap = @"round";
        _shapeLayer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return _shapeLayer;
}

#pragma mark - Setter
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.shapeLayer.lineWidth = lineWidth;
}

- (void)setLineColor:(UIColor *)lineColor {
    if (!lineColor) return;
    _lineColor = lineColor;
    self.shapeLayer.strokeColor = lineColor.CGColor;
}
@end
