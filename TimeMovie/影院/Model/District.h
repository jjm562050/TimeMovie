//
//  District.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseModel.h"

@interface District : BaseModel

/*
 {
 "name" : "东城区",
 "id" : "1029"
 }
 */

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *districtID;

@property (nonatomic ,strong) NSMutableArray *cinemas;

@property (nonatomic,assign) BOOL isShow;


@end
