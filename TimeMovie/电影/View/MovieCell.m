//
//  MovieCell.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/21.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import "StarView.h"

@implementation MovieCell

//重写setMovie
- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    // 将电影model对象中存储的数据，取出来显示到label imageView
    _titleLabel.text = _movie.titleC;
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_movie.rating];
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@",_movie.year];
    
    // 从网络读取图片
    // 创建url
    NSString *urlString = _movie.images[MovieImageKeySmall];
    NSURL *url = [NSURL URLWithString:urlString];
    [_movieImageView sd_setImageWithURL:url];
    
    //
    StarView *star = [[StarView alloc]initWithFrame:_starView.bounds];
    //清楚背景颜色
    _starView.backgroundColor = [UIColor clearColor];
    [_starView addSubview:star];
    star.rating = _movie.rating;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
