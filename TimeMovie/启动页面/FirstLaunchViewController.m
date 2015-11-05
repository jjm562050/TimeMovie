//
//  FirstLaunchViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/31.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "FirstLaunchViewController.h"
#import "MoreViewController.h"

@interface FirstLaunchViewController ()
{
    UIScrollView *_startImageScrollView;   //创建scrollView
    
    NSArray *_guideImages;                 //存储guideImages
    
    NSArray *_guideProgressImage;          //存储guideProgressImage
    
    UIImageView *_guideImageView;          //创建guideImageView
}

@end

@implementation FirstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _guideImages = @[@"guide1@2x",@"guide2@2x",@"guide3@2x",@"guide4@2x",@"guide5@2x"];
    
    _guideProgressImage = @[@"guideProgress1@2x",@"guideProgress2@2x",@"guideProgress3@2x",@"guideProgress4@2x",@"guideProgress5@2x"];
    
    //创建ScrollView
    
    _startImageScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    //设置scrollView的尺寸
    _startImageScrollView.contentSize = CGSizeMake(kScreenWidth * _guideImages.count, kScreenHeight);
    
    //是否分页
    _startImageScrollView.pagingEnabled = YES;
    
    //ScrollView 的颜色
    _startImageScrollView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_startImageScrollView];
    
    [self createStart];
    
}

#pragma mark - 第一次启动画面
- (void)createStart
{
    for (int i = 0;i<_guideImages.count;i++)
    {
        _guideImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        
        _guideImageView.image = [UIImage imageNamed:_guideImages[i]];
        
        //开启图片视图的点击事件
        _guideImageView.userInteractionEnabled = YES;
        
        _guideImageView.tag = i;
        
        UIImageView *guideProgressImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 173) / 2 , kScreenHeight *0.93, 173, 26)];
        
        guideProgressImageView.image = [UIImage imageNamed:_guideProgressImage[i]];
        
        for (int j = 0;j<_guideImages.count;j++)
        {
            UIImageView *image = (UIImageView *)[_guideImageView viewWithTag:j];
            
            [image addSubview:guideProgressImageView];
        }
        
        [_startImageScrollView addSubview:_guideImageView];
        
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake((kScreenWidth - 150) / 2, kScreenHeight * 0.8, 150, 40);
    
    [button setTitle:@"进入电影世界" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *image = (UIImageView *)[_guideImageView viewWithTag:4];
    
    [image addSubview:button];
    
}

#pragma mark - 按钮的方法
- (void)clickAction
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    self.view.window.rootViewController = vc;
    
    //界面显示动画
    vc.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:0.3 animations:^{
        //恢复本身
        vc.view.transform = CGAffineTransformIdentity;
    }];
    
    // 第一次运行完成后 执行以下代码
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@YES forKey:@"first"];
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
