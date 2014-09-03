//
//  PreViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "PreViewController.h"

@interface PreViewController ()

@end

@implementation PreViewController

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
    _configData                     = [[NSConfigData alloc]init];
    
    _tableHeaderView                = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, self.view.frame.size.width, _tableView.bounds.size.height)];
    _tableHeaderView.delegate       = self;
    [_tableView addSubview:_tableHeaderView];
    _tableView.dataSource           = self;
    _tableView.delegate             =self;
    _tableView.rowHeight            = 52;
    
    [_tableHeaderView refreshLastUpdatedDate];
    [_tableView setContentOffset:CGPointMake(0, -75) animated:YES];
    [_tableHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:)
                           withObject:_tableView
                           afterDelay:0.4 ];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


- (void)reloadTableViewDataSource{
	
	self.reloading = YES;
    [self segChanged];
	
}

- (void)doneLoadingTableViewData{
	[self.tableView reloadData];
	self.reloading = NO;
	[self.tableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[self.tableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.tableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return self.reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"listTopreform"]){
        self.preFormController              = [segue destinationViewController];
        self.preFormController.cataLogDic   = self.cataLogDic;
        self.preFormController.locationGP   = self.locationGP;
        self.preFormController.delegate     = self;
        self.preFormController.selDic       = self.selDic;
        
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArr count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selDic = self.dataArr[indexPath.row];
    _cataLogData = [CataLogData initDb:[self.configData getMyDb]];
    [_cataLogData QueryById:[[_selDic objectForKey:@"EarthId"] description]];
    _cataLogDic = _cataLogData.dataDic;

    [self performSegueWithIdentifier:@"listTopreform" sender:nil];
}



#pragma mark - UIScrollViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UINib *nib                      = [UINib nibWithNibName:@"ProCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];

    ProCell *cell                   = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.rightUtilityButtons        = [self rightButtons:[[self.dataArr[indexPath.row] objectForKey:@"SaveType"] intValue]];
    cell.delegate                   = self;
    cell.address                    = [self.dataArr[indexPath.row] objectForKey:@"Address"];
    
    if ([[self.dataArr[indexPath.row] objectForKey:@"SaveType"] intValue] == 0) {
        cell.state                  = @"上传成功";
    }else if([[self.dataArr[indexPath.row] objectForKey:@"SaveType"] intValue] == 1){
        cell.state                  = @"上传等待";
    }else{
        cell.state                  = @"上传失败";
    }
    cell.time = [NSString stringWithFormat:@"%@ %@",
                 [self.dataArr[indexPath.row] objectForKey:@"Date"],
                 [self.dataArr[indexPath.row] objectForKey:@"Time"]];
    
        return cell;
    
}

- (NSArray *)rightButtons:(int)p_saveType
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];

    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    if (p_saveType != 0) {
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:(float)19/255 green:(float)172/255 blue:(float)179/255 alpha:1.0f]
                                                    title:@"上传"];
    }
    return rightUtilityButtons;
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell] ;
    switch (index) {
        case 0:
        {
            [self.preinfoData DeleteData:[[self.dataArr objectAtIndex:cellIndexPath.row] objectForKey:@"InfoId"]];
            if (self.preinfoData.success) {
                [self.configData deleteMediaDir:@"PROFESSION" info:[[self.dataArr objectAtIndex:cellIndexPath.row] objectForKey:@"InfoId"]];
                [self.dataArr removeObjectAtIndex:cellIndexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
            break;
        }
        case 1:
        {
            //弹出等待友好界面
            _progressView           = [_configData getAlert:@"上传中..."];
            [_progressView show];
            //访问后台服务
            _preinfoSoap            = [[PreInfoSoap alloc]init];
            _preinfoSoap.delegate   = self;
            
            _preinfoSoap.strInfoId = [[_selDic objectForKey:@"InfoId" ]description];
            _preinfoSoap.strMoudleType = @"PROFESSION";
            _preinfoSoap.photoArr = [self.configData judgeMediaFile:@"PROFESSION" info:[[_selDic objectForKey:@"InfoId" ]description] fileType:@"image"];
            _preinfoSoap.videoArr = [self.configData judgeMediaFile:@"PROFESSION" info:[[_selDic objectForKey:@"InfoId" ]description] fileType:@"video"];
            _preinfoSoap.strEarthId = [[_selDic objectForKey:@"EarthId" ]description];
            
            _selDic =[self.dataArr objectAtIndex:cellIndexPath.row];
            [_preinfoSoap uploadDataPre:[[_selDic objectForKey:@"InfoId" ]description]
                                EarthId:[[_selDic objectForKey:@"EarthId" ]description]
                                   Name:[[_selDic objectForKey:@"Name" ]description]
                                 UserId:[[_selDic objectForKey:@"UserId" ]description]
                              Longitude:[[_selDic objectForKey:@"Longitude" ]description]
                               Latitude:[[_selDic objectForKey:@"Latitude" ]description]
                                Address:[[_selDic objectForKey:@"Address" ]description]
                             SIntensity:[[_selDic objectForKey:@"SIntensity" ]description]
                             PIntensity:[[_selDic objectForKey:@"PIntensity" ]description]
                           SDescription:[[_selDic objectForKey:@"SDescription" ]description]
                           PDescription:[[_selDic objectForKey:@"PDescription" ]description]
                                   Date:[[_selDic objectForKey:@"Date" ]description]
                                   Time:[[_selDic objectForKey:@"Time" ]description]];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
                default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segChanged{
    self.preinfoData = [PreinfoData initDb:[self.configData getMyDb]];
    [self.preinfoData QueryData];
    if(_preinfoData.success){
        self.dataArr = self.preinfoData.dataArr;
    }
}
-(void)PreFormViewControllerReturn:(PreFormViewController *)controller Save:(BOOL)save{
    if (save) {
        [self viewDidLoad];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)preInfoSoapDidReturn:(PreInfoSoap *) p_soap{
    //友好界面隐藏
    [_configData performBlock:^{
        
        [_configData performBlock:^{
            if (p_soap.success) {
                [_preinfoData UpdateSaveType:[[_selDic objectForKey:@"InfoId"] description]
                                    SaveType:@"0"];
            }else{
                [_preinfoData UpdateSaveType:[[_selDic objectForKey:@"InfoId"] description]
                                    SaveType:@"2"];
            }
            [_progressView close];
            [_configData showAlert:p_soap.msg];
            
            //刷新数据
            [self segChanged];
            [_tableView reloadData];
        } afterDelay:1.0];
    } afterDelay:1.0];
    
}

-(void)cataLogSoapDidReturn:(CataLogSoap *) p_soap data:(NSDictionary *)p_cataData{
    
    self.cataLogData = [CataLogData initDb:[self.configData getMyDb]];
    [self.cataLogData InsertData:[p_cataData objectForKey:@"CataId"]
                             Lat:[p_cataData objectForKey:@"EpiLat"]
                             Lon:[p_cataData objectForKey:@"EpiLon"]
                               M:[p_cataData objectForKey:@"M"]
                           OTime:[self.configData jsonDateToDate:[p_cataData objectForKey:@"OTime"] ]
                    locationName:[p_cataData objectForKey:@"LocationCname"]];
    [self segueToProForm:self.cataLogData.success cataLog:self.cataLogData.dataDic];
};


- (IBAction)addToPro:(id)sender {
    self.selDic = nil;
    
    self.progressView = [self.configData getAlert:@"加载中..."];
    [self.progressView show];
    
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([self.reachability currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"没有网络连接");
            self.configData = [[NSConfigData alloc]init];
            self.cataLogData = [CataLogData initDb:[self.configData getMyDb]];
            [self.cataLogData QueryByOtime];
            [self segueToProForm:self.cataLogData.success cataLog:self.cataLogData.dataDic];
            break;
        case ReachableViaWWAN:
        case ReachableViaWiFi:
            NSLog(@"使用WiFi或3G网络");
            self.cataLogSoap =[[CataLogSoap alloc]init];
            self.cataLogSoap.delegate = self;
            [self.cataLogSoap getData];
        break;
    }
}

-(void)segueToProForm:(BOOL)p_result cataLog:(NSDictionary*) p_cataLogDic{
    self.cataLogDic = p_cataLogDic;
    if (p_result) {
        [self.configData performBlock:^{
            [self.progressView close];
            [self performSegueWithIdentifier:@"listTopreform" sender:nil];
        } afterDelay:2.0];
    }
}



- (IBAction)returnToMap:(id)sender {
    [self.delegate PreViewControllerReturn:self];
}
@end
