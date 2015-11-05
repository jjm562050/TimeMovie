//
//  BaseTabBarController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TabBarButton.h"



@interface BaseTabBarController ()
{
    UIView *_newTabBar;          //标签栏按钮的视图
    UIImageView *_selestedImage; //选中按钮的图片视图
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //自定义标签栏
    [self _creatTabBar];
    
}

#pragma mark - 隐藏
- (void)setTabBarHidden:(BOOL)isHidden
{
    _newTabBar.hidden = isHidden;
}

#pragma mark - 创建自定义标签栏控制器
- (void)_creatTabBar
{
    //1.隐藏系统自带的标签栏
    self.tabBar.hidden = YES;
    
    //2.自定义标签栏
    //创建标签栏的视图
    _newTabBar = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    
    //设置标签栏的背景图片
    _newTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all"]];
    
    //创建tabbar上的按钮
    //1.计算按钮的位置
    CGFloat buttonFrameWidth = kScreenWidth / self.viewControllers.count;
    
    //创建title 的数组
    NSArray *tabBarTitleArray = @[@"电影",@"新闻",@"Top250",@"影院",@"更多"];
    
    //创建imageName 的数组
    NSArray *imageNameArray = @[@"movie_home",@"msg_new",@"start_top250",@"icon_cinema",@"more_setting"];
    
      //创建选中图片视图
    _selestedImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, buttonFrameWidth, 49)];
    _selestedImage.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    //_selestedImage.contentMode = UIViewContentModeScaleAspectFit;
    [_newTabBar addSubview:_selestedImage];
    
    //循环创建
    for (int i =0; i<self.viewControllers.count;i++)
    {
        //创建一个子类化的按钮
        TabBarButton *button = [[TabBarButton alloc]initWithTitle:tabBarTitleArray[i] imageName:imageNameArray[i] frame:CGRectMake(i * buttonFrameWidth, 0, buttonFrameWidth, 49)];
        
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置button 的tag
        button.tag = i;
        
        //将这个按钮添加到标签栏上去
        [_newTabBar addSubview:button];
    }
    
    [self.view addSubview:_newTabBar];
    
}

#pragma mark - 创建标签栏选中图片视图的方法
- (void)clickAction:(TabBarButton *)btn
{
    NSInteger index = btn.tag;
    
    //切换到对应的控制器
    self.selectedIndex = index;
    
    //选中能够移动
    //CGRect frame = CGRectMake(index * btn.frame.size.width, 0, btn.frame.size.width, 49);
    
    //调用动画
    [UIView animateWithDuration:.3 animations:^{
        //_selestedImage.frame = frame;
        _selestedImage.center = btn.center;
    }];
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
