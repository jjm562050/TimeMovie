//
//  CinemaCell.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cinema;

@interface CinemaCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *cinemaNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *isSeatSupportImageView;

@property (weak, nonatomic) IBOutlet UIImageView *isCouponSupportImageView;

@property (weak, nonatomic) IBOutlet UIImageView *isImaxSupportImageView;

@property (weak, nonatomic) IBOutlet UIImageView *isGroupBuySupportImageView;

@property(nonatomic,strong) Cinema *cinema;

@end
