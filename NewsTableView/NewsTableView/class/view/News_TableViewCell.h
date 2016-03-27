//
//  News_TableViewCell.h
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/25.
//  Copyright © 2016年 虞海飞. All rights reserved.
//
@class Model_NewsData;

@interface News_TableViewCell : UITableViewCell

@property (nonatomic,strong) Model_NewsData *model_NewsData;
@property (nonatomic,strong) NSDictionary *dic_NewsData;
@end
