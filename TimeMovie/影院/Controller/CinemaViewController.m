//
//  CinemaViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "CinemaViewController.h"
#import "Cinema.h"
#import "District.h"
#import "CinemaCell.h"

@interface CinemaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataDistrictArray;     //创建存储地区数组
    
   // NSMutableArray *_dataCinemaArray;       //创建存储影院数组
    
    
    UITableView *_cinemaTableView;       //创建tableView
}
@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark - 设置导航栏的标题    
    //设置导航栏的标题
    self.title = @"影院";
    
    //读取数据
    [self loadData];
    
    //创建tableView
    [self createTableView];
   
    NSLog(@"%@",_dataDistrictArray);
   
}

#pragma mark - 读取数据
- (void)loadData
{
    //地区数据
    NSDictionary *districtDic = [BaseJSON readJSONPath:@"district_list"];
    
    NSArray *districtArray = districtDic[@"districtList"];
    
    _dataDistrictArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in districtArray)
    {
        District *district = [[District alloc]initContentWithDic:dic];
        
        [_dataDistrictArray addObject:district];
    }
    
    //电影院数据
    NSDictionary *cinemaDic = [BaseJSON readJSONPath:@"cinema_list"];
    
    NSArray *cinemaArray = cinemaDic[@"cinemaList"];
    
    //_dataCinemaArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in cinemaArray)
    {
        Cinema *cinema = [[Cinema alloc]initContentWithDic:dic];
        
        //[_dataCinemaArray addObject:cinema];
        
        for (District *district in _dataDistrictArray)
        {
            //比较地区id 和 电影院id 否一样
            if([district.districtID isEqualToString:cinema.districtId])
            {
                [district.cinemas addObject:cinema];
                
                break;
            }
        }
    }
    
}


#pragma mark - 创建tableView
- (void)createTableView
{
    _cinemaTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _cinemaTableView.backgroundColor = [UIColor blackColor];
    
    //设置代理
    _cinemaTableView.dataSource = self;
    _cinemaTableView.delegate = self;
    
    //是否隐藏滑动条
    _cinemaTableView.showsVerticalScrollIndicator = YES;
    _cinemaTableView.showsHorizontalScrollIndicator = YES;
    
    // NSLog(@"%ld",_dataDistrictArray.count);
    
    [self.view addSubview:_cinemaTableView];
    
}

#pragma mark - UITableViewDataSource
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //地区数
    return _dataDistrictArray.count;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    District *district = _dataDistrictArray[section];
    
    if(district.isShow)
    {
        return district.cinemas.count;
    }
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CinemaCell" owner:self options:nil]lastObject];
    }
    
    District *dis = _dataDistrictArray[indexPath.section];
    
    Cinema *cinema = dis.cinemas[indexPath.row];
    
    cell.cinema = cinema;
    
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//自定义组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *sectionBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    sectionBtn.frame = CGRectMake(0, 0, kScreenWidth, 40);
    
    [sectionBtn setBackgroundImage:[UIImage imageNamed:@"hotMovieBottomImage@2x"] forState:UIControlStateNormal];
    
    District *district = _dataDistrictArray[section];
    
    [sectionBtn setTitle:[NSString stringWithFormat:@"%@",district.name] forState:UIControlStateNormal];
    
    [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [sectionBtn addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    sectionBtn.tag = section;
    
    return sectionBtn;
}

//组高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - 组头视图的方法
- (void)sectionAction:(UIButton *)btn
{
    NSInteger section = btn.tag;
    
    //改变隐藏属性
    District *dis = _dataDistrictArray[section];
    dis.isShow = ! dis.isShow;
    
    //刷新组
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [_cinemaTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
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
