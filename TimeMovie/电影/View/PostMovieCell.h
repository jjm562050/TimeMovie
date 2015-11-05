//
//  PostMovieCell.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
@class Movie;
@interface PostMovieCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleCLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleELabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (weak, nonatomic) IBOutlet StarView *starView;

@property(nonatomic,strong) Movie *movie;

// 翻转单元格
- (void)filpCell;


//  取消翻转
- (void)backFilpCell;

@end
