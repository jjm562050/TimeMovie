//
//  WebNewsViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/31.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "WebNewsViewController.h"

@interface WebNewsViewController ()

@end

@implementation WebNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新闻详情";
    
    //创建UIWebView
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    //1.读取文件
    // 读取 html 文件路径
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
    
    // 读取文件数据
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    //读取新闻数据文件
    NSDictionary *dic = [BaseJSON readJSONPath:@"news_detail"];
    
    //2.拼接 html 字符串
    //读取网页所需要的数据
    NSString *title = dic[@"title"];
    NSString *content = dic[@"content"];
    NSString *time = dic[@"time"];
    NSString *source = dic[@"soucre"];
    
    htmlString = [NSString stringWithFormat:htmlString,title,content,time,source];
    
    //3.加载页面
    [web loadHTMLString:htmlString baseURL:nil];
    
    //自适应大小
    web.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
