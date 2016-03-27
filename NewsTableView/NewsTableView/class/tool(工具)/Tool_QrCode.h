//
//  Tool_QrCode.h
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/26.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

@interface Tool_QrCode : NSObject<AVCaptureMetadataOutputObjectsDelegate>

/**
 *  扫描二维码
 */
-(void) tool_StartScan_Controller:(UIViewController *)controller;
/**
 清空边线
 */
-(void) clearConers;

/**
 绘制图形
 */
-(void)drawCorners_CodeObject: (NSArray *)metadataObjects;
@end
