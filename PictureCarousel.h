//
//  PictureCarousel.h
//  房兰峰
//
//  Created by admin on 15/1/8.
//  Copyright © 2016年 房兰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCarousel : UIView


///设置滚动图片的总数量
@property(nonatomic,assign) int imageCount;
///图片的数组
@property(nonatomic,strong) NSArray *arrayImage;

@end
