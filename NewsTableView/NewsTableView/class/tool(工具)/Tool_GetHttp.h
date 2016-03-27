//
//  Tool_GetHttp.h
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/23.
//  Copyright © 2016年 虞海飞. All rights reserved.
//
//访问网络

@protocol Tool_GetHttpDelegate <NSObject>

//枚举
typedef enum {SHUFFLING = 1,NEWSTABLE} enum_JudgeType;

@optional
/**
 * 代理返回，服务器数据
 */
-(void) tool_GetHttp_MuatbelArray:(NSMutableArray *)mutableArray JudgeType:(enum_JudgeType)judgeType;
@end



@interface Tool_GetHttp : NSObject<NSXMLParserDelegate>

/**
 * block 请求服务器，返回原始数据
 *  @param dic <#dic description#>
 */
typedef void (^judge_Data)(AFHTTPRequestOperation *operation, id responseObject);

@property (nonatomic,weak) id<Tool_GetHttpDelegate> delegate;

/**
 *  最普通的方法请求（）
 *
 *  @param path  路径
 *  @param  data 请求属性
 *  @param judge 返回block函数
 */
-(void) getHttp_Path:(NSString *)path Data:(NSDictionary *)data Judge:(void (^)(AFHTTPRequestOperation *operation, id responseObject))judge Judge_Type:(enum_JudgeType)judge_Type BlockError:(void (^)())blockError;

@end
