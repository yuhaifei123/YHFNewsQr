//
//  Shuffling_TableViewCell.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/25.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Shuffling_TableViewCell.h"
#import "Model_NewsData.h"
#import "Tool_Cache_Image.h"
#import "AdView.h"

@interface Shuffling_TableViewCell ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSTimer *timer;//定义时间
@property (nonatomic,assign) int piece; //轮播图，图片张数
@property (nonatomic,strong) AdView * adView;
@end



@implementation Shuffling_TableViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

-(void) add_view{

    //图片路径
    NSMutableArray *array_URL = [NSMutableArray array];
    //标题路径
    NSMutableArray *array_Titles = [NSMutableArray array];

    for (NSDictionary *dic in self.mutableArray_Shuffling) {

        Model_NewsData *model_NewsData = [Model_NewsData NewsDataWithDict:dic];
        [array_URL addObject:model_NewsData.enclosure];
        [array_Titles addObject:model_NewsData.title];
    }

    //如果你的这个广告视图是添加到导航控制器子控制器的View上,请添加此句,否则可忽略此句
    //  self.automaticallyAdjustsScrollViewInsets = NO;

    _adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH+5, 250.0)  \
                              imageLinkURL:array_URL\
                       placeHoderImageName:@"placeHoder.jpg" \
                      pageControlShowStyle:UIPageControlShowStyleNone];

    //    是否需要支持定时循环滚动，默认为YES
    //    adView.isNeedCycleRoll = YES;
    [self.adView setAdTitleArray:array_Titles withShowStyle:AdTitleShowStyleLeft];
    //    设置图片滚动时间,默认3s
    //    adView.adMoveTime = 2.0;

    //图片被点击后回调的方法
    self.adView.callBack = ^(NSInteger index,NSString * imageURL)
    {
        //NSLog(@"被点中图片的索引:%ld---地址:%@",index,imageURL);
    };
    [self addSubview:self.adView];

}


-(void)setMutableArray_Shuffling:(NSMutableArray *)mutableArray_Shuffling{

    _mutableArray_Shuffling = mutableArray_Shuffling;
    [self add_view];
}

@end
