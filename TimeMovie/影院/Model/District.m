//
//  District.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "District.h"

@implementation District

-(id)initContentWithDic:(NSDictionary *)jsonDic
{
    self= [super initContentWithDic:jsonDic];
    if(self)
    {
        self.districtID = jsonDic[@"id"];
        
        // 初始化电影院数组
        _cinemas = [[NSMutableArray alloc]init];
    }
    
    return self;
}
@end
