//
//  EqimListViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-14.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "EqimListViewController.h"

@interface EqimListViewController ()

@end

@implementation EqimListViewController

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
    self.typeSheet = [[UIActionSheet alloc] initWithTitle:@"数据类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"自动速报", @"正式速报", nil];
    self.typeDis = [self disEqimType:self.type];
    [self.typeBarItem setTitle:self.typeDis];
    
    self.daysSheet = [[UIActionSheet alloc] initWithTitle:@"查询时间" delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"10天", @"30天", nil];
    [self.daysBarItem setTitle:self.days];


    self.sortSheet = [[UIActionSheet alloc] initWithTitle:@"排序方式" delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"震级", @"时间", nil];
    [self.sortBarItem setTitle:self.sort];

    
    self.tabBar.delegate = self;
    
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    
    self.eqimSoap =[[EqimSoap alloc]init];
    self.eqimSoap.delegate = self;
    
    if (self.eqimData == nil) {
        [self.eqimSoap getCataLogEx:self.type Day:self.days];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 0) {
        [self.typeSheet showInView:self.view];
    }else if(item.tag ==1 ){
        [self.daysSheet showInView:self.view];
    }else {
        [self.sortSheet showInView:self.view];
    }
}

//定义tableview 条数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eqimData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //CellIdentifier 所指向的字符串必须与故事板中 Table View Cell 对象的Identifier 属性一致
    
    static NSString *CellIdentifier = @"eqimCell";
        UINib *nib = [UINib nibWithNibName:@"EqimTabCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    EqimTabCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *catalogDic = [(NSArray *)self.eqimData objectAtIndex:indexPath.row];
    cell.m = [[catalogDic objectForKey:@"M"] description];
    cell.locationCName = [[catalogDic objectForKey:@"LocationCname"] description];
    cell.oTime = [[catalogDic objectForKey:@"OTime"] description];
    
    AGSPoint *locPoint = (AGSPoint *)self.locationGrp.geometry;
    double cataLon = [[catalogDic objectForKey:@"Lon"] doubleValue];
    double cataLat = [[catalogDic objectForKey:@"Lat"] doubleValue];
    long distance = [MapUtil getDistanceLatA:locPoint.y lngA:locPoint.x latB:cataLat lngB:cataLon];
    ;
    double distaceDou = (round((distance))/100000)*100;
    
    cell.distance = [NSString stringWithFormat:@"%.2fkm", distaceDou] ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate eqimListViewControllerSelect:self eqimData:self.eqimData eqimType:self.type eqimDays:self.days selectCell:[(NSArray *)self.eqimData objectAtIndex:indexPath.row]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnMap:(id)sender {
    [self.delegate eqimListViewControllerReturn:nil];
}

- (IBAction)enterMap:(id)sender {
    [self.delegate eqimListViewControllerEnter:nil eqimData:self.eqimData eqimType:self.type eqimDays:self.days];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet == self.typeSheet) {
        if (buttonIndex == 0) {
            self.type = @"Auto";
            [self.eqimSoap getCataLogEx:self.type Day:self.days];
        }else if(buttonIndex == 1){
            self.type = @"Official";
            [self.eqimSoap getCataLogEx:self.type Day:self.days];
        }
         self.typeDis = [self disEqimType:self.type];
        [self.typeBarItem setTitle:self.typeDis];
        
    }else if(actionSheet == self.daysSheet){
        if (buttonIndex == 0) {
            self.days = @"10";
            [self.eqimSoap getCataLogEx:self.type Day:self.days];
        }else if(buttonIndex == 1){
            self.days = @"30";
            [self.eqimSoap getCataLogEx:self.type Day:self.days];
        }
        [self.daysBarItem setTitle:self.days];
    }else if(actionSheet  == self.sortSheet){
        
        [self sortMyArray:[actionSheet buttonTitleAtIndex:buttonIndex] actionSheet:actionSheet];
        //[self ]
    }
}

-(void)sortMyArray: (NSString *)type actionSheet:(UIActionSheet *) actionSheet
{
    //NSLog(@"sort begin %@",param);
    NSString *sortType;
    if([type isEqualToString: @"震级"]){
        sortType=@"M";
        
    }else{
        sortType=@"SaveTime";
    }
    
    
    [self.sortBarItem setTitle:type];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortType  ascending:NO];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.eqimData=[(NSArray *)self.eqimData  sortedArrayUsingDescriptors:sortDescriptors];
    
    [self.tabView reloadData];
    
    //self.eqimData=mydata;
}
-(NSString *)disEqimType:(NSString *)type{
    NSString *eqimType;
    if ([type isEqualToString:@"Auto"]) {
        eqimType = @"自动速报";
    }else{
         eqimType = @"正式速报";
    }
    return eqimType;
}

-(void)eqimSoapDidReturn:(EqimSoap *) p_soap eqimData:(NSDictionary *)p_data{
    self.eqimData = (NSArray *)p_data;
    [self.tabView reloadData];
}

//-(void)setButTitle:(UIButton *)but butTitle:(NSString *)title{
//    [but setTitle:title forState:normal];
//}
@end
