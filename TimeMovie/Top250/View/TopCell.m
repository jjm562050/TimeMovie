//
//  TopCell.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "TopCell.h"
#import "Top.h"
#import "StarView.h"

@implementation TopCell

- (void)setTop:(Top *)top
{
    _top = top;
    
    NSString *urlString = _top.images[@"small"];
    NSURL *url = [NSURL URLWithString:urlString];
    [_bjImageView sd_setImageWithURL:url];
    
    _titleLabel.text = _top.title;
    
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_top.rating];
    
    _starImageView.rating = _top.rating;
    
}

@end
