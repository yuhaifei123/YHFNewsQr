//
//  Show_WebView.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/27.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Show_WebView.h"

@implementation Show_WebView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

        [self add_Type];
    }
    return self;
}

-(void)add_Type{

    //去掉UIWebView上下滚动出边界时的黑色阴影
    self.backgroundColor=[UIColor clearColor];
    for (UIView *aView in [self subviews])
    {
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条 （水平的类似）

            for (UIView *shadowView in aView.subviews)
            {

                if ([shadowView isKindOfClass:[UIImageView class]])
                {
                    shadowView.hidden = YES;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }

    //添加网页
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self loadHTMLString:html baseURL:baseURL];
}

@end
