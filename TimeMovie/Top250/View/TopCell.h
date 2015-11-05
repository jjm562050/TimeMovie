//
//  TopCell.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
@class Top;
@interface TopCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bjImageView;

@property (strong, nonatomic) IBOutlet StarView *starImageView;


@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic,strong) Top *top;
@end
