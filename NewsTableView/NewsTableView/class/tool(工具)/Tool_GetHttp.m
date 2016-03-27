//
//  Tool_GetHttp.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/23.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Tool_GetHttp.h"
#import "Model_NewsData.h"

@interface Tool_GetHttp ()

@property (nonatomic,strong) NSMutableArray *array_Model;//解析xml回来的数据,全部放在这里
@property (nonatomic,strong) Model_NewsData *model_NewsData;//封装回来的数据bean
@property (nonatomic,copy) NSString  *string_ElementName;

@property (nonatomic,assign) int judge_Type;

@end

static NSString *currentElementValue;

@implementation Tool_GetHttp

#pragma  mark -- 请求服务器
-(void)getHttp_Path:(NSString *)path Data:(NSDictionary *)data Judge:(judge_Data)judge Judge_Type:(enum_JudgeType)judge_Type BlockError:(void (^)())blockError{

    _judge_Type = judge_Type;

    //定义AFNetworking管理
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];

    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *rssString = nil;
        if ([responseObject isKindOfClass:[NSData class]]) {
            rssString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        } else {
            rssString = (NSString *)responseObject;
        }

        judge(operation,responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        blockError();

        NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];

        NSString *string_Judge_Typ =[NSString stringWithFormat:@"%d",judge_Type];
        self.array_Model = [settings objectForKey:string_Judge_Typ];

        //没有数据请求网络
        if(self.array_Model == nil || self.array_Model.count < 1){

            [IanAlert alertError:@"服务器正忙..." length:2.0];
        }
        else{

            //如果缓存里面有数据，就把缓存里面的数据给别人
            if ([self.delegate respondsToSelector:@selector(tool_GetHttp_MuatbelArray:JudgeType:)]) {

                NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in self.array_Model) {

                    Model_NewsData *model_Newdata = [Model_NewsData NewsDataWithDict:dic];
                    [mutableArray addObject:model_Newdata];
                }
                [self.delegate tool_GetHttp_MuatbelArray:mutableArray JudgeType:self.judge_Type];
            }
        }
    }];
}

/********************* NSXMLParserDelegate 方法 *******************/
#pragma mark -- 解析xml方法

#pragma  mark --解析起始标记
-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{

    //xml最开始，就初始化数组。解析一个对象，就初始化一个字典
    //nslog_String(elementName);
    if ([elementName isEqualToString:@"rss"]) {

        _array_Model = [NSMutableArray array];
    }
    else if ([elementName isEqualToString:@"item"]){
        _model_NewsData = [[Model_NewsData alloc] init];
    }
    else if ([elementName isEqualToString:@"enclosure"]){
       // _dic_All = [NSMutableDictionary dictionary];
       self.model_NewsData.enclosure = [attributeDict objectForKey:@"url"];
    }

    _string_ElementName = elementName;
}

#pragma  mark -- 当开始处理字符内容是触发该方法
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    if (string) {

        currentElementValue = string;
    }
}

#pragma  mark -- 解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{

    if ([elementName isEqualToString:@"item"]) {

        [self.array_Model addObject:self.model_NewsData];
    }
    else if ([elementName isEqualToString:@"rss"]){
        return;
    }
   else if ([self.string_ElementName isEqualToString:@"id"]){
        self.model_NewsData.Id = [currentElementValue intValue];
    }
    else if ([self.string_ElementName isEqualToString:@"title"]){
        self.model_NewsData.title = currentElementValue;
    }
    else if ([self.string_ElementName isEqualToString:@"source"]){
        self.model_NewsData.source = currentElementValue;
    }
    else if ([self.string_ElementName isEqualToString:@"link"]){
        self.model_NewsData.link = currentElementValue;
    }
    else if ([self.string_ElementName isEqualToString:@"author"]){
        self.model_NewsData.author = currentElementValue;
    }
    else if ([self.string_ElementName isEqualToString:@"category"]){
        self.model_NewsData.category = currentElementValue;
    }
    else if ([self.string_ElementName isEqualToString:@"pubDate"]){
        self.model_NewsData.pubDate = currentElementValue;
    }
    else if ([self.string_ElementName isEqualToString:@"comments"]){
        self.model_NewsData.comments = currentElementValue;
    }
    else if ([self.string_ElementName isEqualToString:@"description"]){
        self.model_NewsData.Description = currentElementValue;
    }
}

#pragma  mark -- 文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{

    if ([self.delegate respondsToSelector:@selector(tool_GetHttp_MuatbelArray:JudgeType:)]) {

        [self.delegate tool_GetHttp_MuatbelArray:self.array_Model JudgeType:self.judge_Type];
    }
}

#pragma  mark -- 解析错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{

   [IanAlert alertError:@"服务器正忙..." length:2.0];
}


@end
