//
//  Show_ViewController.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/27.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Show_ViewController.h"
#import "QrCode_ViewController.h"
#import "Show_WebView.h"

@interface Show_ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet Show_WebView *webView;
@property (nonatomic,strong) QrCode_ViewController *qrCode_ViewController;

@property (nonatomic,copy) NSString *data;

@end

@implementation Show_ViewController

-(QrCode_ViewController *)qrCode_ViewController{

    if (_qrCode_ViewController == nil) {

        _qrCode_ViewController = [[QrCode_ViewController alloc] init];
    }
    return _qrCode_ViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     [self add_Type];
  }


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)add_Type{

    self.webView.delegate = self;
}

-(void) QrCodeViewController_Data:(NSString *)data{

    _data = data;
}

//打印数据
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *string_Data = [NSString stringWithFormat:@"alert('%@')",self.data];
    [webView stringByEvaluatingJavaScriptFromString:string_Data];
    
    return YES;
}
@end
