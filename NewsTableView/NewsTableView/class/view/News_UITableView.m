//
//  News_UITableView.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/24.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "News_UITableView.h"
#import "News_TableViewCell.h"
#import "Shuffling_TableViewCell.h"

@interface News_UITableView ()<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic,strong) Shuffling_UIScrollView *shuffling_UIScrollView;//轮播图

@end

static NSString *news_Cell = @"NEWSCELL";
static NSString *shuffling_Cell = @"SHUFFLINGCELL";

@implementation News_UITableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

        self.tableFooterView = [[UIView alloc] init];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

//set方法
-(void)setMutableArray_NewsTable:(NSMutableArray *)mutableArray_NewsTable{

    _mutableArray_NewsTable = mutableArray_NewsTable;
    [self reloadData];
}


#pragma mark - Table view data source
//一组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

//多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.mutableArray_NewsTable.count;
}

//设置cell
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     if (indexPath.row == 0) {

         Shuffling_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shuffling_Cell];
         if (cell == nil){

                cell = [[[NSBundle mainBundle] loadNibNamed:@"Shuffling_TableViewCell" owner:nil options:nil] objectAtIndex:0];
                cell.mutableArray_Shuffling = self.mutableArray_Shuffling;
         }
          return cell;
     }
     else{

         News_TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:news_Cell];
         if (cell == nil){

              cell = [[[NSBundle mainBundle] loadNibNamed:@"News_TableViewCell" owner:nil options:nil] objectAtIndex:0];
              cell.dic_NewsData = self.mutableArray_NewsTable[indexPath.row];
         }
         return cell;
     }
 }

//行高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat result = 104.0f;

    if (indexPath.row == 0) {

         result = 250.0;
    }
    return result;
}

//选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.delegate_News_UITableView respondsToSelector:@selector(News_UITableView_Onclick)]) {

        [self.delegate_News_UITableView News_UITableView_Onclick];
    }
}

@end
