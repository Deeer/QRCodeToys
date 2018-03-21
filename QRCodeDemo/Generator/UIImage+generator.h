//
//  UIImage+generator.h
//  QRCodeDemo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (generator)

/**
 生成制定尺寸的高清图
 */
+ (UIImage *)generatorImageWithCIImage:(CIImage *)image withSpecificSize:(CGFloat)size;

@end
