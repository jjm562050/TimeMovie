//
//  BaseJSON.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseJSON.h"

@implementation BaseJSON

+(id)readJSONPath:(NSString *)fileName
{
    //1.获取数据文件的路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    //2.读取数据
    //NSData 里面的数据以二进制的方式存储  字符串 字典 数组 UIImage 等等
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //NSData －> NSString
    //encoding编码格式  NSUTF8StringEncoding
    //NSString *string = [[NSString alloc]initWithData:data encoding:    NSUTF8StringEncoding];
    //NSLog(@"%@",string);
    
    //3.文件解析
    id json = [NSJSONSerialization JSONObjectWithData:data
                                               options:NSJSONReadingMutableLeaves
                                                 error:nil];
    
    return json;
}

@end
