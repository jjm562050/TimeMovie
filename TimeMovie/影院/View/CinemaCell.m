    //
//  CinemaCell.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "CinemaCell.h"
#import "Cinema.h"

@implementation CinemaCell

//复写
- (void)setCinema:(Cinema *)cinema
{
    _cinema = cinema;
    
    //影院名
    _cinemaNameLabel.text = cinema.name;
    
    //地点
    _addressLabel.text = cinema.address;
    
    //价格
    if(cinema.lowPrice.length == 0)
    {
        _priceLabel.text = @"无价格";
    }
    else
    {
        _priceLabel.text = [NSString stringWithFormat:@"$%@",cinema.lowPrice];
    }
    
    //距离
    //_distanceLabel.text = cinema.distance;
    
    //评价
    _ratingLabel.text = cinema.grade;
    
    //"isSeatSupport"
    if([cinema.isSeatSupport isEqualToString:@"1"])
    {
    _isSeatSupportImageView.image = [UIImage imageNamed:@"cinemaSeatMark@2x"];
    _isSeatSupportImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    //"isCouponSupport"
    if([cinema.isCouponSupport isEqualToString:@"1"])
    {
    _isCouponSupportImageView.image = [UIImage imageNamed:@"cinemaCouponMark@2x"];
    _isCouponSupportImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    //"isImaxSupport"
    if([cinema.isImaxSupport isEqualToString:@"1"])
    {
    _isImaxSupportImageView.image = [UIImage imageNamed:@"imaxMark@2x"];
    _isImaxSupportImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    //"isGroupBuySupport"
    if([cinema.isGroupBuySupport isEqualToString:@"1"])
    {
    _isGroupBuySupportImageView.image = [UIImage imageNamed:@"cinemaGrouponMark@2x"];
    _isGroupBuySupportImageView.contentMode = UIViewContentModeScaleToFill;
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
