//
//  PostMovieCell.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PostMovieCell.h"
#import "Movie.h"
@implementation PostMovieCell

-(void)setMovie:(Movie *)movie
{
    _movie = movie;
    //背景大图
    NSURL *url = [NSURL URLWithString:_movie.images[MovieImageKeyLarge]];
    [_bigImageView sd_setImageWithURL:url];
    
    //小视图
    NSURL *url1 = [NSURL URLWithString:_movie.images[MovieImageKeySmall]];
    [_smallImageView sd_setImageWithURL:url1];
    
    _titleCLabel.text = _movie.titleC;
    
    _titleELabel.text = _movie.titleE;
    
    _yearLabel.text = _movie.year;
    
    _starView.rating = _movie.rating;

}

// 翻转单元格
- (void)filpCell
{
    [UIView transitionWithView:self
                      duration:0.3
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                    
                        _bigImageView.hidden = !_bigImageView.hidden;
                        
                    }
                    completion:nil];
}


//取消翻转
- (void)backFilpCell{
    _bigImageView.hidden = NO;
}




- (void)awakeFromNib {
        // Initialization code
}

@end
