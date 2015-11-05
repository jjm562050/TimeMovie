//
//  LaunchViewController.m
//  TimeMovie
//
//  Created by MAC22 on 15/8/31.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [NSTimer scheduledTimerWithTimeInterval:.25 target:self selector:@selector(showImageView:) userInfo:nil repeats:YES];
    
}

#pragma mark - 状态栏的显示 与 隐藏
//隐藏
- (void)viewWillAppear:(BOOL)animated
{
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
}

//显示
-(void)viewDidDisappear:(BOOL)animated
{
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO];
}

#pragma mark  － 显示启动画面
- (void)showImageView:(NSTimer *)timer
{
    static NSInteger i = 1;
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i];
    
    // 显示这个ImageView
    imageView.hidden = NO;
    i++;
    
    if(i == 25)
    {
        //停止定时器
        [timer invalidate];
 
        //延迟调用jumpToMainViewController
       [ self performSelector:@selector(jumpToMainViewController) withObject:nil afterDelay:0.5];
    }
    
}

#pragma mark - 跳转到主界面
- (void)jumpToMainViewController
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
