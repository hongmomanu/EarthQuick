//
//  SubjectViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-28.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//  用户定制界面
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
#import "QueryParams.h"
#import "StationSoap.h"
#import "EGORefreshTableHeaderView.h"
@class SubjectViewController;
@protocol SubjectViewControllerDelegate <NSObject>
//返回
-(void)subjectViewControllerReturn:(SubjectViewController *)controller ;
//查看地图
-(void)subjectViewControllerEnter:(SubjectViewController *)controller subData:(AGSFeatureSet *) subData queryParams:(QueryParams *)queryParams;
//选中数据
-(void)subjectViewControllerSelect:(SubjectViewController *)controller subData:(AGSFeatureSet *) subData queryParams:(QueryParams *)queryParams selectCell:(AGSGraphic *)select;
@end

@interface SubjectViewController : UIViewController
<AGSQueryTaskDelegate,
EGORefreshTableHeaderDelegate,
UITableViewDataSource,
UITableViewDelegate,
StationSoapDelegate>


@property (weak,nonatomic) id <SubjectViewControllerDelegate> delegate;
@property (strong,nonatomic) QueryParams *queryParams;  //图层详细查询参数类
@property (strong,nonatomic) StationSoap *stationSoap;  //台站获取服务
@property (strong,nonatomic) AGSQueryTask *queryTask;   //ArcGis 获取
@property (strong,nonatomic) AGSQuery *query;           //ArcGis 查询
@property (strong,nonatomic) AGSFeatureSet *featureSet; //要素集
@property (strong,nonatomic) NSString *t_imagePath;     //要素图标
@property (strong,nonatomic) AGSGraphic *locationGrp;   //避难场所需要使用定位要素

@property (strong,nonatomic) EGORefreshTableHeaderView *tableHeaderView;    //TableView 下拉刷新
@property (assign,nonatomic) BOOL reloading;                               //是否刷新
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomSrcView;
- (IBAction)returnToMap:(id)sender;
- (IBAction)enterToMap:(id)sender;
- (IBAction)segChanged:(id)sender;


@end
