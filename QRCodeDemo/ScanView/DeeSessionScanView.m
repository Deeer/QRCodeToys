//
//  DeeSessionScanView.m
//  QRCodeDemo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "DeeSessionScanView.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#define ScanY 150           //扫描区域y
#define ScanWidth 250       //扫描区域宽度
#define ScanHeight 250      //扫描区域高度

/* 屏幕宽 */
#define K_SCANNER_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
/* 屏幕高 */
#define K_SCANNER_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//    self.output setRectOfInterest:
#define  k_CurrentHeight self.frame.size.height
#define  k_CurrnetWidth  self.frame.size.width

#define ScanRectMake(x,y,w,h)    CGRectMake(y / k_CurrentHeight, x / k_CurrnetWidth , K_SCANNER_SCREEN_HEIGHT \
/k_CurrentHeight,K_SCANNER_SCREEN_WIDTH / k_CurrentHeight) \

#define lxy(x, y, w, h)              CGRectMake(x, y, w, h)

@interface DeeSessionScanView()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>
//一个session 可以有多个input 和 output
@property(strong, nonatomic) AVCaptureSession *session;

@property(copy, nonatomic) scannerResultCallback myBlock;

@property(strong, nonatomic) AVCaptureMetadataOutput *output;

@end

@implementation DeeSessionScanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configScanner];
    }
    return self;
}


#pragma mark - interfaceMethod

- (void)AutoDectecBrightness:(BOOL)isDective {
    if (isDective) {
        [self configBrightnessDetect];
    }
}

- (void)setScanArea:(CGRect)rect {
    // inset的坐标是 左上角，所有要做个转换
    [self.output setRectOfInterest:ScanRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
}

- (CGRect)getScanRect {
    return self.output.rectOfInterest;
}

- (void)startScannerWithResult:(scannerResultCallback)resultblock {
    if ([self.session isRunning]) {
        return;
    }
    [self.session startRunning];
    self.myBlock = resultblock;
}

- (void)stopScanner {
    if ([self.session isRunning]) {
        [self.session stopRunning];
    }
}

#pragma mark - privateMehod

- (void)configScanner {
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    NSAssert(!error, error.description);
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    self.output = output;
    
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    dispatch_queue_t quene = dispatch_queue_create("BrightDectiveQuene", nil);
    [output setMetadataObjectsDelegate:self queue:quene];
    
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    
    
    [output setMetadataObjectTypes:[output availableMetadataObjectTypes]];
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = self.frame;
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    [self.layer addSublayer:previewLayer];
    
}

- (void)configBrightnessDetect {
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    
    NSAssert(!error, error.description);
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    dispatch_queue_t quene = dispatch_queue_create("lightDectiveQuene", nil);
    dispatch_async(quene, ^{
        [output setSampleBufferDelegate:self queue:quene];
        if ([self.session canAddInput:input]) {
            [self.session addInput:input];
        }
        if ([self.session canAddOutput:output]) {
            [self.session addOutput:output];
        }
        [self.session startRunning];
    });
}

- (void)setTorchOn:(BOOL)on openSuccess:(void(^)(BOOL success))callback {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    BOOL isSuccess = NO;
    if ([device hasTorch] && [device hasFlash]) {
        [device lockForConfiguration:&error];
        NSAssert(!error, error.description);
        if (on) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
        isSuccess = YES;
    }
    if (callback) {
        callback(isSuccess);
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([metadataObjects count]>0 ) {
        AVMetadataObject * metadataObject = [metadataObjects firstObject];
        if (metadataObject.type == AVMetadataObjectTypeQRCode) { //TODO:可以开放其他扫描功能
            [self.session stopRunning];
            NSString *strValue = [(AVMetadataMachineReadableCodeObject *)metadataObject stringValue];
            if (self.myBlock) {
                self.myBlock(strValue);
            }
        }
    }
}


- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary * _Nonnull)(metadataDict)];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    if (brightnessValue <= -2) {
        //检测光源 - 开启闪光灯
        [self setTorchOn:YES openSuccess:nil];
    }
    
}

#pragma mark - setterAndGetter

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}



@end
