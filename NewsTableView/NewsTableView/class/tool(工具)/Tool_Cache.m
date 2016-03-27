//
//  Tool_Cache.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/23.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Tool_Cache.h"
#import "Tool_GetHttp.h"
#import "Model_NewsData.h"

@interface Tool_Cache ()<Tool_GetHttpDelegate>

@property (nonatomic,strong) NSMutableArray *mutableArray_Model_Data;

@end

static NSString *shuffling = @"SHUFFLING";
static NSString *newsTable = @"NEWSTABLE";

@implementation Tool_Cache

-(NSMutableArray *) cache_Path:(NSString *)path Judge_Type:(enum_JudgeType)judge_Type {

    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];

    NSString *string_Judge_Typ =[NSString stringWithFormat:@"%d",judge_Type];
    _mutableArray_Model_Data = [settings objectForKey:string_Judge_Typ];

    //没有数据请求网络
    if(_mutableArray_Model_Data == nil || _mutableArray_Model_Data.count < 1){

        [self add_Data_Path:path Judge_Type:judge_Type];
    }

    return self.mutableArray_Model_Data;
}

#pragma  mark -- 请求数据 //@"cms/topimages.php?typeid=72"
-(void) add_Data_Path:(NSString *)path Judge_Type:(enum_JudgeType)judge_Type{

    Tool_GetHttp *tool_GetHttp = [[Tool_GetHttp alloc] init];

    [tool_GetHttp getHttp_Path:path Data:nil Judge:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            //解析会来的 xml数据
            NSXMLParser * parser = [[NSXMLParser alloc] initWithData:responseObject];
    
            parser.delegate = tool_GetHttp;
            tool_GetHttp.delegate = self;
    
            [parser setShouldProcessNamespaces:YES];
    
            //此法基本可行，但是处理麻烦
            [parser parse];

    } Judge_Type:judge_Type BlockError:^{

         tool_GetHttp.delegate = self;
    }];
}

#pragma  mark -- Tool_GetHttpDelegate

-(void)tool_GetHttp_MuatbelArray:(NSMutableArray *)mutableArray JudgeType:(enum_JudgeType)judgeType{

    _mutableArray_Model_Data = mutableArray;
    NSMutableArray *mutableArray_Data = [NSMutableArray array];
        //NSUserDefaults 不能存入自定义类型 模型转化
        for (Model_NewsData *model_NewsData in _mutableArray_Model_Data) {
    
            NSDictionary *dic_NewsData =  [Model_NewsData NewsDic_Model:model_NewsData];
            [mutableArray_Data addObject:dic_NewsData];
        }

        NSString *string_JudgeType = [NSString stringWithFormat:@"%d",judgeType];
        NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
        [setting setObject:mutableArray_Data forKey:string_JudgeType];
        [setting synchronize];

    //请求网络，就把数据给别人
    if ([self.delegate respondsToSelector:@selector(Tool_Cache_MutableAray:JudgeType:)]) {

        [self.delegate Tool_Cache_MutableAray:mutableArray_Data JudgeType:judgeType];
    }
}

@end
