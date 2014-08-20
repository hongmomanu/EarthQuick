//
//  EqimListViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-14.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EqimTabCell.h"
#import "IBActionSheet.h"
#import "EqimSoap.h"
#import "MapUtil.h"

@class EqimListViewController;
@protocol EqimListViewControllerDelegate <NSObject>
-(void)eqimListViewControllerReturn:(EqimListViewController *)controller ;

-(void)eqimListViewControllerEnter:(EqimListViewController *)controller eqimData:(NSDictionary *) eqimData eqimType:(NSString *)type eqimDays:(NSString *)days;

-(void)eqimListViewControllerSelect:(EqimListViewController *)controller eqimData:(NSDictionary *) eqimData eqimType:(NSString *)type eqimDays:(NSString *)days selectCell:(NSDictionary *)select;
@end
@interface EqimListViewController : UIViewController<UITabBarDelegate,EqimSoapDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak,nonatomic) id <EqimListViewControllerDelegate> delegate;
@property (strong,nonatomic) EqimSoap *eqimSoap;

@property (nonatomic,strong) AGSGraphic *locationGrp;
@property (nonatomic, strong) NSDictionary *eqimData;
@property (nonatomic, strong) UIActionSheet *typeSheet;
@property (nonatomic, weak) NSString *type;
@property (nonatomic, weak) NSString *typeDis;
@property (nonatomic, strong) UIActionSheet *daysSheet;
@property (nonatomic, weak) NSString *days;
@property (nonatomic, strong) UIActionSheet *sortSheet;
@property (nonatomic, weak) NSString *sort;


@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UITabBarItem *typeBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *daysBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *sortBarItem;


@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

- (IBAction)returnMap:(id)sender;
- (IBAction)enterMap:(id)sender;


@end
