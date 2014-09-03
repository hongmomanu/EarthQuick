//
//  ProViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-21.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "ProViewController.h"

@interface ProViewController ()<UITableViewDataSource,UITableViewDelegate>
{
}

@end



@implementation ProViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.proTable.delegate = self;
    self.proTable.dataSource = self;
    [self readySource];
}


- (void)readySource
{
    
    self.sectionTitles       = [[NSMutableArray alloc] initWithObjects:
                           @"A",@"B",@"F",@"G",@"H",@"J",@"L",@"N",@"Q",@"S",@"T",@"X",@"Y",@"Z", nil];
    self.contentsArray       = [[NSMutableArray alloc] initWithObjects:
                           @[@"安徽",@"澳门"],
                           @[@"北京"],
                           @[@"福建"],
                           @[@"甘肃",@"广东",@"广西",@"贵州"],
                           @[@"海南",@"河北",@"黑龙江",@"河南",@"湖北",@"湖南"],
                           @[@"江苏",@"江西",@"吉林"],
                           @[@"辽宁"],
                           @[@"内蒙古",@"宁夏"],
                           @[@"青海"],
                           @[@"山东",@"上海",@"山西",@"陕西",@"四川"],
                           @[@"台湾",@"天津"],
                           @[@"香港",@"新疆",@"西藏"],
                           @[@"云南"],
                           @[@"浙江",@"重庆"],nil];
    //初始化选中状态数组
    if (![self.proSelStr isEqualToString:@""]) {
       self.proSelData = (NSMutableArray *)[self.proSelStr componentsSeparatedByString:@","];
        self.SelectionArr = [[NSMutableArray alloc]init];
        for (int i=0; i<self.contentsArray.count; i++) {
            NSArray *itemArr = [self.contentsArray objectAtIndex:i];
            NSMutableArray *itemState = [[NSMutableArray alloc]init];
            for (int j=0; j<itemArr.count; j++) {
                
                NSNumber *defaultState = [NSNumber numberWithBool:NO];
                for (int k=0; k<self.proSelData.count; k++) {
                    if ([[itemArr objectAtIndex:j] isEqualToString:[self.proSelData objectAtIndex:k]]) {
                        defaultState = [NSNumber numberWithBool:YES];
                    }
                }
               [itemState addObject:defaultState];
            }
            [self.selectionArr addObject:itemState];
        }
    }else{
    //初始化全不选
    self.SelectionArr = [[NSMutableArray alloc]init];
    for (int i=0; i<self.contentsArray.count; i++) {
        NSArray *itemArr = [self.contentsArray objectAtIndex:i];
        NSMutableArray *itemState = [[NSMutableArray alloc]init];
        for (int j=0; j<itemArr.count; j++) {
            NSNumber *defaultState = [NSNumber numberWithBool:NO];
            [itemState addObject:defaultState];
        }
        [self.selectionArr addObject:itemState];
    }
        }
}
// 每个分区的页眉
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitles objectAtIndex:section];
}
// 索引目录
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{

    return self.sectionTitles;
}
// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    return index;
}

 // 分区数
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 return [self.contentsArray count];
 }

// 每个分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.contentsArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"proCell";
    
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [[self.contentsArray objectAtIndex:indexPath.section]  objectAtIndex:indexPath.row];

    if ([[[self.selectionArr objectAtIndex:indexPath.section]  objectAtIndex:indexPath.row] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        cell.tintColor = [UIColor colorWithRed:(0.0/255.0) green:(122.0/255.0) blue:(255.0/255.0) alpha:1.0];
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"test pro 2222222");
    
    NSInteger row =[indexPath row];
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSIndexPath * neverIndexpath =[NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell * neverCell = [tableView cellForRowAtIndexPath:neverIndexpath];
    [self.proTable deselectRowAtIndexPath:indexPath animated:NO];
    if (row>=0) {
        //选中weekday则取消never选中
        //切换cell的选中状态
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            //取消选中状态
            NSLog(@"test pro %@",@"hello un selected");
            cell.accessoryType = UITableViewCellAccessoryNone;
            //修改选中状态数组种的相关状态
            [[self.selectionArr objectAtIndex:indexPath.section] replaceObjectAtIndex:row withObject:[NSNumber numberWithBool:NO]];
            
        }else if (cell.accessoryType == UITableViewCellAccessoryNone)
        {
            //设置选中状态
            NSLog(@"test pro %@",@"hello selected");
            cell.accessoryType =UITableViewCellAccessoryCheckmark;
            cell.tintColor = [UIColor colorWithRed:(0.0/255.0) green:(122.0/255.0) blue:(255.0/255.0) alpha:1.0];
            //修改选中状态数组中的相关状态
            [[self.selectionArr objectAtIndex:indexPath.section] replaceObjectAtIndex:row withObject:[NSNumber numberWithBool:YES]];
        }
    }else
    {   //选中never则weekday全部取消选中
        if (neverCell.accessoryType == UITableViewCellAccessoryNone) {
            neverCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [[self.selectionArr objectAtIndex:indexPath.section] replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:YES]];
            //重置界面选中状态
            [tableView reloadData];
        }
    }
      //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveBarAct:(id)sender {
    self.proSelData = [[NSMutableArray alloc]init];

    for (int i=0; i<self.contentsArray.count; i++) {
        NSArray *itemArr = [self.contentsArray objectAtIndex:i];
        for (int j=0; j<itemArr.count; j++) {
            if ([[[self.selectionArr objectAtIndex:i] objectAtIndex:j] boolValue]) {
                [self.proSelData addObject:[itemArr objectAtIndex:j]];
            };
        }

    }
    for (int i=0; i<self.proSelData.count; i++) {
        if (i==0) {
            self.proSelStr =[self.proSelData objectAtIndex:i];
        }else{
            self.proSelStr = [self.proSelStr stringByAppendingFormat:@",%@",[self.proSelData objectAtIndex:i]];
        }
    }
    
    [self.delegate proViewControllerSave:self selectData:self.proSelStr];
}

- (IBAction)returnBarAct:(id)sender {
    [self.delegate proViewControllerReturn:self];
}
@end
