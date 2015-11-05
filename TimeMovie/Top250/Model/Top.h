//
//  Top.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import <CoreGraphics/CoreGraphics.h>

@interface Top : NSObject

@property(nonatomic,copy) NSDictionary *images;
@property(nonatomic,copy) NSString *title;
@property(nonatomic, assign) CGFloat rating;

- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary;

@end
