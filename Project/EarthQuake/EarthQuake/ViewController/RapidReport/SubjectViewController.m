//
//  SubjectViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-28.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SubjectViewController.h"
#define SubjectURL @"http://61.164.34.9:8001/ArcGIS/rest/services/Earthquake2/PdaLayer/MapServer"

@interface SubjectViewController ()

@end

@implementation SubjectViewController

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
    self.bottomSrcView.contentSize = CGSizeMake(400, 40);
    
    self.tableHeaderView= [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tabView.bounds.size.height, self.view.frame.size.width, self.tabView.bounds.size.height)];
    self.tableHeaderView.delegate = self;
    [self.tabView addSubview:self.tableHeaderView];
    
    self.tabView.dataSource = self;
    self.tabView.delegate =self;
    
    
    [self.tableHeaderView refreshLastUpdatedDate];
    
    if ([self.queryParams.layerType isEqualToString:@"skLayer"]) {
        self.segControl.selectedSegmentIndex = 0;
    }else if([self.queryParams.layerType isEqualToString:@"faultLayer"]){
        self.segControl.selectedSegmentIndex = 1;
    }else if([self.queryParams.layerType isEqualToString:@"qzLayer"]){
        self.segControl.selectedSegmentIndex = 2;
    }else if([self.queryParams.layerType isEqualToString:@"czLayer"]){
        self.segControl.selectedSegmentIndex = 3;
    }else if([self.queryParams.layerType isEqualToString:@"bncsLayer"]){
        self.segControl.selectedSegmentIndex = 4;
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


- (void)reloadTableViewDataSource{
	
	self.reloading = YES;
    [self segChanged:self.segControl];
	
}

- (void)doneLoadingTableViewData{
	
	self.reloading = NO;
	[self.tableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tabView];
	
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

//列表条数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (nil == self.featureSet) {
		return 0;
	}
	return [self.featureSet.features count];
}

//called by table view when it needs to draw one of its rows
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	//static instance to represent a single kind of cell. Used if the table has cells formatted differently
    static NSString *RootViewControllerCellIdentifier = @"subjectCell";
    
	//as cells roll off screen get the reusable cell, if we can't create a new one
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RootViewControllerCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RootViewControllerCellIdentifier];
    }
	
	AGSGraphic *feature = [self.featureSet.features objectAtIndex:indexPath.row];
	cell.textLabel.text = [feature attributeAsStringForKey:[self.queryParams.itemField objectAtIndex:0]];
    cell.detailTextLabel.text =[feature attributeAsStringForKey:[self.queryParams.itemField objectAtIndex:1]];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate subjectViewControllerSelect:self subData:self.featureSet queryParams:self.queryParams selectCell:[self.featureSet.features objectAtIndex:indexPath.row]];
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToMap:(id)sender {
    [self.delegate subjectViewControllerReturn:self];
}

- (IBAction)enterToMap:(id)sender {
    [self.delegate subjectViewControllerEnter:self
                                      subData:self.featureSet queryParams:self.queryParams];
}

- (IBAction)segChanged:(id)sender {
    //获取用户点击Segmented Control 的按钮索引值，索引值从左到右从0开始
    int value = [(UISegmentedControl*)sender selectedSegmentIndex];
     AGSEnvelope *t_locatP = [[AGSEnvelope alloc]
                              initWithXmin:((AGSPoint *)self.locationGrp.geometry).x-0.1
                              ymin:((AGSPoint *)self.locationGrp.geometry).y-0.1
                              xmax:((AGSPoint *)self.locationGrp.geometry).x+0.1
                              ymax:((AGSPoint *)self.locationGrp.geometry).y+0.1
                              spatialReference:[[AGSSpatialReference alloc]initWithWKID:4490]];
    //根据索引值设置界面元素的显示信息
    switch (value) {
        case 0:
            self.queryParams = [[QueryParams alloc]init];
            self.queryParams.layerType = @"skLayer";
            self.queryParams.layerName = @"大型水库";
            self.queryParams.layerSpr = [[AGSSpatialReference alloc]initWithWKID:4490];
            self.queryParams.layerUrl = [SubjectURL stringByAppendingString:@"/1"];
            self.queryParams.layerQuery = YES;
            self.queryParams.layerWhere = @"NAME is not null AND length(NAME)>1";
            self.queryParams.fieldOrder = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",nil];
            self.queryParams.fieldFormat = [[NSMutableArray alloc] initWithObjects:@"5",@"5",@"5",@"5",@"5",nil];
            self.queryParams.fieldOut = [[NSMutableArray alloc] initWithObjects:@"NAME",@"DAM_HEIGHT",@"DESIGN_VOL",@"LOCATION",@"ORGANIZATI",nil];
            self.queryParams.fieldAlias = [[NSMutableArray alloc] initWithObjects:@"水库名称:",@"坝高:",@"蓄水量:",@"所属地市:",@"管理单位:",nil];
            self.queryParams.itemField = [[NSMutableArray alloc] initWithObjects:@"NAME",@"LOCATION",nil];
            
            //set up query task against layer, specify the delegate
            self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:self.queryParams.layerUrl]];
            self.queryTask.delegate = self;
            
            //return all fields in query
            self.query = [AGSQuery query];
            self.query.where = self.queryParams.layerWhere;
            self.query.outSpatialReference = self.queryParams.layerSpr ;
            self.query.returnGeometry = YES;
            self.query.outFields = self.queryParams.fieldOut;
            [self.queryTask executeWithQuery:self.query];
            break;
            
        case 1:
            self.queryParams = [[QueryParams alloc]init];
            self.queryParams.layerName = @"断裂带";
            self.queryParams.layerType = @"faultLayer";
            self.queryParams.layerSpr = [[AGSSpatialReference alloc]initWithWKID:4490];
            self.queryParams.layerUrl = [SubjectURL stringByAppendingString:@"/2"];
            self.queryParams.layerQuery = YES;
            self.queryParams.layerWhere = @"NAME is not null AND length(NAME)>1";
            self.queryParams.fieldOrder = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",nil];
            self.queryParams.fieldFormat = [[NSMutableArray alloc] initWithObjects:@"5",@"5",@"5",@"5",nil];
            self.queryParams.fieldOut = [[NSMutableArray alloc] initWithObjects:@"OBJECTID",@"NAME",@"ATTR",@"CHARACTER_",nil];
            self.queryParams.fieldAlias = [[NSMutableArray alloc] initWithObjects:@"编号:",@"名称:",@"类型:",@"特型:",nil];
            self.queryParams.itemField = [[NSMutableArray alloc] initWithObjects:@"NAME",@"ATTR",nil];
            
            //set up query task against layer, specify the delegate
            self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:self.queryParams.layerUrl]];
            self.queryTask.delegate = self;
            
            //return all fields in query
            self.query = [AGSQuery query];
            self.query.outSpatialReference = self.queryParams.layerSpr;
            self.query.where = self.queryParams.layerWhere;
            self.query.returnGeometry = YES;
            self.query.outFields = self.queryParams.fieldOut;
            [self.queryTask executeWithQuery:self.query];
            break;
        case 2:
            self.queryParams = [[QueryParams alloc]init];
            self.queryParams.layerType = @"qzLayer";
            self.queryParams.layerName = @"前兆台站";
            self.queryParams.layerSpr = [[AGSSpatialReference alloc]initWithWKID:4490];
            self.queryParams.fieldOrder = [[NSMutableArray alloc] initWithObjects:@"6",@"5",@"4",@"3",@"2",@"1",nil];
            self.queryParams.fieldFormat = [[NSMutableArray alloc] initWithObjects:@"5",@"5",@"5",@"5",@"5",@"5",nil];
            self.queryParams.fieldOut = [[NSMutableArray alloc] initWithObjects:@"Stationmailaddress",@"Stationdutyphone",@"Latitude",@"Longitude",@"Stationname",@"Stationid",nil];
            self.queryParams.fieldAlias = [[NSMutableArray alloc] initWithObjects:@"通信地址:",@"值班电话:",@"纬度:",@"经度:",@"台站名称:",@"台站代码",nil];
            self.queryParams.itemField = [[NSMutableArray alloc] initWithObjects:@"Stationname",@"Stationmailaddress",nil];
            
            self.stationSoap = [[StationSoap alloc]init];
            self.stationSoap.delegate = self;
            [self.stationSoap GetStation:@"GetQzStation"];
            break;
        case 3:
            self.queryParams = [[QueryParams alloc]init];
            self.queryParams.layerName = @"测震台站";
            self.queryParams.layerType = @"czLayer";
            self.queryParams.layerSpr = [[AGSSpatialReference alloc]initWithWKID:4490];
            self.queryParams.fieldOrder = [[NSMutableArray alloc] initWithObjects:@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",nil];
            self.queryParams.fieldFormat = [[NSMutableArray alloc] initWithObjects:@"5",@"5",@"5",@"5",@"5",@"5",@"5",@"5",nil];
            self.queryParams.fieldOut = [[NSMutableArray alloc] initWithObjects:@"Stationmailaddress",@"Communication",@"Powermode",@"Chargetel",@"Latitude",@"Longitude",@"Stationname",@"Stationid",nil];
            self.queryParams.fieldAlias = [[NSMutableArray alloc] initWithObjects:@"通信地址:",@"通信方式",@"供电方式",@"值班电话:",@"纬度:",@"经度:",@"台站名称:",@"台站代码",nil];
            self.queryParams.itemField = [[NSMutableArray alloc] initWithObjects:@"Stationname",@"Stationmailaddress",nil];
            
            self.stationSoap = [[StationSoap alloc]init];
            self.stationSoap.delegate = self;
            [self.stationSoap GetStation:@"GetCzStation"];
            break;
            
        case 4:
            self.queryParams = [[QueryParams alloc]init];
            self.queryParams.layerType = @"bncsLayer";
            self.queryParams.layerName = @"避难场所";
            self.queryParams.layerGeometry = t_locatP;
            
            self.queryParams.layerSpr = [[AGSSpatialReference alloc]initWithWKID:4490];
            self.queryParams.layerUrl = [SubjectURL stringByAppendingString:@"/0"];
            self.queryParams.layerQuery = YES;
            self.queryParams.layerWhere = @"NAME is not null AND length(NAME)>1";
            self.queryParams.fieldOrder = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",nil];
            self.queryParams.fieldFormat = [[NSMutableArray alloc] initWithObjects:@"5",@"5",@"5",@"5",@"5",@"5",nil];
            self.queryParams.fieldOut = [[NSMutableArray alloc] initWithObjects:@"FID_BZAZCS",@"NAME",@"CITY",@"COUNTY",@"DISTRICTNA",@"ADDRESS",nil];
            self.queryParams.fieldAlias = [[NSMutableArray alloc] initWithObjects:@"编号:",@"名称:",@"蓄所属市:",@"所属县:",@"所属镇:",@"地址",nil];
            self.queryParams.itemField = [[NSMutableArray alloc] initWithObjects:@"NAME",@"CITY",nil];
            
            //set up query task against layer, specify the delegate
            self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:self.queryParams.layerUrl]];
            self.queryTask.delegate = self;
            
            //return all fields in query
            self.query = [AGSQuery query];
            self.query.where = self.queryParams.layerWhere;
            self.query.geometry = self.queryParams.layerGeometry;
            self.query.outSpatialReference = self.queryParams.layerSpr ;
            self.query.returnGeometry = YES;
            self.query.outFields = self.queryParams.fieldOut;
            [self.queryTask executeWithQuery:self.query];
            break;
        default:
            break;
    }

}
//Web Service调用返回
-(void)stationSoapDidReturn:(StationSoap *) p_stationSoap stationData:(NSDictionary *) p_stationData{
    
    NSMutableArray *feartures = [[NSMutableArray alloc]init];
    for (NSDictionary *stationItem in p_stationData) {
        NSMutableDictionary *attValue = [[NSMutableDictionary alloc]init];
        for (NSString *outField in self.queryParams.fieldOut) {
            [attValue setValue:[stationItem objectForKey:outField] forKey:outField];
        }
        
        AGSPoint *t_point = [AGSPoint pointWithX:[[attValue objectForKey:@"Longitude"] doubleValue]
                                               y:[[attValue objectForKey:@"Latitude"] doubleValue]
                                spatialReference:self.queryParams.layerSpr];
        
        if ([self.queryParams.layerType isEqualToString:@"qzLayer"]) {
            self.t_imagePath = @"qz.png";
        }else if([self.queryParams.layerType isEqualToString:@"czLayer"]){
            self.t_imagePath = @"cz.png";
        }
        UIImage *t_pic = [UIImage imageNamed:self.t_imagePath];

        
        AGSPictureMarkerSymbol *picMarkerSymbol = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:t_pic ];
        
        AGSGraphic *t_gh = [AGSGraphic graphicWithGeometry:t_point symbol:picMarkerSymbol attributes:attValue infoTemplateDelegate:nil];
        [feartures addObject:t_gh];
    }
    self.featureSet = [[AGSFeatureSet alloc] initWithFeatures:feartures];
    [self.tabView reloadData];
}

//空间查询成功
- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation*)op didExecuteWithFeatureSetResult:(AGSFeatureSet *)featureSet{
    switch (featureSet.geometryType) {
        case AGSGeometryTypePoint:
        case AGSGeometryTypeMultipoint:
            if ([self.queryParams.layerType isEqualToString:@"skLayer"]) {
                self.t_imagePath = @"sk.png";
            }else if ([self.queryParams.layerType isEqualToString:@"bncsLayer"]){
                self.t_imagePath = @"bncs.png";
            }
            for (AGSGraphic *t_agsgp in featureSet.features) {
                t_agsgp.symbol =[AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:[UIImage imageNamed:self.t_imagePath]];
            }
            self.featureSet = featureSet;
            break;
        case AGSGeometryTypePolyline:
            
            self.featureSet = featureSet;
            break;
        default:
            break;
    }
    
	[self.tabView reloadData];

}

//空间查询失败
- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation *)op didFailWithError:(NSError *)error {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
														message:[error localizedDescription]
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
	[alertView show];
}
@end
