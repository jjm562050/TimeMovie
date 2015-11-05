//
//  MovieViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "MovieCell.h"
#import "BaseJSON.h"
#import "PostCollectionView.h"
#import "HeaderCollectionView.h"

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_selectButton;       //右上角的选中按钮
    
    //创建中间视图
    UITableView *_listTableView;   //列表视图
    UIView *_posterView;           //海报视图
    
    //数据存储数组
    NSMutableArray *_movieData;    //存储数据的可变数组
    
    //创建头视图
    UIView *_topView;              //创建头视图
    
    UIImageView *_topImage;        //创建头视图的图片视图
    
    UIButton *_topButton;          //头视图的按钮
    
    UIView *_maskView;             //创建遮盖视图
    
    PostCollectionView *_postCollectionView;  //子类化
    
    HeaderCollectionView *_headerCollectionView;
    
}
@end

@implementation MovieViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark - 设置导航栏的标题
    //设置导航栏的标题
    self.title = @"北美榜";
    
    //调用创建右上角的选中按钮
    [self _creatSelectButton];
    
    //调用数据读取
    [self loadData];

    //调用中间视图
    [self _creatView];
    
    //创建头视图
    [self createTopView];
    
    //Kvo
    [self createKvo];
    
}

#pragma makr - 数据读取
- (void)loadData
{
    
    NSDictionary *dic = [BaseJSON readJSONPath:@"us_box"];
    
    //4.数据的处理和存储
    NSArray *subjects = dic[@"subjects"];
    
    _movieData = [[NSMutableArray alloc]init];
    
    //for循环遍历
    for(NSDictionary *dictionary in subjects)
    {
        Movie *movie = [Movie movieWithContentsOfDictionary:dictionary[@"subject"]];
        
        [_movieData addObject:movie];
    }
}

#pragma mark - 创建右上角的选中按钮
- (void)_creatSelectButton
{
    //创建按钮
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //设置按钮的位置
    _selectButton.frame = CGRectMake(0, 0, 49, 25);
    
    //设置按钮的图片
    [_selectButton setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateSelected];    
    
    //按钮的方法
    [_selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //转换成UIBarButtonItem
    UIBarButtonItem *rightSelect = [[UIBarButtonItem alloc]initWithCustomView:_selectButton];
    
    //加入到导航栏中
    self.navigationItem.rightBarButtonItem = rightSelect;
    
}

#pragma mark - 创建中间视图
- (void)_creatView
{
    //1.创建列表视图
    _listTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    
    //设置代理
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    
    _listTableView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_listTableView];
    
    //2.创建海报视图
    _posterView = [[UIView alloc]initWithFrame:self.view.bounds];
    _posterView.backgroundColor = [UIColor greenColor];
    
    //隐藏posterView
    _posterView.hidden = YES;
    
    _postCollectionView = [[PostCollectionView alloc]initWithFrame:_posterView.bounds];
    
    // 将电影的数据 传给_postCollectionView
    
    _postCollectionView.dataPost = _movieData;
    
    [_posterView addSubview:_postCollectionView];
    
    [self.view addSubview:_posterView];
}

#pragma mark - 创建头视图
- (void)createTopView
{
    //创建遮盖视图
    _maskView = [[UIView alloc]initWithFrame:_posterView.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    //隐藏_maskView
    _maskView.hidden = YES;
    
    [_posterView addSubview:_maskView];
    
    //创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topViewMoveUp)];
    
    [_maskView addGestureRecognizer:tap];
    
    //创建滑动手势 下
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(topViewMoveDown)];
   
    //设置滑动方向
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [_posterView addGestureRecognizer:swipeDown];
    
    //创建滑动手势 上
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(topViewMoveUp)];
    
    //设置滑动方向
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    [_maskView addGestureRecognizer:swipeUp];
    
    
    
    //创建头视图
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, -36, kScreenWidth, 130)];
    _topView.backgroundColor = [UIColor clearColor];
    [_posterView   addSubview:_topView];
    
    //创建头视图的图片视图
    _topImage = [[UIImageView alloc]initWithFrame:_topView.bounds];
    
    //拉伸图片
    UIImage *image = [UIImage imageNamed:@"indexBG_home"];
   image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:5];
    _topImage.image = image;
    [_topView addSubview:_topImage];
    
    //头视图的下拉按钮
    _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _topButton.frame = CGRectMake(0, 0, 26, 20);
    //设置中心点
    _topButton.center = CGPointMake(kScreenWidth / 2 + 3, 120);
    
    [_topButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [_topButton setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    
    [_topButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topView addSubview:_topButton];
    
    //头视图图片
    _headerCollectionView = [[HeaderCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _topView.size.height-20)];
    
    //将电影的数据 传递给_headerCollectionView
    
    _headerCollectionView.dataHeader = _movieData;
    
    [_topView addSubview:_headerCollectionView];
    
}

#pragma makr - 设置 TableViewDataSource 的必须方法
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _movieData.count;
}

//单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //static NSString *idenitifer = @"MovieCell";
    // 从闲置池中获取cell
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MovieCell" owner:nil options:nil]lastObject];
    }
    
    // 将这个单元格所对应的电影对象 设置给单元格
    // 将一个电影对象 交给单元格去显示
    cell.movie = _movieData[indexPath.row];
    
    return cell;
}

//设置行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma mark - 设置 右上角的选中按钮 和 中间视图 的翻转
- (void)selectAction:(UIButton *)btn
{
    //设置翻转的方向
    UIViewAnimationOptions option = btn.selected ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    
    //1.按钮的翻转动画
    [self filpViewWithView:_selectButton options:option];
    
    //2.中间视图
    [self filpViewWithView:self.view options:option];
    
    //设置状态
    _selectButton.selected = ! _selectButton.selected;
    _listTableView.hidden = !_listTableView.hidden;
    _posterView.hidden = !_posterView.hidden;
    
}

/**
 *  将某个视图进行翻转
 *
 *  @param view    需要进行翻转动画的视图
 *  @param options 动画的选项
 */
#pragma mark - 翻转视图的方法
- (void)filpViewWithView:(UIView *)view options:(UIViewAnimationOptions)option
{
    //设置翻转
    [UIView transitionWithView:view
                      duration:0.35
                       options:option
                    animations:^{
                        
                    }
                    completion:nil];
}

#pragma mark - 头视图按钮的方法
- (void)topButtonAction:(UIButton *)btn
{
    NSLog(@"%d",btn.selected);
    
    if(btn.selected)
    {
        [self topViewMoveUp];
    }
    else
    {
        [self topViewMoveDown];
    }
}

#pragma mark - 头视图隐藏 与 显示 的方法
//隐藏
- (void)topViewMoveUp
{
    [UIView animateWithDuration:0.4 animations:^{
       
        _topView.top = -36;
        _maskView.hidden = YES;
        _topButton.selected = NO;
    }];
    
}

//显示
- (void)topViewMoveDown
{
    [UIView animateWithDuration:0.4 animations:^{
        
        _topView.top = 64;
        _maskView.hidden = NO;
        _topButton.selected = YES;
    }];
}


#pragma mark - KVO
- (void)createKvo
{
    //创建KVO
    [_postCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
    [_headerCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
}

//移除kvo
-(void)dealloc
{
    [_headerCollectionView removeObserver:self forKeyPath:@"index"];
    [_postCollectionView removeObserver:self forKeyPath:@"index"];
}

//观察者方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //NSLog(@"%@",change);
    //获取变化后的index 值
    NSNumber *indexNumber = change[@"new"];
    
    NSInteger index = [indexNumber integerValue];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    //判断监听对象
    if(object == _postCollectionView && _headerCollectionView.index != indexPath.item)
    {
        [_headerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _headerCollectionView.index = indexPath.item;
    }
    else if(object == _headerCollectionView && _postCollectionView.index != indexPath.item)
    {
        [_postCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _postCollectionView.index = indexPath.item;
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
