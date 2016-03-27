//
//  Tool_Cache.h
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/23.
//  Copyright © 2016年 虞海飞. All rights reserved.
//
//缓存
#import "Tool_GetHttp.h"

@protocol Tool_CacheDelegate <NSObject>

@optional
-(void) Tool_Cache_MutableAray:(NSMutableArray *)mutableAray JudgeType:(enum_JudgeType)judgeType;

@end

@interface Tool_Cache : NSObject

@property (nonatomic,weak) id<Tool_CacheDelegate> delegate;

/**
 *  缓存数据
 */
-(NSMutableArray *) cache_Path:(NSString *)path Judge_Type:(enum_JudgeType)judge_Typ;

/**
 *  请求数据
 */
-(void) add_Data_Path:(NSString *)path Judge_Type:(enum_JudgeType)judge_Type;

@end
