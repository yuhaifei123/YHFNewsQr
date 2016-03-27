//
//  QrCode_ViewController.h
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/26.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

@protocol QrCode_ViewControllerDelegate <NSObject>

-(void) QrCodeViewController_Data:(NSString *)data;

@end

@interface QrCode_ViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,weak) id<QrCode_ViewControllerDelegate> delgate;

-(void)add_Type;
@end
