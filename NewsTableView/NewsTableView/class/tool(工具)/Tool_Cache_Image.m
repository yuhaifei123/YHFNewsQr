//
//  Tool_Cache_Image.m
//  NewsTableView
//
//  Created by 虞海飞 on 16/3/25.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Tool_Cache_Image.h"

@implementation Tool_Cache_Image

#pragma  mark -- 拿网络图片
+(void) caChe_Image_String_Url:(NSString *)string_url ImageView:(UIImageView *)imageView{

    //判读有没有缓存，
    if (![[SDImageCache sharedImageCache] diskImageExistsWithKey:string_url]) {

        //没有缓存，就网络拿图片
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:string_url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {

            if (image == nil) {

                [imageView setImage:[UIImage imageNamed:@"headimage"]];
            }
            else{
                [imageView setImage:image];
            }
        }];
    }
    else{

        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:string_url];

        if (image == nil) {

            [imageView setImage:[UIImage imageNamed:@"headimage"]];
        }
        else{
            [imageView setImage:image];
        }
    }
}

@end
