//
//  PubIntensityPanel.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-15.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "PubIntensityPanel.h"

@implementation PubIntensityPanel

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.margin = UIEdgeInsetsMake(40.0, 20.0, 80.0, 20.0);
        
        self.padding = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        
        self.contentColor = [UIColor colorWithWhite:1.0 alpha:0.8] ;
        
        self.titleBarHeight = 0.0f;
        
        NSMutableArray *I1 = [[NSMutableArray alloc] initWithObjects:@"Ⅰ", @"无感",@"无", @"无", nil];
        NSMutableArray *I2 = [[NSMutableArray alloc] initWithObjects:@"Ⅱ", @"室内个别静止中的人有感觉",@"无", @"无", nil];
        NSMutableArray *I3 = [[NSMutableArray alloc] initWithObjects:@"Ⅲ", @"室内少数静止中的人有感觉",@"门、窗轻微作响", @"悬挂物微动", nil];
        NSMutableArray *I4 = [[NSMutableArray alloc] initWithObjects:@"Ⅳ", @"室内多少人有感觉,室外少数人有感觉,少数人梦中惊醒",@"门、窗作响", @"不稳定器物翻倒", nil];
        NSMutableArray *I5 = [[NSMutableArray alloc] initWithObjects:@"Ⅴ", @"室内普遍有感觉,室外多数人有感觉,多数人梦中惊醒",@"门客、屋顶、屋架颤动作响，灰土掉落，抹灰出现微细裂缝", @"无", nil];
        NSMutableArray *I6 = [[NSMutableArray alloc] initWithObjects:@"Ⅵ", @"惊慌失措，仓惶逃出",@"损坏--个别砖瓦掉落、墙体微细裂缝", @"河岸和松软土上出现裂缝,饱和砂层出现喷砂冒水。地面上有的砖烟囱轻度裂缝、掉头", nil];
        NSMutableArray *I7 = [[NSMutableArray alloc] initWithObjects:@"Ⅶ", @"大多数人仓惶逃出",@"轻度破坏--局部破坏、开裂，但不妨碍使用", @"河岸出现坍方。饱和砂层常见喷砂冒水。松软土上地裂缝较多。大多数砖烟囱中等破坏", nil];
        NSMutableArray *I8 = [[NSMutableArray alloc] initWithObjects:@"Ⅷ", @"摇晃颠簸，行走困难",@"中等破坏--结构受损，需要修理", @"干硬土上亦有裂缝。大多数砖烟囱严重破坏", nil];
        NSMutableArray *I9 = [[NSMutableArray alloc] initWithObjects:@"Ⅸ", @"干硬土上亦有裂缝,大多数砖烟囱严重破坏",@"严重破坏--墙体龟裂，局部倒塌，复修困难", @"干硬土上有许多地方出现裂缝，基岩上可能出现裂缝。滑坡、坍方常见。砖烟囱出现倒塌", nil];
        NSMutableArray *I10 = [[NSMutableArray alloc] initWithObjects:@"Ⅹ", @"骑自行车的人会摔倒,处于不稳状态的人会掉出几尺远,有抛起感",@"倒塌--大部倒塌，不堪修复", @"山崩和地震断裂出现。基岩上的拱桥破坏。大多数砖烟囱从根部破坏或倒毁", nil];
        NSMutableArray *I11 = [[NSMutableArray alloc] initWithObjects:@"Ⅺ", @"无",@"毁灭", @"地震断裂延续很长。山崩常见。基岩上拱桥毁坏", nil];
        NSMutableArray *I12 = [[NSMutableArray alloc] initWithObjects:@"Ⅻ", @"无",@"无", @"地面剧烈变化，山河改观", nil];
        
        self.dataArr = [NSMutableArray arrayWithObjects:I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12, nil];
        
        self.keyArr = [[NSMutableArray alloc] initWithObjects:@"烈    度", @"人的感觉",
                       @"建筑损坏", @"其他现象", nil];
        
        self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.contentViewFrame.size.width -20, self.contentViewFrame.size.height - 20) style:UITableViewStyleGrouped];
        self.tabView.dataSource = self;
        self.tabView.delegate = self;
        self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        self.tabView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        
        [self.contentView addSubview:self.tabView];
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataArr objectAtIndex:section] count];
}

// 分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
}

//绑定数据源
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"IntensityCell";

    UINib *nib = [UINib nibWithNibName:@"IntensityCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];

    
    self.intCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [self.intCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    self.intCell.key = [self.keyArr objectAtIndex:indexPath.row];
    
    self.intCell.value = [[self.dataArr objectAtIndex:indexPath.section]  objectAtIndex:indexPath.row];
    
    return self.intCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = [[self.dataArr objectAtIndex:indexPath.section]  objectAtIndex:0];
    [self hide];
}

//委托解决行高问题
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"IntensityCell";
    static BOOL nibsRegistered = NO;
    //if (!nibsRegistered) {
    UINib *nib = [UINib nibWithNibName:@"IntensityCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    nibsRegistered = YES;
    //}
    
    self.intCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CGSize size = CGSizeMake(self.intCell.valueLab.frame.size.width, 9999);
    
    CGSize labelsize = [[[self.dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];

    return labelsize.height +10;

}


@end
