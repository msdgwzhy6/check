//
//  CheckboxControl.m
//  Check
//
//  Created by wuxueying on 8/13/15.
//  Copyright (c) 2015 xueying wu. All rights reserved.
//

#import "CheckboxControl.h"

@implementation CheckboxControl {
    NSInteger lineWidth;
    UIColor *lineColor;
}

- (void)awakeFromNib {
    lineWidth = 5.0;
    lineColor = [UIColor colorWithRed:0.078 green:0.196 blue:0.314 alpha:1.000];
}

- (void)show {
    _lineLayer = [self checkmarkLayerWithColor];
    [self.layer addSublayer:_lineLayer];
    _lineLayer.strokeStart = 0;
    _lineLayer.strokeEnd = 0;
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        _lineLayer.strokeStart = 0;
        _lineLayer.strokeEnd = 1;
    }];
    [CATransaction commit];
}

- (void)hide {
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        _lineLayer.strokeStart = 1;
        _lineLayer.strokeEnd = 1;
    }];
    [CATransaction commit];
}

- (CAShapeLayer *)checkmarkLayerWithColor {
    CAShapeLayer *ret = [CAShapeLayer new];
    ret.strokeColor = lineColor.CGColor;
    ret.fillColor = [UIColor clearColor].CGColor;
    ret.lineCap = kCALineCapRound;
    ret.lineJoin = kCALineJoinRound;
    ret.lineWidth = 4;
    ret.path = [self checkmarkPath].CGPath;
    return ret;
}

- (UIBezierPath *)checkmarkPath {
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:[self startPoint]];
    [path addLineToPoint:[self middlePoint]];
    [path addLineToPoint:[self endPoint]];
    return path;
}

- (CGPoint)startPoint {
    CGFloat angle = 13 * M_PI /12;
    return CGPointMake([self bounsCenter].x + [self innerRadius] * cos(angle), [self bounsCenter].y + [self innerRadius] * sin(angle));
}

- (CGPoint)middlePoint {
    return CGPointMake([self bounsCenter].x - [self innerRadius] * 0.25, [self bounsCenter].y + [self innerRadius] * 0.8);
}

- (CGPoint)endPoint {
    CGFloat angle = 7 * M_PI /4;
    return CGPointMake([self bounsCenter].x + [self outerRadius] * cos(angle), [self bounsCenter].y + [self outerRadius] * sin(angle));
}

- (CGPoint)bounsCenter {
    return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

- (CGRect)insetRect {
    CGRect ret = self.bounds;
    CGRectInset(ret, 2 * lineWidth, 2 * lineWidth);
    return ret;
}

- (CGFloat)innerRadius {
    return MIN([self insetRect].size.width, [self insetRect].size.height) / 2;
}

- (CGFloat)outerRadius {
    return sqrt(pow([self insetRect].size.width, 2) + pow([self insetRect].size.height, 2)) / 2;
}

@end
