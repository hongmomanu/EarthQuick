//
//  SubDetailsViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-30.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryParams.h"
#import "SubDetailsCell.h"
#import "ActionSheetPicker.h"
#import "CzRuning.h"
#import "QzRuning.h"

@class SubDetailsViewController;
@protocol SubDetailsViewControllerDelegate <NSObject>
//反悔协议
-(void)subDetailsViewControllerReturn:(SubDetailsViewController *)controller ;

@end

@interface SubDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak,nonatomic) id <SubDetailsViewControllerDelegate> delegate;
@property (strong,nonatomic) QueryParams *queryParams;  //图层查询设置参数类
@property (weak, nonatomic) AGSGraphic *agsGraphic; //需要展示的要素
@property (weak,nonatomic) SubDetailsCell *subDetailsCell;

@property (weak, nonatomic)  CzRuning *czRuning;
@property (weak, nonatomic)  QzRuning *qzRuning;
@property (weak, nonatomic) IBOutlet UIView *runView;
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;

- (IBAction)returnMap:(id)sender;
@end
