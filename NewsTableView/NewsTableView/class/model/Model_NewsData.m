//
//  Model_NewsData.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/25.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Model_NewsData.h"
#import "Tool_Methods.h"

@implementation Model_NewsData

#pragma  mark -- kvc
+ (instancetype)NewsDataWithDict:(NSDictionary *)dict{

    Model_NewsData *model_NewsData = [[self alloc] init];
    [model_NewsData setValuesForKeysWithDictionary:dict];
    return model_NewsData;
}

#pragma  mark --  模型转字典
+(NSDictionary *)NewsDic_Model:(Model_NewsData *)model{

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",model.Id],@"Id",
                         [Tool_Methods tool_Judge_NSnull:model.title],@"title",
                         [Tool_Methods tool_Judge_NSnull:model.source],@"source",
                         [Tool_Methods tool_Judge_NSnull:model.link],@"link",
                         [Tool_Methods tool_Judge_NSnull:model.author],@"author",
                         [Tool_Methods tool_Judge_NSnull:model.category],@"category",
                         [Tool_Methods tool_Judge_NSnull:model.pubDate],@"pubDate",
                         [Tool_Methods tool_Judge_NSnull:model.comments],@"comments",
                         [Tool_Methods tool_Judge_NSnull:model.Description],@"Description",
                         [Tool_Methods tool_Judge_NSnull:model.enclosure],@"enclosure",
                         nil];

    return dic;
}
@end
