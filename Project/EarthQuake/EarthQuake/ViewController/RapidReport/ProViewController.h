//
//  ProViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-21.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Province.h"

@class ProViewController;
@protocol ProViewControllerDelegate <NSObject>
//返回协议
-(void)proViewControllerReturn:(ProViewController *)controller ;
//选中协议
-(void)proViewControllerSave:(ProViewController *)controller selectData:(NSString *) selectData;
@end

@interface ProViewController : UIViewController
@property (weak,nonatomic) id <ProViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *proSelData; //选中的名称数据组
@property (strong, nonatomic) NSString *proSelStr; //选中的名称

@property (strong,nonatomic) NSMutableArray *sectionTitles; // 每个分区的标题
@property (strong,nonatomic) NSMutableArray *contentsArray; // 每行的内容
@property (strong,nonatomic) NSMutableArray * selectionArr; // 整个table的选中状态


@property (weak, nonatomic) IBOutlet UITableView *proTable;
- (IBAction)saveBarAct:(id)sender;

- (IBAction)returnBarAct:(id)sender;

@end
