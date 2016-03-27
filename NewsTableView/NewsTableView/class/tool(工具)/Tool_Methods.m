//
//  Tool_Methods.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/24.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Tool_Methods.h"

@implementation Tool_Methods

#pragma  mark -- 判断是不是nsnull
+(NSString *) tool_Judge_NSnull:(NSString *)string{

    NSString *string_NSNull = @"";
    if (![string isEqual:[NSNull null]] && string != nil && ![string isEqualToString:@"<null>"]) {

        string_NSNull = string;
    }
    return string_NSNull;
}

@end
