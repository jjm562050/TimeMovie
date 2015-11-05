//
//  BigImageCell.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBlock) (BOOL);

@interface BigImageCell : UICollectionViewCell<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;   //创建滑动视图
    UIImageView *_bigImageView;  //创建图片视图
    
    NSTimer *_timer;   //定时器
    
    BOOL _isTouch;
}

@property(nonatomic,assign) MyBlock block;

@property(nonatomic,strong) NSURL *urlImage;

- (void)backImageZoomingScale;

@end
