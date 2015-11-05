//
//  MovieContentCell.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieContent;
@interface MovieContentCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *titleCn;

@property (weak, nonatomic) IBOutlet UILabel *directorsLabel;

@property (weak, nonatomic) IBOutlet UILabel *actorsLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *movieReleaseLabel;


//movie_content

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) IBOutlet UILabel *conttentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *frameImageView;


//滑动视图

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic , weak) UINavigationController *naviGgationController;

@property (nonatomic,strong) MovieContent *movieContent;



@end
