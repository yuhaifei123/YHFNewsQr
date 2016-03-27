//
//  News_UITableView.h
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/24.
//  Copyright © 2016年 虞海飞. All rights reserved.
//
@class Shuffling_UIScrollView;

@protocol  News_UITableViewDelegate <NSObject>

@required
-(void) News_UITableView_Onclick;//谁要是代理，就必须执行这个代理，点击回调

@end

@interface News_UITableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *mutableArray_NewsTable;
@property (nonatomic,strong) NSMutableArray *mutableArray_Shuffling;

@property (nonatomic,weak) id<News_UITableViewDelegate> delegate_News_UITableView;
@end
