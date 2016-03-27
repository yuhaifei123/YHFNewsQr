//
//  Model_NewsData.h
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/25.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_NewsData : NSObject
@property (nonatomic,assign) int Id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *pubDate;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic,copy) NSString *Description;//描述 关键字
@property (nonatomic,copy) NSString *enclosure;

/**
 * kvc
 */
+ (instancetype)NewsDataWithDict:(NSDictionary *)dict;

/**
 * 模型转字典
 */
+(NSDictionary *)NewsDic_Model:(Model_NewsData *)model;

@end
