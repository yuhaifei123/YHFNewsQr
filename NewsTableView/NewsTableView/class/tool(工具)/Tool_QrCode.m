//
//  Tool_QrCode.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/26.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Tool_QrCode.h"

@interface Tool_QrCode ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong) AVCaptureSession *aVCaptureSession;//会话
@property (nonatomic,strong) AVCaptureDeviceInput *aVCaptureDeviceInput;//输入对象
@property (nonatomic,strong) AVCaptureMetadataOutput *aVCaptureMetadataOutput;//输出对象
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *aVCaptureVideoPreviewLayer;//输出对象
@property (nonatomic,strong) CALayer *drawLayer; // 创建用于绘制边线的图层

@end

@implementation Tool_QrCode

#pragma  mark -- 懒加载
- (AVCaptureSession *)aVCaptureSession{

    if (_aVCaptureSession == nil) {

        _aVCaptureSession = [[AVCaptureSession alloc] init];
    }

    return _aVCaptureSession;
}

//拿到输入设备
-(AVCaptureDeviceInput *)aVCaptureDeviceInput{

    if (_aVCaptureDeviceInput == nil) {
        NSError *error;
        //拿摄像头
        AVCaptureDevice *aVCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

        _aVCaptureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:aVCaptureDevice error:&error];
    }

    return _aVCaptureDeviceInput;
}

-(AVCaptureMetadataOutput *)aVCaptureMetadataOutput{

    if (_aVCaptureMetadataOutput == nil) {

        _aVCaptureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    }

    return _aVCaptureMetadataOutput;
}

-(AVCaptureVideoPreviewLayer *)aVCaptureVideoPreviewLayer{

    if (_aVCaptureVideoPreviewLayer == nil) {

        _aVCaptureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.aVCaptureSession];
        _aVCaptureVideoPreviewLayer.frame = DEF_SCREEN_FRAME;
    }

    return _aVCaptureVideoPreviewLayer;
}

-(CALayer *) drawLayer{

    if (_drawLayer == nil) {
        _drawLayer = [[CALayer alloc] init];
        _drawLayer.frame = DEF_SCREEN_FRAME;
    }

    return _drawLayer;
}



#pragma  mark --  扫描二维码
-(void) tool_StartScan_Controller:(UIViewController *)controller{

    // 1.判断是否能够将输入添加到会话中
    if ([self.aVCaptureSession canAddInput:self.aVCaptureDeviceInput]) {

        [self.aVCaptureSession addInput: self.aVCaptureDeviceInput];
    }

    // 2.判断是否能够将输出添加到会话中
    if ([self.aVCaptureSession canAddOutput:self.aVCaptureMetadataOutput]) {

        [self.aVCaptureSession addOutput: self.aVCaptureMetadataOutput];
    }

    // 3.将输入和输出都添加到会话中
    //  [self.aVCaptureSession addInput: self.aVCaptureDeviceInput];
    NSLog(@"%@",self.aVCaptureMetadataOutput.availableMetadataObjectTypes);
    //[self.aVCaptureSession addOutput: self.aVCaptureMetadataOutput];
    NSLog(@"%@",self.aVCaptureMetadataOutput.availableMetadataObjectTypes);

    // 4.设置输出能够解析的数据类型
    // 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
    self.aVCaptureMetadataOutput.metadataObjectTypes = self.aVCaptureMetadataOutput.availableMetadataObjectTypes;
    NSLog(@"%@",self.aVCaptureMetadataOutput.availableMetadataObjectTypes);

    // 5.设置输出对象的代理, 只要解析成功就会通知代理
    [self.aVCaptureMetadataOutput setMetadataObjectsDelegate:controller queue:dispatch_get_main_queue() ];

    // 添加预览图层
    [controller.view.layer insertSublayer:self.aVCaptureVideoPreviewLayer atIndex:0];

    // 添加绘制图层到预览图层上
    [self.aVCaptureVideoPreviewLayer addSublayer:self.drawLayer];
    
    [self.aVCaptureSession startRunning];
}

/**
 绘制图形

 :param: codeObject 保存了坐标的对象
 */
-(void)drawCorners_CodeObject: (NSArray *)metadataObjects{

    //获取扫描到的二维码的位置
    for (NSObject *object in metadataObjects){

        if ([object isKindOfClass: [AVMetadataMachineReadableCodeObject class]]) {
            // 将坐标转换界面可识别的坐标
            AVMetadataMachineReadableCodeObject  *codeObject = (AVMetadataMachineReadableCodeObject *)[self.aVCaptureVideoPreviewLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)object];
            // 2.1.3绘制图形
            if (codeObject.corners == nil || codeObject.corners.count == 0) {

                return;
            }

            //创建一个图层
            CAShapeLayer *layer = [[CAShapeLayer alloc]init];
            layer.lineWidth = 4;
            layer.strokeColor =[UIColor redColor].CGColor;
            layer.fillColor = [UIColor clearColor].CGColor;

            //创建路径
            UIBezierPath *path = [[UIBezierPath alloc] init];
            CGPoint point = CGPointZero;
            int index = 0;

            //移动到第一个点
            //从corners数组中取出第0个元素, 将这个字典中的x/y赋值给point
            CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)codeObject.corners[index++], &point);
            [path moveToPoint:point];

            //移动到其它的点
            while (index < codeObject.corners.count) {

                CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)codeObject.corners[index++], &point);
                [path addLineToPoint:point];
            }
            //关闭路径
            [path closePath];
            //绘制路径
            layer.path = path.CGPath;
            //将绘制好的图层添加到drawLayer上
            [self.drawLayer addSublayer:layer];
        }
    }
}

/**
 清空边线
 */
-(void) clearConers{

    if (self.drawLayer.sublayers == nil || self.drawLayer.sublayers.count == 0) {
        return;
    }

    for (int i = 0; i <= self.drawLayer.sublayers.count; i++) {
        CALayer *layer = self.drawLayer.sublayers[i];
        [layer removeFromSuperlayer];
    }
}


@end
