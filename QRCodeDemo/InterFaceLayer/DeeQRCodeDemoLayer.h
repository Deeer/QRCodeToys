//
//  DeeQRCodeDemoLayer.h
//  CoreGraphicsDemo
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 apple. All rights reserved.
// 扫描框视图

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface DeeQRCodeDemoLayer : CALayer

- (instancetype)initWithFrame:(CGRect)frame ClearRect:(CGRect)rect;

/**
 获取当前扫描框大小
 */
- (CGRect)getScannerRect;;

/**
 设置扫描框大小
 */
- (void)setScannerRect:(CGRect)rect;

/**
 设置扫描框四角颜色
 */
- (void)setCornerColor:(UIColor *)color;


/**
 设置扫描框四角的长度,默认是20
 */
- (void)setCorenerLength:(CGFloat)length;

//上下扫描线
- (void)startAnimationWithScanLine:(UIImage *)image;

@end
