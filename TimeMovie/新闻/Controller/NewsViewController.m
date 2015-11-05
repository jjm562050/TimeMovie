//
//  NewsViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "PictureNewsViewController.h"
#import "WebNewsViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *_newsTableView;  //创建表视图
    NSMutableArray *_newsData;    //创建可变数组
    
    UIImageView *_topImageView;  //表视图的第一个单元格的视图
}
@end

@implementation NewsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark - 设置导航栏的标题    
    //设置导航栏的标题
    self.title = @"新闻";
    
    //加载数据
    [self loadData];

    //调用
    //[self createNewsTableView];
}

#pragma mark - 读取数据
- (void)loadData
{
    //读取数据 数据为数组
    NSArray *array = [BaseJSON readJSONPath:@"news_list"];
    
    _newsData = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in array)
    {
        News *news = [[News alloc] initContentWithDic:dic];
        
        [_newsData addObject:news];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //从故事版上获取
    News *news = _newsData[indexPath.row];
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopNewsCell"];
        _topImageView = (UIImageView *)[cell.contentView viewWithTag:100];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:110];
        //传递数据
        titleLabel.text = news.title;
        [_topImageView sd_setImageWithURL:[NSURL URLWithString:news.image]];
        return cell;
    }
    else
    {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
        cell.titleLabel.text = news.title;
        cell.summaryLabel.text = news.summary;
        [cell.bigImageView sd_setImageWithURL:[NSURL URLWithString:news.image]];
        NSInteger type = [news.type intValue];
        if (type == 1)
        {
            //设置小图片
            cell.smallImageView.image = [UIImage imageNamed:@"sctpxw@2x"];
            
            //设置手势进入图片新闻
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(clickAction:)];
            //设置点击的次数
            tap.numberOfTapsRequired = 2;
            
            //设置点击所需的手指数
            tap.numberOfTouchesRequired = 1;
            
            [cell addGestureRecognizer:tap];
            
        }
        else if(type == 0)
        {
            //设置手势进入新闻
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(clickNewsAction:)];
            //设置点击的次数
            tap1.numberOfTapsRequired = 2;
            
            //设置点击所需的手指数
            tap1.numberOfTouchesRequired = 1;
            
            cell.smallImageView.image = nil;
            
            [cell addGestureRecognizer:tap1];
            
        }
        else
        {
            cell.smallImageView.image = nil;
        }
        
        return cell;
    }

    
}

//设置行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 150;
    }
    else
    {
        return 80;
    }
}

#pragma mark - 手势的方法
- (void)clickAction:(UITapGestureRecognizer *)tap
{
    //图片新闻
    PictureNewsViewController *pictureC = [[PictureNewsViewController alloc]init];
    
    // 设置某个视图控制器，当他在被push的时候 隐藏标签栏
    // 只能控制系统自带标签栏
    // 因为在本项目中，使用的是自己创建的标签栏  所以无法自动隐藏
    pictureC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:pictureC animated:YES];
    
}

- (void)clickNewsAction:(UITapGestureRecognizer *)tap
{
    //文字新闻
    WebNewsViewController *webNews = [[WebNewsViewController alloc]init];
    
    webNews.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:webNews animated:YES];
    
}


#pragma mark - 图片滑动放大
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //获取偏移量y 的偏移值
    CGFloat yOffSet = scrollView.contentOffset.y + 64;
    
    if(yOffSet < 0)
    {
    //图片的原始高度
    CGFloat oldImageHeight = 150;
    
    //图片变化后的高度
    CGFloat newImageHeight = oldImageHeight - yOffSet;
    
    //图片的放大比例
    CGFloat scroll = newImageHeight / oldImageHeight;
    
    //图片放大
    CGAffineTransform transfrom = CGAffineTransformMakeScale(scroll, scroll);
    _topImageView.transform = transfrom;
    
    //改变图片的位置
    _topImageView.top = yOffSet;
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
