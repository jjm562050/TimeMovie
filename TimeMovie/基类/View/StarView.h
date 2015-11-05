//
//  StarView.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
{
    UIView *_grayView;      //灰色星星视图

    UIView *_yellowView;    //黄色星星视图
}

@property (nonatomic, assign) CGFloat rating;   // 星星视图显示的评分

@end
