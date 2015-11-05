//
//  BigImageCell.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BigImageCell.h"

@implementation BigImageCell

//初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self creatView];
    }
    return self;
}

#pragma mark - 创建视图
- (void)creatView
{
    //创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    //设置
    _scrollView.contentSize = self.frame.size;
    
    //设置放大倍数
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 0.5;
    
    //设置代理
    _scrollView.delegate = self;
    
    _scrollView.backgroundColor =[UIColor blackColor];
    
    [self.contentView addSubview:_scrollView];
    
    //图片视图
    _bigImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    _bigImageView.image = [UIImage imageNamed:@"11@2x"];

    //图片的拉伸模式
    _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_bigImageView];
    
    //创建手势识别器
    //单击
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTapAction)];
    
    //点击的次数
    oneTap.numberOfTapsRequired = 1;
    
    //点击所需的手指数
    oneTap.numberOfTouchesRequired = 1;
    
    //将图片视图 开启点击事件
    _bigImageView.userInteractionEnabled = YES;
    
    [_bigImageView addGestureRecognizer:oneTap];
    
    //双击
    UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoTapAction)];
    
    //点击的次数
    twoTap.numberOfTapsRequired = 2;
    
    //点击所需的手指数
    twoTap.numberOfTouchesRequired = 1;
    
    [_bigImageView addGestureRecognizer:twoTap];
    
}

#pragma mark - 手势的方法
//单击一次的方法
- (void)oneTapAction
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(oneClickAction) userInfo:nil repeats:NO];
}

//定时器的方法
- (void)oneClickAction
{/*
    _isTouch = ! _isTouch;
    //判断是否隐藏
    if(_isTouch)
    {
        //实现block 的功能
        _block(YES);
    }
    else
    {
        _block(NO);
    }
  */
    
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"oneTap" object:self];
    
}

//双击的方法
- (void)twoTapAction
{
    //取消单击 取消定时器
    [_timer invalidate];
    
    //双击放大
    //判断图片的状态
    if(_scrollView.zoomScale >= 2)
    {
        //图片处于放大状态
        [_scrollView setZoomScale:1 animated:YES];
    }
    else
    {
        //图片未处于放大状态
        [_scrollView setZoomScale:3 animated:YES];
    }
}


#pragma mark - 滑动视图的方法
//滑动视图的代理方法  返回值为捏合手势缩放的视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _bigImageView;
}

//传递数据
- (void)setUrlImage:(NSURL *)urlImage
{
    [_bigImageView sd_setImageWithURL:urlImage];
}

// 还原
-(void)backImageZoomingScale
{
    // 滑动视图的缩放比例
    [_scrollView setZoomScale:1];
}








@end
