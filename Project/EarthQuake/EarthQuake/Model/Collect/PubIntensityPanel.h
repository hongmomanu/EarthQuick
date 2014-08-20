//
//  PubIntensityPanel.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-15.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "UATitledModalPanel.h"
#import "SimDescribeCell.h"
#import "IntensityCell.h"
#import "Intensity.h"

@interface PubIntensityPanel : UATitledModalPanel<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)NSMutableArray *keyArr;
@property (strong,nonatomic)NSMutableArray *dataArr;
@property (strong,nonatomic)NSString *selectIndex;
@property (strong, nonatomic) UITableView *tabView;
@property (strong ,nonatomic) IntensityCell *intCell;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@end
