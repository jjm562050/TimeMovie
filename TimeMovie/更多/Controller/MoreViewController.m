//
//  MoreViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
{
    UILabel *_titleLabel;
}

@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark - 设置导航栏的标题    
    //设置导航栏的标题
    self.title = @"更多";
    //自定义导航栏的标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:23 weight:0.5];
    _titleLabel.text = self.title;
    
    //将titleLabel 加到导航栏上
    self.navigationItem.titleView = _titleLabel;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    
}

#pragma mark - 获取缓存文件的路径 并 计算当前应用程序缓存文件的大小

-(CGFloat)countCacheFileSize
{
    //1.获取缓存文件夹的路径
    //函数 用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();
    //NSLog(@"%@",homePath);
    
    /*
     字文件夹1： 视频缓存 /tmp/
     字文件夹2:  SDWebImage框架的缓存图片 /Library/Caches/com.hackemist.SDWebImageCache.default/
     字文件夹3:  SDWebImage框架的缓存图片 /Library/Caches/com.huiwenjiaoyu.TimeMovie/
     */
    
    //2.使用 - (CGFloat)getFileSize:(NSString *)filePath  来计算这些文件夹中文件的大小
    NSArray *pathArray = @[@"/tmp/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/",@"/Library/Caches/com.huiwenjiaoyu.TimeMovie/"];
    
    //初始化fileSize
    CGFloat fileSize = 0;
    
    //文件大小之和
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
        fileSize += [self getFileSize:filePath];
    }
    
    //3.对上一步计算的结果进行求和 并返回
    return fileSize;
}

#pragma mark - 计算此路径下的文件大小
- (CGFloat)getFileSize:(NSString *)filePath
{
    // 文件管理对象  单例
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //数组 存储文件夹中所有的字文件夹以及文夹的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    
    //初始化size
    long long size = 0;
    
    //遍历文件夹
    for(NSString *fileName in fileNames)
    {
        //拼接获取文件夹的路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        
        //获取文件信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        
        //获取耽搁文件的大小
        NSNumber *sizeNumber = dic[NSFileSize];
        
        //使用一个 long long 类型来存储文件大小
        long long subFileSize = [sizeNumber longLongValue];
        
        //文件大小求和
        size += subFileSize;
    }

    return size / 1024.0 /1024;
}

#pragma mark - 清理缓存
-(void)clearCache
{
    //NSString *string = @"清理中....";
    
    //1.获取文件路径
    //1.获取缓存文件夹的路径
    //函数 用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();
    //NSLog(@"%@",homePath);
    
    NSArray *pathArray = @[@"/tmp/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/",@"/Library/Caches/com.huiwenjiaoyu.TimeMovie/"];
    
    //2.删除文件
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
        // 文件管理对象  单例
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //数组 存储文件夹中所有的字文件夹以及文夹的名字
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];

        //遍历文件夹
        for(NSString *fileName in fileNames)
        {
            //拼接获取文件夹的路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
            
            //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
            
        }
    }
    
    //3.重新计算缓存大小
     _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
}








#pragma mark - 单元格的选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        //创建提示框
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否清理缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alter show];
    }
}

#pragma msrk - 提示框的点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    //判断点击的按钮 “确定”
    if(buttonIndex == 1)
    {
        //清理缓存
        [self clearCache];
    }
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
