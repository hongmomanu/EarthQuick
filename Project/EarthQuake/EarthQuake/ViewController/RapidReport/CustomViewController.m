//
//  CustomViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-17.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

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
    self.cusTabBar.delegate = self;
    self.cusTabBar.selectedItem = self.messageBarItem;
    
    self.maxX1=@"120.25";
    self.maxX2=@"120.37";
    self.maxY1=@"27.82";
    self.maxY2=@"28.2";
    self.minX1=@"119.670";
    self.minX2=@"119.520";
    self.minY1=@"27.55";
    self.minY2=@"27.98";
    self.skname1=@"珊溪水库";
    self.skname2=@"滩坑水库";

    self.cusTabView.dataSource = self;
    self.cusTabView.delegate = self;
    self.cusTabView.rowHeight = 52.0f;
    
    self.configData = [[NSConfigData alloc]init];
    self.userDic  = [self.configData getUserDic];
    if (self.cusData == nil) {
        [self showProView];
        [self getCusRecord];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"customTocuseqim"]){
        self.cusEqimViewController = [segue destinationViewController];
        self.cusEqimViewController.selDic = self.selDic;
        self.cusEqimViewController.delegate = self;
    }else if([[segue identifier]  isEqualToString:@"customTocussk"]){
        self.cusSKViewController = [segue destinationViewController];
        self.cusSKViewController.selDic = self.selDic;
        self.cusSKViewController.delegate = self;
    }
    else if([[segue identifier] isEqualToString:@"customToocean"])
    {
        self.oceanController = [segue destinationViewController];
        self.oceanController.selDic = self.selDic;
        self.oceanController.delegate = self;
    }
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self showProView];
    if (item.tag == 0)
    {
        [self getCusRecord];
        [_mapToolItem setImage:[UIImage imageNamed:@"returnMap.png"]];
    }
    else
    {
        [self getCusInfo];
        [_mapToolItem setImage:[UIImage imageNamed:@"toolAdd.png"]];
    }
    _mapToolItem.tag = item.tag;
}

-(void)showProView{
    //弹出等待友好界面
    _progressView = [_configData getAlert:@"加载中..."];
    [_progressView show];
}

-(void)getCusRecord{
    self.customRecordSoap = [[CustomRecordSoap alloc]init];
    self.customRecordSoap.delegate = self;
    [self.customRecordSoap GetRecordCus:[self.userDic
                                         objectForKey:@"Username"]
                       currentPageIndex:@"0"
                               pageSize:@"15"];
}

-(void)customRecordSoapDidReturn:(CustomRecordSoap *) p_soap{
    //友好界面隐藏
    [_configData performBlock:^{
        
        [_configData performBlock:^{
            if (p_soap.success) {
            self.cusData = [p_soap.returnDic mutableCopy];
            }else{
                
            }
            //NSLog(@"test log %@",@"sucesss");
            [self.cusTabView reloadData];
            [_progressView close];
            [_configData showAlert:p_soap.msg];
        } afterDelay:1.0];
    } afterDelay:1.0];
    
}

-(void)getCusInfo{
    _cusInfoCusByUserIdSoap = [[CusInfoCusByUserIdSoap alloc]init];
    _cusInfoCusByUserIdSoap.delegate = self;
    [_cusInfoCusByUserIdSoap getInfoCusByUserId:[self.userDic objectForKey:@"Userid"]];
}

-(void)cusInfoCusByUserIdSoapDidReturn:(CusInfoCusByUserIdSoap *)p_soap {
    //友好界面隐藏
    [_configData performBlock:^{
        [_progressView close];
        [_configData performBlock:^{
            if (p_soap.success) {
                self.cusData = [p_soap.returnDic mutableCopy];
            }else{
            }
             [self.cusTabView reloadData];
            [_configData showAlert:p_soap.msg];
        } afterDelay:1.0];
    } afterDelay:1.0];
}


//定义tableview 条数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cusData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_mapToolItem.tag == 0)
    {
        UINib *nib = [UINib nibWithNibName:@"EqimTabCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"eqimCell"];
        EqimTabCell *eqimCell = [tableView dequeueReusableCellWithIdentifier:@"eqimCell"];
        NSDictionary *catalogDic = [self.cusData objectAtIndex:indexPath.row];
        eqimCell.m = [[catalogDic objectForKey:@"M"] description];
        eqimCell.locationCName = [[catalogDic objectForKey:@"Msg"] description];
        eqimCell.oTime = [self.configData jsonDateToDate:[[catalogDic objectForKey:@"Sendtime"] description]];
        
        return eqimCell;
    }
    
    else
        
    {
        UINib *nib = [UINib nibWithNibName:@"CusInfoCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"cusInfoCell"];
        CusInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cusInfoCell"];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate   = self;
        NSDictionary *cusInfoDic = [self.cusData objectAtIndex:indexPath.row];
        NSString *skname=@"";
        NSString *type=[[cusInfoDic objectForKey:@"TabCustomtype"] objectForKey:@"Field"];
        NSString *cpMaxx= [NSString stringWithFormat:@"%@", [cusInfoDic objectForKey:@"Maxx"]];
        if([type isEqualToString:@"CzCataLogSk"]){
            if([cpMaxx isEqualToString:self.maxX1]){
                skname=[[@"(" stringByAppendingString: self.skname1] stringByAppendingString:@")"];
            }else if([cpMaxx isEqualToString:self.maxX2]){
                skname=[[@"(" stringByAppendingString: self.skname2] stringByAppendingString:@")"];
            }
        }
        
        
        cell.title = [[[cusInfoDic objectForKey:@"TabCustomtype"] objectForKey:@"Name"] stringByAppendingString:skname];
        cell.type =[NSString stringWithFormat:@"大于%@，小于%@",[cusInfoDic objectForKey:@"Msmall"], [cusInfoDic objectForKey:@"Mlarge"]];
        return cell;
    }
   
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    return rightUtilityButtons;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.cusTabView indexPathForCell:cell] ;
    switch (index) {
        case 0:
        {
            [self showProView];
            self.cusInfoDelByIdSoap  = [[CusInfoDelByIdSoap alloc]init];
            self.cusInfoDelByIdSoap.cellIndex = cellIndexPath;
            self.cusInfoDelByIdSoap.delegate = self;
            [self.cusInfoDelByIdSoap DelInfoCusById:[[self.cusData objectAtIndex:cellIndexPath.row] objectForKey:@"Id"]];
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_mapToolItem.tag == 0) {
    [self.delegate customViewControllerSelect:self
                                     custData:[self.cusData copy]
                                     custType:nil
                                   selectCell:[(NSArray *)_cusData objectAtIndex:indexPath.row]];
    }else{
        _selDic = [(NSArray *)_cusData objectAtIndex:indexPath.row];
        
        NSString *cusField =[[[_selDic objectForKey:@"TabCustomtype"]objectForKey:@"Field"] description];
        if ([cusField isEqualToString:@"CzCataLogEx"]) {
            [self performSegueWithIdentifier:@"customTocuseqim" sender:nil];
        }else if ([cusField isEqualToString:@"CzCataLogSk"]){
            [self performSegueWithIdentifier:@"customTocussk" sender:nil];
        }else if ([cusField isEqualToString:@"CzCataLogSO"]){
            [self performSegueWithIdentifier:@"customToocean" sender:nil];
        }
    }
}
-(void)cusInfoDelByIdSoapDidReturn:(CusInfoDelByIdSoap *) p_soap{
    //友好界面隐藏
    [_configData performBlock:^{
        [_progressView close];
        [_configData performBlock:^{
             if (p_soap.success) {
                 [self.cusData removeObjectAtIndex:p_soap.cellIndex.row];
                 [self.cusTabView deleteRowsAtIndexPaths:@[p_soap.cellIndex]
                                        withRowAnimation:UITableViewRowAnimationLeft];
            }
            [_configData showAlert:p_soap.msg];
        } afterDelay:1.0];
    } afterDelay:1.0];
    
}

-(void)CusEqimViewControllerReturn:(CusEqimViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)eqimViewReloadList:(CustomRecordSoap *) p_soap{
 
    
            if(p_soap.success){
                [self.cusData replaceObjectAtIndex: self.cusTabView.indexPathForSelectedRow.row withObject:[p_soap.returnDic mutableCopy] ];
                [self.cusTabView reloadData];
            }
    
    
    
    
    
}

-(void)CusSKViewControllerReturn:(CusSKViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)CusoceanViewControllerReturn:(CusoceanViewController *)controller ;
{
     [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    _selDic = nil;
        if (buttonIndex == 0) {
            [self performSegueWithIdentifier:@"customTocuseqim" sender:nil];
        }else if(buttonIndex == 1){
            [self performSegueWithIdentifier:@"customTocussk" sender:nil];
        }else if (buttonIndex ==2 )
        {
            [self performSegueWithIdentifier:@"customToocean" sender:nil];
        
        }
}

- (IBAction)returnTomap:(id)sender {
    [self.delegate customViewControllerReturn:self];
}

- (IBAction)enterTomap:(id)sender {
    if (self.mapToolItem.tag== 0) {
        [self.delegate customViewControllerEnter:self custData:[self.cusData copy] custType:nil];
    }
    else
    {
        self.typeSheet = [[UIActionSheet alloc] initWithTitle:@"定制类型"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"全国地震", @"水库地震",@"海洋地震", nil];
        
        [self.typeSheet showInView:self.view];
    }
}
@end
