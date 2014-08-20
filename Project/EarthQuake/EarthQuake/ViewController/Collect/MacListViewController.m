//

//  MacListViewController.m

//  EarthQuake

//

//  Created by hvit-pc on 14-5-26.

//  Copyright (c) 2014年 hvit-pc. All rights reserved.

//



#import "MacListViewController.h"



@interface MacListViewController ()



@end



@implementation MacListViewController



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
    self.configData = [[NSConfigData alloc]init];
    self.tableHeaderView= [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    self.tableHeaderView.delegate = self;
    [self.tableView addSubview:self.tableHeaderView];
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    self.tableView.rowHeight = 52;

    [self.tableHeaderView refreshLastUpdatedDate];
    [self.tableView setContentOffset:CGPointMake(0, -75) animated:YES];
    [self.tableHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:) withObject:self.tableView afterDelay:0.4 ];

    
    // If you set the seperator inset on iOS 6 you get a NSInvalidArgumentException...weird
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0); // Makes the horizontal row seperator stretch the entire length of the table view
        
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
    
    if ([[segue identifier]  isEqualToString:@"listTomacform"]){
        _macFormViewController              = [segue destinationViewController];
        _macFormViewController.locationGP   = _locationGP;
        _macFormViewController.delegate     = self;
        _macFormViewController.selDic       = _selDic;
        
        
        
    }
    
}





#pragma mark UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    // Return the number of rows in the section.
    return [self.dataArr count];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selDic = self.dataArr[indexPath.row];
    [self performSegueWithIdentifier:@"listTomacform" sender:nil];
    
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
    cell.time                       = [NSString stringWithFormat:@"%@ %@",
                                       
                                       [self.dataArr[indexPath.row] objectForKey:@"Date"],
                                       
                                       [self.dataArr[indexPath.row] objectForKey:@"Time"]];
    
    if ([[self.dataArr[indexPath.row] objectForKey:@"SaveType"] intValue] == 0) {
        cell.state = @"上传成功";
    }else if([[self.dataArr[indexPath.row] objectForKey:@"SaveType"] intValue] == 1){
        cell.state = @"上传等待";
    }else{
        cell.state = @"上传失败";
    }
    return cell;
    
}



- (NSArray *)rightButtons:(int)p_saveType

{
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];

    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f] title:@"删除"];
    if (p_saveType != 0) {
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:(float)19/255 green:(float)172/255 blue:(float)179/255 alpha:1.0f]title:@"上传"];
    }
    
    return rightUtilityButtons;
    
}



- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell] ;
    switch (index) {
        case 1:
        {
            //弹出等待友好界面
            _progressView           = [_configData getAlert:@"上传中..."];

            [_progressView show];
            
            //访问后台服务
            _macInfoSoap            = [[MacinfoSoap alloc]init];
            _macInfoSoap.delegate   = self;
            _selDic =[self.dataArr objectAtIndex:cellIndexPath.row];
            
            _macInfoSoap.strInfoId = [[_selDic objectForKey:@"InfoId" ]description];
            _macInfoSoap.strMoudleType = @"MACROSCOPIC";
            _macInfoSoap.photoArr = [self.configData judgeMediaFile:@"MACROSCOPIC" info:[[_selDic objectForKey:@"InfoId" ]description] fileType:@"image"];
            _macInfoSoap.videoArr = [self.configData judgeMediaFile:@"MACROSCOPIC" info:[[_selDic objectForKey:@"InfoId" ]description] fileType:@"video"];
            _macInfoSoap.strEarthId = @"";
            
            [_macInfoSoap uploadDataMac:[[_selDic objectForKey:@"InfoId"] description]
                                   Name:[[_selDic objectForKey:@"Name"] description]
                                 UserId:[[_selDic objectForKey:@"UserId"] description]
                             Department:[[_selDic objectForKey:@"Department"] description]
                              Longitude:[[_selDic objectForKey:@"Longitude"] description]
                               Latitude:[[_selDic objectForKey:@"Latitude"] description]
                                Address:[[_selDic objectForKey:@"Address"] description]
                            Description:[[_selDic objectForKey:@"Description"] description]
                                   Date:[[_selDic objectForKey:@"Date"] description]
                                   Time:[[_selDic objectForKey:@"Time"] description]];
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 0:
        {
            [self.macinfoData DeleteData:[[self.dataArr objectAtIndex:cellIndexPath.row] objectForKey:@"InfoId"]];
            if (self.macinfoData.success) {
                [self.configData deleteMediaDir:@"MACROSCOPIC" info:[[self.dataArr objectAtIndex:cellIndexPath.row] objectForKey:@"InfoId"]];
                [self.dataArr removeObjectAtIndex:cellIndexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
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
}



- (void)segChanged{
    self.macinfoData = [MacinfoData initDb:[self.configData getMyDb]];
    [self.macinfoData QueryData];
    if(_macinfoData.success){
        self.dataArr = self.macinfoData.dataArr;
    }
}



-(void)macinfoSoapDidReturn:(MacinfoSoap *) p_soap{
    //友好界面隐藏
    [_configData performBlock:^{
        [_progressView close];
        [_configData performBlock:^{
            if (p_soap.success) {
                [_macinfoData UpdateSaveType:[[_selDic objectForKey:@"InfoId"] description] SaveType:@"0"];
            }else{
                [_macinfoData UpdateSaveType:[[_selDic objectForKey:@"InfoId"] description] SaveType:@"2"];
            }
            [self segChanged];
            [_tableView reloadData];
            [_configData showAlert:p_soap.msg];
        } afterDelay:1.0];
    } afterDelay:1.0];
    
}



-(void)MacFormViewControllerReturn:(MacFormViewController *)controller Save:(BOOL)save{
    if (save) {
        [self viewDidLoad];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}



- (IBAction)addToMacForm:(id)sender {
    _selDic = nil;
    [self performSegueWithIdentifier:@"listTomacform" sender:nil];
    
}



- (IBAction)returnToMap:(id)sender {
    [self.delegate MacListViewControllerReturn:self];
    
}

@end

