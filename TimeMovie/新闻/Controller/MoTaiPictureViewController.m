//
//  MoTaiPictureViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MoTaiPictureViewController.h"
#import "BigImageCell.h"

@interface MoTaiPictureViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dataArray;     //可变数组
    
    UIImageView *_image;            //创建图片视图
    
    UICollectionView *_imageCollectionView;   //创建UICollectionView
    
    NSNotificationCenter *_center;
    
    BOOL _isTouch;
}
@end

@implementation MoTaiPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏的标题
    self.title = @"图片浏览";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //读取数据
    //[self loadData];
    
    //调用
    [self creatView];
    
    //选中图片 显示其选中的图片
    [_imageCollectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
/*
    //调用block
    BigImageCell *big = [[BigImageCell alloc]init];
    
    [big setBlock:^(BOOL i)
     {
         //NSInteger i = [str integerValue];
         //隐藏导航栏
         [self.navigationController setNavigationBarHidden:i animated:YES];
         
         //隐藏状态栏
         
     }];
  */
    
    //获取通知中心
    _center = [NSNotificationCenter defaultCenter];
    
    //添加通知监听器
    [_center addObserver:self selector:@selector(selectionAction) name:@"oneTap" object:nil];
    
}

#pragma mark - 通知的方法
- (void)selectionAction
{
    _isTouch = !_isTouch;
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:_isTouch animated:YES];
    
    //隐藏状态栏
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:_isTouch];
}

#pragma mark - 移除通知
- (void)dealloc
{
    //移除通知
    [_center removeObserver:self];
}

#pragma mark - 创建UICollectionView
- (void)creatView
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLauout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置水平间隙
    flowLauout.minimumInteritemSpacing = 10;
    
    //设置单元格的大小
    flowLauout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight-64);
    
    //设置四周间隙
    flowLauout.sectionInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    
    //设置滑动方向
    flowLauout.scrollDirection = UICollectionViewScrollDirectionHorizontal;  //水平滑动
    
    //创建UICollectionView
    _imageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth+10, kScreenHeight-64) collectionViewLayout:flowLauout];
    
    //设置最大放大倍数
    _imageCollectionView.maximumZoomScale = 2;
    
    _imageCollectionView.backgroundColor = [UIColor blackColor];
    
    //设置代理
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    
    //是否分页
    _imageCollectionView.pagingEnabled = YES;
    
    //隐藏滑动条
    _imageCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_imageCollectionView];
    
    //注册单元格
    [_imageCollectionView registerClass:[BigImageCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return _imageData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    BigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blackColor];
    
    cell.urlImage = _imageData[indexPath.item];
    
    return cell;
}

/**
 *  当某个单元格 结束显示时调用的方法
 *
 *  @param collectionView
 *  @param cell           结束显示的单元格
 *  @param indexPath      索引路径
 */
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取单元格 强制类型转换
    BigImageCell *bigImageCell = (BigImageCell *)cell;
    
    // 将单元格中的图片缩放还原
    [bigImageCell backImageZoomingScale];
    
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
