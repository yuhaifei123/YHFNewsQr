//
//  QrCode_ViewController.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/26.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "QrCode_ViewController.h"
#import "Tool_QrCode.h"
#import "Show_ViewController.h"

@interface QrCode_ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanLineCons;//冲击波的高度
@property (weak, nonatomic) IBOutlet UIImageView *imageView_ScanLineView;//冲击波的视图
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_BackgroundView;//背景view的高度
@property (weak, nonatomic) IBOutlet UIView *view_Background;

@property (nonatomic,strong) Tool_QrCode *tool_QrCode;
@property (nonatomic,assign) int judege_NO;//判断delegated次数

@end

@implementation QrCode_ViewController

-(Tool_QrCode *) tool_QrCode{

    if (_tool_QrCode == nil) {

        _tool_QrCode = [[Tool_QrCode alloc] init];
    }

    return _tool_QrCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = NO;
}

-(void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    [self add_ViewAnimation];
    [self.tool_QrCode tool_StartScan_Controller:self];

    _judege_NO = 1;
}

#pragma  mark -- 视图动画
-(void) add_ViewAnimation{

    [UIView animateWithDuration:2.0 animations:^{
        //要执行的动画
        // 1.修改约束
        self.scanLineCons.constant = self.view_BackgroundView.constant;
        // 设置动画指定的次数
        [UIView setAnimationRepeatCount:MAXFLOAT];
        // 2.强制更新界面
        [self.imageView_ScanLineView layoutIfNeeded];
    } completion:nil];
}


#pragma  AVCaptureMetadataOutputObjectsDelegate 

-(void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{

    self.judege_NO = self.judege_NO +1;

    // 清空图层
    [self.tool_QrCode clearConers];

    [self.tool_QrCode drawCorners_CodeObject:metadataObjects];

    if (metadataObjects != nil && [metadataObjects count] > 0) {

        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];

        if (metadataObj != nil) {
            if (self.judege_NO == 2) {

                [self performSegueWithIdentifier:@"show" sender:metadataObj.stringValue];
            }
        }
    }
}

#pragma  mark -- 跳转
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    Show_ViewController *show_ViewController = segue.destinationViewController;
    self.delgate = show_ViewController;

    if ([self.delgate respondsToSelector:@selector(QrCodeViewController_Data:)]) {

        [self.delgate QrCodeViewController_Data:sender];
    }
}


@end
