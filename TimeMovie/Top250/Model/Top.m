//
//  Top.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "Top.h"

@implementation Top

-(id)initWithContentsOfDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self)
    {
        _images = dictionary[@"images"];
        
        _title = dictionary[@"title"];
        
        NSDictionary *rating = dictionary[@"rating"];
        NSNumber *number = rating[@"average"];
        _rating = [number floatValue];
        
    }
    return self;
}




@end
