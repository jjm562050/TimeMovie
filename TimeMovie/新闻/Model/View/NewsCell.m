//
//  NewsCell.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "NewsCell.h"
//#import "News.h"

@implementation NewsCell

//- (void)setNews:(News *)news
//{
//    _news = news;
//    //从网络获取路径
//    NSString *urlString = _news.image;
//    NSURL *url = [NSURL URLWithString:urlString];
//    [_newsImageView sd_setImageWithURL:url];
//    
//    _titleLabel.text = _news.title;
//    _summaryLabel.text = _news.summary;
//    
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
