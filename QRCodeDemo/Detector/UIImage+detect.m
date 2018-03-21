//
//  UIImage+detect.m
//  QRCodeDemo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 Dee. All rights reserved.
//  QRCode Detect

#import "UIImage+detect.h"
#import <CoreImage/CoreImage.h>
@implementation UIImage (detect)

+ (void)detectQRCodeWithCIImage:(CIImage *)ciimage withCallBack:(void(^)(NSArray *infos))callback {
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
   NSArray *features = [detector featuresInImage:ciimage options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    NSMutableArray *infoArray = [NSMutableArray array];
    
    for (CIQRCodeFeature *result in features) {
        [infoArray addObject:result.messageString];
    }
    if (callback) {
        callback(infoArray);
    }
}

+ (void)detectQRCodeWithImage:(UIImage *)image withCallBack:(void (^)(NSArray *infos))callback {
    [self detectQRCodeWithCIImage:[[CIImage alloc] initWithImage:image] withCallBack:callback];
}

@end
