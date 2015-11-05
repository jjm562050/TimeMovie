//
//  BaseViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarController.h"

@interface BaseViewController ()
{
    UILabel *_titleLabel;
    
    BOOL _isHiddenBar;  // 此界面 是否要隐藏标签栏
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark - 设置导航栏的标题
    //自定义导航栏的标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:23 weight:0.5];
    _titleLabel.text = self.title;
    
    //将titleLabel 加到导航栏上
    self.navigationItem.titleView = _titleLabel;
    
    //设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
}

-(void)setTitle:(NSString *)title{
    //需要使用父类中的setTitle方法来修改_title
    //调用父类的title
    [super setTitle:title];
    
    _titleLabel.text = title;
    
}

#pragma mark - 标签栏的隐藏和显示控制
-(void)viewWillAppear:(BOOL)animated
{
    if(_isHiddenBar )
    {
        //隐藏标签栏
        BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
        [tab setTabBarHidden:YES];
    }
    else
    {
        //显示标签栏
        BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
        [tab setTabBarHidden:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    //显示标签栏
    BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
    [tab setTabBarHidden:NO];
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    _isHiddenBar = hidesBottomBarWhenPushed;
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
