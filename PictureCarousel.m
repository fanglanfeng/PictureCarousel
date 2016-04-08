//
//  PictureCarousel.m
//  房兰峰
//
//  Created by admin on 15/1/8.
//  Copyright © 2016年 房兰峰. All rights reserved.
//

#import "PictureCarousel.h"

@interface PictureCarousel ()<UIScrollViewDelegate>
///滚动的scrollerView
@property(nonatomic,weak) UIScrollView *scrollerView;
///滚动视图的中间显示的图片
@property(nonatomic,weak) UIImageView *currentImageView;
///滚动视图的上一张图
@property(nonatomic,weak) UIImageView *preImageView;
///滚动视图的下一张图
@property(nonatomic,weak) UIImageView *nextImageView;
///定时器
@property(nonatomic,strong) NSTimer *timer;
///标记滚动中是否交互（拖动）
@property(nonatomic,assign) BOOL isDragging;
///分页控制器
@property(nonatomic,weak) UIPageControl *pageControl;

@end

@implementation PictureCarousel

///init初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        
        UIScrollView *scrollerView = [[UIScrollView alloc] init];
        scrollerView.pagingEnabled = YES;
        scrollerView.scrollEnabled = YES;
        scrollerView.showsHorizontalScrollIndicator = NO;
        scrollerView.showsVerticalScrollIndicator = NO;
        scrollerView.bounces = NO;
        scrollerView.delegate = self;
        self.scrollerView = scrollerView;
        [self addSubview:scrollerView];
        
        UIImageView *currentImageView = [[UIImageView alloc] init];
        currentImageView.userInteractionEnabled = YES;
        [currentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
        self.currentImageView = currentImageView;
        [self.scrollerView addSubview:currentImageView];
        
        UIImageView *nextImageView = [[UIImageView alloc] init];
        self.nextImageView = nextImageView;
        [self.scrollerView addSubview:nextImageView];
        
        UIImageView *preImage = [[UIImageView alloc] init];
        self.preImageView = preImage;
        [self.scrollerView addSubview:preImage];
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        //当页码是只有1张的时候，隐藏
        pageControl.hidesForSinglePage = YES;
        pageControl.currentPage = 0;
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _isDragging = YES;
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    self.scrollerView.frame = CGRectMake(0, 0, width, height);
    self.scrollerView.contentSize = CGSizeMake(width * 3, height);
    self.scrollerView.contentOffset = CGPointMake(width, 0);
    
    self.currentImageView.frame = CGRectMake(width, 0, width, height);
    
    self.nextImageView.frame = CGRectMake(2*width, 0, width, height);
    
    self.preImageView.frame = CGRectMake(0, 0, width, height);
    
    self.pageControl.center = CGPointMake(self.scrollerView.frame.size.width * 0.5, self.scrollerView.frame.size.height - 10);
    
     NSLog(@"002%@",NSStringFromCGRect(self.frame));

}

-(void)setImageCount:(int)imageCount{
    
    _imageCount = imageCount;
    self.currentImageView.image = self.arrayImage[0];
    self.nextImageView.image = self.arrayImage[1];
    self.preImageView.image = self.arrayImage[self.imageCount - 1];
    self.pageControl.numberOfPages = self.imageCount;
}
///点击滚动的触发事件
-(void)imageClick{
    
    int i = (int)self.pageControl.currentPage;
    NSLog(@"你点击的图片第%d张图片是,%@",i,self.arrayImage[i]);
}

///自动无线循环的定时器的触发事件
-(void)update:(NSTimer *)timer{
    
    if (_isDragging == NO) {return;}
    CGPoint offset = self.scrollerView.contentOffset;
    offset.x += offset.x;
    [self.scrollerView setContentOffset:offset animated:YES];
    if (offset.x >= self.scrollerView.bounds.size.width * 2) {
        offset.x = self.scrollerView.frame.size.width;
    }
}

#pragma  mark - UIScrollerViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDragging = NO;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isDragging = YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    static int i = 1;
    CGFloat offset = scrollView.contentOffset.x;
    self.pageControl.currentPage = i;
    
    if (self.nextImageView.image == nil || self.preImageView.image == nil) {
        //测试数据用
        //        NSString *imageName1 = [NSString stringWithFormat:@"%d.png",i == self.imageCount ? 1 : i + 1];
        //        NSString *imageName2 = [NSString stringWithFormat:@"%d.png", i == 1 ? self.imageCount : i - 1];
        
        int index1 = i == self.imageCount ? 1 : i + 1;
        self.nextImageView.image = self.arrayImage[index1-1];
        
        int index2 = i == 1 ? self.imageCount : i - 1;
        self.preImageView.image = self.arrayImage[index2-1];
    }
    
    if (offset == 0) {
        self.currentImageView.image = self.preImageView.image;
        self.scrollerView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        self.preImageView.image = nil;
        if (i == 1) {
            i = self.imageCount;
        }else{
            i -= 1;
        }
    }
    if (offset == scrollView.bounds.size.width * 2) {
        self.currentImageView.image = self.nextImageView.image;
        self.scrollerView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        self.nextImageView.image = nil;
        if (i == self.imageCount) {
            i = 1;
        }else{
            i += 1;
        }
    }
    
    self.pageControl.currentPage = i-1;
}



@end
