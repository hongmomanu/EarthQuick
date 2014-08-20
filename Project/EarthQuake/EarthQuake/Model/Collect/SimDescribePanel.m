//
//  SimDescribePanel.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SimDescribePanel.h"

@implementation SimDescribePanel

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.margin = UIEdgeInsetsMake(40.0, 20.0, 80.0, 20.0);
			
        self.padding = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
			
        self.contentColor = [UIColor colorWithWhite:1.0 alpha:0.8] ;

        self.titleBarHeight = 0.0f;
        
        self.dataArr = [[NSMutableArray alloc] initWithObjects:@"无人员伤亡,无建筑物损坏。", @"少量人员轻伤,未出现重伤和死亡人员,建筑物轻微损坏。",
                          @"较多人员受轻伤,少量重伤,无死亡人员,建筑物损坏一般。", @"大量人员受伤,数十人重伤,有输人死亡,建筑物损坏严重。", @"人员伤亡严重,建筑物大量倒塌。", nil];
        
        self.tabView = [[UITableView alloc] init];
        self.tabView.dataSource = self;
        self.tabView.delegate = self;
        self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tabView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        
        self.tabView.frame = CGRectMake(10, 10, self.contentViewFrame.size.width -20, self.contentViewFrame.size.height - 20);
        
        [self.contentView addSubview:self.tabView];

    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArr count];
}

//绑定数据源
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SimDescribeCell";
    static BOOL nibsRegistered = NO;
    //if (!nibsRegistered) {
    UINib *nib = [UINib nibWithNibName:@"SimDescribeCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    nibsRegistered = YES;
    //}
    
    SimDescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.context = [self.dataArr objectAtIndex:indexPath.row];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   self.selectIndex = [self.dataArr objectAtIndex:indexPath.row];
    [self hide];
}

//委托解决行高问题
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
