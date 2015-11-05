//
//  MovieContentViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MovieContentViewController.h"
#import "MovieContentCell.h"
#import "MovieContent.h"
#import "UIButton+WebCache.h"

//视频播放框架
#import <MediaPlayer/MediaPlayer.h>

@interface MovieContentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;  //创建表视图
    
    NSMutableArray *_dataArray; //创建可变数组  存储电影信息
    
    NSMutableArray *_dataContentArray; //创建数组  存储评论
    
    
}

@property (nonatomic , weak) UINavigationController *naviGgationController;

@end

@implementation MovieContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏标题
    self.title = @"电影详情";
    
    //调用读取数据
    [self loadData];
    
    //调用creatView
    [self creatView];
    
}

#pragma mark - 读取数据
- (void)loadData
{
    //movie_detail.json
    NSDictionary *dic = [BaseJSON readJSONPath:@"movie_detail"];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    MovieContent *movieContent = [[MovieContent alloc]init];
    
    movieContent.titleCn = dic[@"titleCn"];
    movieContent.image = dic[@"image"];
    movieContent.type = dic[@"type"];
    movieContent.directors = dic[@"directors"];
    movieContent.actors = dic[@"actors"];
    movieContent.movieRelease = dic[@"release"];
    movieContent.images = dic[@"images"];
    
    //NSLog(@"%@",movieContent.images);
    
    [_dataArray addObject:movieContent];
    
    //movie_comment.json
    NSDictionary *dic1 = [BaseJSON readJSONPath:@"movie_comment"];
    
    NSArray *data = dic1[@"list"];
    
    _dataContentArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in data)
    {
        MovieContent *movieContent1 = [[MovieContent alloc]initWithContentsOfDictionary:dic];
        
        [_dataContentArray addObject:movieContent1];
    }
    
}

#pragma mark - 创建视图
- (void)creatView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    
    //设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count + _dataContentArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
     
     MovieContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MovieContentCell" owner:self options:nil]firstObject];
    }
        cell.backgroundColor = [UIColor blackColor];
        
        cell.movieContent = _dataArray[indexPath.row];
        NSLog(@"%ld",indexPath.row);
    
        return cell;
    }
    else if(indexPath.row == 1)
    {
        
        MovieContentCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        if (cell2 == nil) {
            cell2 = [[[NSBundle mainBundle]loadNibNamed:@"MovieContentCell" owner:self options:nil] objectAtIndex:1];
        }
        
        MovieContent *movie = _dataArray[0];
        
        NSArray *dataImage = movie.images;
        
        //滑动视图
        //设置尺寸
        cell2.scrollView.contentSize = CGSizeMake(cell2.size.width * 0.3 * dataImage.count, 70);
        
        //是否分页
        cell2.scrollView.pagingEnabled = YES;
        
        //四周间隙
        //cell2.scrollView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        //设置隐藏滑动条
        cell2.scrollView.showsHorizontalScrollIndicator = NO;
        cell2.scrollView.showsVerticalScrollIndicator = NO;
        
        cell2.scrollView.layer.borderColor = [UIColor grayColor].CGColor;
        cell2.scrollView.layer.borderWidth = 2;
        cell2.scrollView.layer.cornerRadius = 10;
        
//        for (int i =0;i<data.count;i++)
//        {
//            //创建图片视图
//            UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(i * cell2.size.width * 0.3 , 5, cell2.size.width * 0.28, 70)];
//            
//            NSURL *url = [NSURL URLWithString:data[i]];
//            [images sd_setImageWithURL:url];
//            
//            images.layer.borderWidth = 2;
//            images.layer.borderColor = [UIColor clearColor].CGColor;
//            images.layer.cornerRadius = 10;
//            images.layer.masksToBounds = YES;
//            
//            images.contentMode = UIViewContentModeScaleToFill;
//            
//            [cell2.scrollView addSubview:images];
//        }
        
        for (int i = 0;i<dataImage.count;i++)
        {
            UIButton *buttonImage = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonImage.frame = CGRectMake(i * cell2.size.width * 0.3, 5, cell2.size.width * 0.28, 70);
            
            [buttonImage sd_setBackgroundImageWithURL:[NSURL URLWithString:dataImage[i]] forState:UIControlStateNormal];
            
            buttonImage.layer.borderColor = [UIColor redColor].CGColor;
            buttonImage.layer.borderWidth = 2;
            buttonImage.layer.cornerRadius = 10;
            buttonImage.layer.masksToBounds = YES;
            
            [buttonImage addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            
            buttonImage.tag = i;
            
            [cell2.scrollView addSubview:buttonImage];
            
        }
        return cell2;
        
    }
    else
    {
        MovieContentCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        if (cell1 == nil) {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:@"MovieContentCell" owner:self options:nil]lastObject];
        }
    
        cell1.movieContent = _dataContentArray[indexPath.row- 2];
     
        return cell1;
    
    }
}

//行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row == 0)
  {
     return 150;
  }
   else if (indexPath.row == 1)
    {
        return 80;
    }
    else
    {
        
        MovieContent *mc = _dataContentArray[indexPath.row-2];
        
        if(mc.isShow )
        {
            CGSize size = CGSizeMake(kScreenWidth - 90, CGFLOAT_MAX);
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
            
            CGRect frame = [mc.content boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:attributes
                                                    context:nil];
            
            CGSize contentSize = frame.size;
            
            return contentSize.height + 60;
        }
        else
        {
            return 80;
        }
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //改变这条显示的状态
    MovieContent *movieContent = _dataContentArray[indexPath.row-2];
    
    movieContent.isShow = !movieContent.isShow;
    
    //刷新单元格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:
     UITableViewRowAnimationNone];
    
}

#pragma mark - scrollerView上按钮的方法
- (void)clickAction:(UIButton *)btn
{
   // MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"]];
    
   // [self.navigationController pushViewController:player animated:YES];
    
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
