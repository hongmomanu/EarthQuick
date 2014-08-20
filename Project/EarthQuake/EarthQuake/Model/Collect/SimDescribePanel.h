//
//  SimDescribePanel.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "UATitledModalPanel.h"
#import "SimDescribeCell.h"

@interface SimDescribePanel : UATitledModalPanel<UITableViewDataSource>

@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)NSString *selectIndex;
@property (strong, nonatomic) UITableView *tabView;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@end
