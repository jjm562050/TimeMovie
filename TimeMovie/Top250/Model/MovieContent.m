//
//  MovieContent.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MovieContent.h"

@implementation MovieContent

- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary
{
    self =[super init];
    if(self)
    {
        _userImage = dictionary[@"userImage"];
        
        _nickname = dictionary[@"nickname"];
        
        _content = dictionary[@"content"];
        
        
        NSNumber *number = dictionary[@"rating"];
        _rating = [number floatValue];
        
    }
    return self;
}

@end
