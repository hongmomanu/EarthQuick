//
//  ViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-8.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSConfigData.h"
#import "LogininViewController.h"
#import "LoginoffViewController.h"
#import "EqimViewController.h"
#import "CollectViewController.h"
#import "FeelViewController.h"

@interface ViewController : UIViewController<LogininViewControllerDelegate,LoginoffViewControllerDelegate,EqimViewControllerDelegate,CollectViewControllerDelegate,FeelViewControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary *userDic;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) LogininViewController *logininViewController;
@property (strong,nonatomic) LoginoffViewController *loginoffViewController;
@property (strong,nonatomic) EqimViewController *eqimViewController;
@property (strong,nonatomic) CollectViewController *collectViewController;
@property (strong,nonatomic) FeelViewController *feelViewController;

- (IBAction)userBtnAct:(id)sender;
- (IBAction)rapidReportAct:(id)sender;
- (IBAction)collectAct:(id)sender;
- (IBAction)feelAct:(id)sender;

@end
