//
//  WZGuideViewController.m
//  WZGuideViewController
//
//  Created by Wei on 13-3-11.
//  Copyright (c) 2013年 ZhuoYun. All rights reserved.
//

#import "WZGuideViewController.h"
#import "ViewController.h"
// 设置图片数量（首次加载然后添加的图片）
#define kCount 4
@interface WZGuideViewController ()
{
    UIPageControl *_pageControl;
    UIButton *_share;
}
@end

@implementation WZGuideViewController
-(void)loadView
{
    UIImageView *imageView =[[UIImageView alloc] init];
    imageView.frame=[UIScreen mainScreen].bounds;
    //    imageView.image=[UIImage fullscreenImageWithName:@"new_feature_background.png"];
    imageView.userInteractionEnabled=YES; // 检测自己能不能用交互
    self.view=imageView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rx = [ UIScreen mainScreen ].bounds;
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=self.view.bounds;
    scrollView.contentSize=CGSizeMake(rx.size.width*3, rx.size.height);
    scrollView.showsHorizontalScrollIndicator=NO; // 设置是不是要下面的条
    scrollView.pagingEnabled=YES; // 是否分页
    scrollView.delegate=self;
   [self.view addSubview:scrollView];
    
    UIImageView *leftiamge = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rx.size.width,rx.size.height)];
    leftiamge.image = [UIImage imageNamed:@"1.png"];
    [scrollView addSubview:leftiamge];
    
    UIImageView *amongiamge = [[UIImageView alloc]initWithFrame:CGRectMake(rx.size.width, 0, rx.size.width, rx.size.height)];
    amongiamge.image = [UIImage imageNamed:@"2.png"];
    [scrollView addSubview:amongiamge];
    
    UIImageView *ringthiamge = [[UIImageView alloc]initWithFrame:CGRectMake(rx.size.width * 2, 0, rx.size.width, rx.size.height)];
    ringthiamge.image = [UIImage imageNamed:@"3.png"];
    [scrollView addSubview:ringthiamge];
    
    UIButton *BTN = [[UIButton alloc]initWithFrame:CGRectMake(rx.size.width * 2, 0, rx.size.width, rx.size.height)];
  
    
    BTN.backgroundColor = [UIColor clearColor];
    
    [BTN addTarget:self action:@selector(BTNmain) forControlEvents:UIControlEventTouchUpInside];
    
      [scrollView addSubview:BTN];


}
//    // 销毁新特性控制器，然后转向新的界面
//    // 跳到主界面-MainViewControl
//    MainViewController *main=[[MainViewController alloc] init];
//
//    // 跳转,切换窗口的根控制器（自动销毁新特性控制器）
//    self.view.window.rootViewController=main;
//   // [self presentViewController:main animated:YES completion:nil];

-(void)BTNmain
{
    NSLog(@" 按钮触发事件");
    if (_startBlock) {
        _startBlock(_share.isSelected);
    }
    
    
//      //销毁新特性控制器，然后转向新的界面
//     // 跳到主界面-MainViewControl
//       ViewController *main=[[ViewController alloc] init];
//    
//   // 跳转,切换窗口的根控制器（自动销毁新特性控制器）
//    self.view.window.rootViewController=main;
//   [self presentViewController:main animated:YES completion:nil];
}


@end
