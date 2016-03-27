//
//  News_ViewController.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/22.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "News_ViewController.h"
#import "Tool_GetHttp.h"
#import "Tool_Cache.h"
#import "News_UITableView.h"
#import "MJRefresh.h"
#import <AVFoundation/AVFoundation.h>

@interface News_ViewController ()<UIScrollViewDelegate,NSXMLParserDelegate,Tool_CacheDelegate,News_UITableViewDelegate>

@property(nonatomic, strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet News_UITableView *news_UITableView;

@end

@implementation News_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self add_CacheData];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self add_Type];
    [self add_Refresh];
}

#pragma  mark -- 添加类型
-(void) add_Type{

    self.navigationController.navigationBar.hidden = YES;

    self.news_UITableView.delegate_News_UITableView = self;
}

#pragma  mark -- 下拉刷新
-(void) add_Refresh{

    Tool_Cache *tool_Cache = [[Tool_Cache alloc] init];
    tool_Cache.delegate = self;
    // 下拉刷新
     __weak typeof(self) weakSelf = self;
    self.news_UITableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        NSString *path_Shuffling = [NSString stringWithFormat:@"%@/%@",ALL_PATH,SHUFFLING_PATH];
        [tool_Cache add_Data_Path:path_Shuffling Judge_Type:SHUFFLING];

        NSString *path_NewsTable = [NSString stringWithFormat:@"%@/%@",ALL_PATH,NEWSTABLE_PATH];
        [tool_Cache add_Data_Path:path_NewsTable Judge_Type:NEWSTABLE];

        // 结束刷新
        [weakSelf.news_UITableView.mj_header endRefreshing];
    }];
}

#pragma  mark -- 请求缓存数据
-(void) add_CacheData{

    Tool_Cache *tool_Cache = [[Tool_Cache alloc] init];
    tool_Cache.delegate = self;

    NSString *path_Shuffling = [NSString stringWithFormat:@"%@/%@",ALL_PATH,SHUFFLING_PATH];
     self.news_UITableView.mutableArray_Shuffling = [tool_Cache cache_Path:path_Shuffling Judge_Type:SHUFFLING];

    NSString *path_NewsTable = [NSString stringWithFormat:@"%@/%@",ALL_PATH,NEWSTABLE_PATH];
   self.news_UITableView.mutableArray_NewsTable = [tool_Cache cache_Path:path_NewsTable Judge_Type:NEWSTABLE];
}

#pragma  mark -- Tool_CacheDelegate

-(void)Tool_Cache_MutableAray:(NSMutableArray *)mutableAray JudgeType:(enum_JudgeType)judgeType{

    switch (judgeType) {

        case SHUFFLING:
        
            self.news_UITableView.mutableArray_Shuffling = mutableAray;
            break;

        default:

            self.news_UITableView.mutableArray_NewsTable = mutableAray;
            break;
    }
}

#pragma  mark -- News_UITableViewDelegate
-(void)News_UITableView_Onclick{

    [self performSegueWithIdentifier:@"QrCode" sender:nil];
}
@end
