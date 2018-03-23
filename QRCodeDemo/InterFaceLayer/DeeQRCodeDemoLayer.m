//
//  DeeQRCodeDemoLayer.m
//  CoreGraphicsDemo
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DeeQRCodeDemoLayer.h"

#define CORNER_LENGTH 20
@interface DeeQRCodeDemoLayer()

//透明处的rect
@property(assign, nonatomic) CGRect clearRect;

@property(assign, nonatomic) CGFloat cornerLength;

@property(strong, nonatomic) UIColor *cornerColor;
//扫描线
@property(strong, nonatomic) CALayer *scanline;

@end

@implementation DeeQRCodeDemoLayer

- (instancetype)initWithFrame:(CGRect)frame ClearRect:(CGRect)rect {
    if (self = [super init]) {
        self.frame = frame;
        self.clearRect = rect;
    }
    return self;
}



- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    //绘制背景色
    [self drawBackgroundWithContext:ctx];
    //绘制扫描边框
    [self drawBorderColorWithCtx:ctx];
    //绘制四个角
    
}

#pragma mark - interfaceMethod

- (void)setCorenerLength:(CGFloat)length {
    self.cornerLength = length;
    [self setNeedsDisplay];
}

- (void)setCornerColor:(UIColor *)color {
    self.cornerColor = color;
    [self setNeedsDisplay];
}


- (CGRect)getScannerRect {
    return self.clearRect;
}

- (void)setScannerRect:(CGRect)rect {
    self.clearRect = rect;
    [self setNeedsDisplay];
}

- (void)startAnimationWithScanLine:(UIImage *)image {
    
    CGFloat x = self.clearRect.origin.x;
    CGFloat y = self.clearRect.origin.y;
    CGFloat w = self.clearRect.size.width;
    CGFloat h = self.clearRect.size.height;
    
    if (!self.scanline) {
        self.scanline = [CALayer layer];
        self.scanline.contents = CFBridgingRelease(image.CGImage);
        self.scanline.frame = CGRectMake(x,y,w,10);
        [self addSublayer:self.scanline];
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 2.0;
    animation.repeatCount = HUGE_VAL;
    animation.autoreverses = YES;
    [animation setRemovedOnCompletion:NO];
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //尝试让line上下移动，不知道为什么x 要加h/2
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(x+h/2, y+h, 0, 0)];
    [self.scanline addAnimation:animation forKey:nil];
}

#pragma mark - privateMethod

- (void)drawBackgroundWithContext:(CGContextRef)ctx {
    //常见rgb彩色空间引用
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    //创建颜色 - 参数 ： 色彩空间 && 颜色组件 - RGBA
    CGFloat rbgComponents[] = {0.1,0.1,0.1,0.3};
    //创建颜色
    CGColorRef color = CGColorCreate(rgbColorSpace, rbgComponents);
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, color);
    //执行填充
    CGContextFillRect(ctx, self.frame);
    NSAssert(!CGRectEqualToRect(self.clearRect, CGRectZero), @"扫描窗口为空");
    NSAssert(!CGRectEqualToRect(self.clearRect, CGRectNull), @"扫描窗口未设置");
    //清空内容
    CGContextClearRect(ctx, self.clearRect);
}

- (void)drawBorderColorWithCtx:(CGContextRef)ctx {
    CGFloat x = self.clearRect.origin.x;
    CGFloat y = self.clearRect.origin.y;
    CGFloat w = self.clearRect.size.width;
    CGFloat h = self.clearRect.size.height;
    CGFloat l = self.cornerLength>0?:CORNER_LENGTH;
    
    CGContextBeginPath(ctx);
    //⌜
    CGContextMoveToPoint(ctx, x, y+l);
    CGContextAddLineToPoint(ctx, x, y);
    CGContextAddLineToPoint(ctx, x+l, y);
    
    //⌝
    CGContextMoveToPoint(ctx, x+w-l, y);
    CGContextAddLineToPoint(ctx, x+w, y);
    CGContextAddLineToPoint(ctx, x+w, y+l);
    
    //⌟
    CGContextMoveToPoint(ctx, x+w, y+h-l);
    CGContextAddLineToPoint(ctx, x+w, y+h);
    CGContextAddLineToPoint(ctx, x+w-l, y+h);
    
    //⌞
    CGContextMoveToPoint(ctx, x+l, y+h);
    CGContextAddLineToPoint(ctx, x, y+h);
    CGContextAddLineToPoint(ctx, x, y+h-l);
    
    CGContextSetStrokeColorWithColor(ctx, self.cornerColor.CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end
