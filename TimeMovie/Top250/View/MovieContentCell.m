//
//  MovieContentCell.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MovieContentCell.h"
#import "MovieContent.h"

//视频播放框架
#import <MediaPlayer/MediaPlayer.h>

@implementation MovieContentCell

//填充数据
- (void)setMovieContent:(MovieContent *)movieContent
{
    _movieContent = movieContent;
    
    //标题
    _titleCn.text = _movieContent.titleCn;
    
    //加载图片
    NSURL *url = [NSURL URLWithString:_movieContent.image];
    [_image sd_setImageWithURL:url];
    
    //加载 地点 时间
    NSDictionary *dic =_movieContent.movieRelease;
    NSString *location = dic[@"location"];
    NSString *date = dic[@"date"];
    NSString *string = [NSString stringWithFormat:@"%@ %@",location,date];
    _movieReleaseLabel.text = string;
    
    //导演
    NSArray *directors = _movieContent.directors;
    
    NSString *str = [directors componentsJoinedByString:@","];
    
    _directorsLabel.text = str;
    
    //演员
    NSArray *actors = _movieContent.actors;
 
    NSString *str1 = [actors componentsJoinedByString:@","];
    
    _actorsLabel.text = str1;
    
    //类型
    NSArray *type = _movieContent.type;
    
    NSString *str2 = [type componentsJoinedByString:@","];
    
    _typeLabel.text =str2;
    
    //movie_content
    
    NSURL *url1 = [NSURL URLWithString:_movieContent.userImage];
    
    //设置图片视图的边框
    _userImageView.layer.borderWidth = 2;
    _userImageView.layer.cornerRadius = 10;
    _userImageView.layer.masksToBounds = YES;
    
    [_userImageView sd_setImageWithURL:url1];
    
    _nickNameLabel.text = _movieContent.nickname;
    
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_movieContent.rating];
    
    _conttentLabel.text = _movieContent.content;
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
