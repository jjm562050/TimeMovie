//
//  PictureNewsViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/23.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PictureNewsViewController.h"
#import "MoTaiPictureViewController.h"

@interface PictureNewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UILabel *_titleLabel;
    UICollectionView *_collection;
    NSMutableArray *_dataArray;
    
}
@end

@implementation PictureNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题
    self.title = @"图片新闻";
    
    //调用UICollectionView
    [self createCollection];
    
    //调用读取数据
    [self loadData];
    
}

#pragma mark - 读取数据
- (void)loadData
{
    //获取数据
    NSArray *data = [BaseJSON readJSONPath:@"image_list"];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in data) {
        
        NSString *pictureNewsImagePath = dic[@"image"];
        //NSURL *url = [NSURL URLWithString:pictureNewsImagePath];
        
        [_dataArray addObject:pictureNewsImagePath];
    }
}


#pragma mark - 创建UICollectionView
- (void)createCollection
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝常用属性＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    //设置水平最小间隙
    flowLayout.minimumLineSpacing = 10;
    
    //设置竖直最小间隙
    flowLayout.minimumInteritemSpacing = 5;
    
    //单元格的大小
    CGFloat item = (kScreenWidth - 10*5) / 4;
    flowLayout.itemSize = CGSizeMake(item, item);
    
    //设置滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置四周间隙
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //使用布局对象 创建UICollectionView
    _collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    //_collection.backgroundColor = [UIColor whiteColor];
    
    //设置代理
    _collection.dataSource = self;
    _collection.delegate = self;
    
    //使用单元格 注册UICollectionView
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collection];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor redColor];
    
    UIImageView *pictureNews = [[UIImageView alloc]init];
    
    //从网上获取图片
    NSURL *url = [NSURL URLWithString:_dataArray[indexPath.row]];
    [pictureNews sd_setImageWithURL:url];
    cell.backgroundView = pictureNews;
    
    //设置单元格的边框
    cell.layer.borderColor = [UIColor purpleColor].CGColor;
    cell.layer.borderWidth = 2;
    cell.layer.cornerRadius = cell.width / 2;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoTaiPictureViewController *mtp = [[MoTaiPictureViewController alloc]init];
    
    //在显示下一个视图时，隐藏标签栏
    //只能对系统的标签栏使用
    mtp.hidesBottomBarWhenPushed = YES;
    
    //  _dataArray网络地址
    mtp.imageData = _dataArray;

    //纪录选中的索引
    mtp.indexPath = indexPath;
  
    [self.navigationController pushViewController:mtp animated:YES];
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
