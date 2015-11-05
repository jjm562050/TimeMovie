//
//  MovieCell.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/21.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Movie;

@interface MovieCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *movieImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *yearLabel;

@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;

@property (strong, nonatomic) IBOutlet UIView *starView;

@property(nonatomic,copy) Movie *movie;

@end
