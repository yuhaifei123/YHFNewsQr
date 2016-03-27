//
//  News_TableViewCell.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/25.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "News_TableViewCell.h"
#import "Model_NewsData.h"
#import "Tool_Cache_Image.h"
#import "AdView.h"

@interface News_TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView_Image;
@property (weak, nonatomic) IBOutlet UILabel *lable_Title;
@property (weak, nonatomic) IBOutlet UILabel *label_Content;
@property (weak, nonatomic) IBOutlet UILabel *label_Comments;



@end

@implementation News_TableViewCell


-(void)setDic_NewsData:(NSDictionary *)dic_NewsData{
    _dic_NewsData = dic_NewsData;

    _model_NewsData = [Model_NewsData NewsDataWithDict:_dic_NewsData];

    [self add_View];
}

#pragma  mark -- view 赋值
-(void) add_View{

    self.lable_Title.text = self.model_NewsData.title;
    self.label_Content.text = self.model_NewsData.Description;

    if ([self.model_NewsData.comments isEqualToString:@"0"]) {

        self.label_Comments.hidden = YES;
    }
    self.label_Comments.text = [NSString stringWithFormat:@"%@评论",self.model_NewsData.comments];
   [Tool_Cache_Image caChe_Image_String_Url:self.model_NewsData.enclosure ImageView:self.imageView_Image];


}

@end
