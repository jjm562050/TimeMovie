//
//  MovieContent.h
//  TimeMovie
//
//  Created by MAC22 on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//


/*
 "image" : "http://img31.mtime.cn/mt/2012/06/28/131128.94272291.jpg",
	"titleCn" : "摩尔庄园2海妖宝藏",
	"titleEn" : "Legend of The Moles-Treasure of Scylla",
	"rating" : "7.7",
	"year" : "2012",
	"content" : "摩尔庄园大电影系列第二部：《摩尔庄园海妖宝藏》继续讲述快乐、勇敢、热爱和平的小摩尔们战胜邪恶",
	"type" : [ "动画", "动作", "奇幻", "冒险" ],
	"url" : "http://movie.mtime.com/157836/",
	"directors" : [ "刘可欣" ],
	"actors" : ["阿黄","阿龟","阿宇","阿红","凤姐"],
	"release" : {
 "location" : "中国",
 "date" : "2012-7-5"
	},

 */

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import <CoreGraphics/CoreGraphics.h>

@interface MovieContent :NSObject

@property(nonatomic,copy) NSString *image;            //电影图片
@property(nonatomic,copy) NSString *titleCn;          //电影中文名
@property(nonatomic,copy) NSArray *type;              //电影类型
@property(nonatomic,copy) NSArray *directors;         //导演
@property(nonatomic,copy) NSArray *actors;            //演员
@property(nonatomic,copy) NSDictionary *movieRelease; //公映
@property(nonatomic,copy) NSArray *images;            //图片数组

/*
 
 {
 "userImage" : "http://img2.mtime.com/images/default/head.gif",
 "nickname" : "yangna988",
 "rating" : "9.0",
 "content" : "儿子很喜欢 一直期盼上映"
 },
 */

//评论
@property(nonatomic,copy) NSString *userImage;
@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,assign) CGFloat rating;

- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary;

@property(nonatomic,assign) BOOL isShow;

@end
