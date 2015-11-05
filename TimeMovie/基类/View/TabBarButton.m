//
//  TabBarButton.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

- (id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 创建图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 20) / 2, 8, 20, 22)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        
        //图片的拉伸模式
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // 创建label
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, frame.size.width, 15)];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLabel];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
