//
//  CollectViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-12.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "esriView.h"
#import "PubViewController.h"
#import "PreViewController.h"
#import "MacListViewController.h"
#import "NSConfigData.h"

@class CollectViewController;
@protocol CollectViewControllerDelegate <NSObject>
-(void)CollectViewControllerReturn:(CollectViewController *)controller ;

@end

@interface CollectViewController : UIViewController
<PubViewControllerDelegate,PreViewControllerDelegate,MacListViewControllerDelegate,UITabBarDelegate,esriViewDelegate>

@property (weak,nonatomic) id <CollectViewControllerDelegate> delegate;
@property (strong,nonatomic)  esriView *esriView;
@property (strong,nonatomic)  NSConfigData *configData;
@property (weak,nonatomic)  PubViewController *pubViewController;
@property (weak,nonatomic)  PreViewController *preViewController;
@property (weak,nonatomic)  MacListViewController *macListViewController;

@property (weak, nonatomic) IBOutlet UIView *conView;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabItemBar;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
- (IBAction)returnToHome:(id)sender;
@end
