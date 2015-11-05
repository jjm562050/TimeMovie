//
//  TopViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "TopViewController.h"
#import "Top.h"
#import "TopCell.h"
#import "MovieContentViewController.h"

@interface TopViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dataArray;
}
@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark - 设置导航栏的标题    
    //设置导航栏的标题
    self.title = @"Top250";
   
    //读取数据
    [self loadData];

}


#pragma mark - 读取数据
- (void)loadData
{
    NSDictionary *dic = [BaseJSON readJSONPath:@"top250"];
    
    //数据的存储和处理
    NSArray *subjects = dic[@"subjects"];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    for(NSDictionary *dic in subjects)
    {
        Top *top = [[Top alloc]initWithContentsOfDictionary:dic];
        
        [_dataArray addObject:top];
    }
    
    //NSLog(@"%@",_dataArray);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
   TopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
    cell.top = _dataArray[indexPath.item];
    
    //创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(tap:)];
    
    //点击次数
    tap.numberOfTapsRequired = 2;
    
    //点击所需的手指数
    tap.numberOfTouchesRequired = 1;
    
    [cell addGestureRecognizer:tap];
    
    return cell;
}

#pragma mark - 手势的方法
-(void)tap:(UITapGestureRecognizer *)tap
{
    MovieContentViewController *movieContent = [[MovieContentViewController alloc]init];
    
    movieContent.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:movieContent animated:YES];
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
