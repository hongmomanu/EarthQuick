//
//  EqimViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-10.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "EqimViewController.h"
#define CUSTOM @"CUSTOM"
#define PROCUSTOM @"PROCUSTOM"
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];[alert show];}


@interface EqimViewController ()

@end

@implementation EqimViewController

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
    @autoreleasepool {
        self.configData = [[NSConfigData alloc]init];
        //NSLog(@"1111 %@",self.esriView);
        self.esriView = [[esriView alloc] initWithFrame:self.conView.frame];
        self.esriView.delegate = self;
        [self.conView addSubview:self.esriView];
        
        self.tabBar.selectedItem = self.eqimBarItem;
        self.tabBar.delegate = self;
        
        self.type = @"Auto";
        self.days = @"30";
        
        self.eqimSoap = [[EqimSoap alloc]init];
        self.eqimSoap.delegate = self;
        [self.eqimSoap getCataLogEx:self.type Day:self.days];
    }
    
 
}


-(void)eqimSoapDidReturn:(EqimSoap *) p_soap eqimData:(NSDictionary *) p_eqimData{
    
    [self.esriView addEqimLayer:p_eqimData select:nil];
    //NSLog(@"测试1 %@",p_soap);
    //NSLog(@"测试2 %@",p_eqimData);
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"mapToList"]){
        self.eqimListViewController = [segue destinationViewController];
        self.eqimListViewController.delegate =self;
        self.eqimListViewController.type = self.type;
        self.eqimListViewController.days = self.days;
        self.eqimListViewController.sort = @"时间";
        if ([self.esriView.dataType isEqualToString:@"CustData"]) {
            self.eqimListViewController.eqimData = nil;
        }else{
            self.eqimListViewController.eqimData = self.esriView.dataDic;
        }
        self.eqimListViewController.locationGrp = self.esriView.locationGrp;
    }else if ([[segue identifier]  isEqualToString:@"mapToeqimDetails"]){
        self.eqimDetailsViewController = [segue destinationViewController];
        self.eqimDetailsViewController.delegate = self;
        self.eqimDetailsViewController.typeTitle = self.type;
        self.eqimDetailsViewController.agsGraphic = self.detailsAGS;
        self.eqimListViewController.locationGrp = self.esriView.locationGrp;
    }else if ([[segue identifier]  isEqualToString:@"mapTocustom"]){
        self.customViewController = [segue destinationViewController];
        self.customViewController.delegate = self;
        if ([self.esriView.dataType isEqualToString:@"CustData"]) {
            self.customViewController.cusData = self.esriView.dataDic;
        }else{
            self.customViewController.cusData = nil;
        }
    }else if([[segue identifier]  isEqualToString:@"mapTocustDetails"]){
        self.customDetailsViewController = [segue destinationViewController];
        self.customDetailsViewController.delegate = self;
        self.customDetailsViewController.agsGraphic = self.detailsAGS;
    }else if([[segue identifier]  isEqualToString:@"mapTosubject"]){
        self.subjectViewController = [segue destinationViewController];
        self.subjectViewController.queryParams = self.queryParams;
        self.subjectViewController.featureSet = self.featrueSet;
        self.subjectViewController.locationGrp = self.esriView.locationGrp;
        self.subjectViewController.delegate = self;
    }else if([[segue identifier]  isEqualToString:@"mapTosubDetails"]){
        self.subDetailsViewController =[segue destinationViewController];
        self.subDetailsViewController.delegate = self;
        self.subDetailsViewController.queryParams = self.queryParams;
        self.subDetailsViewController.agsGraphic = self.detailsAGS;
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 0) {
        [self performSegueWithIdentifier:@"mapToList" sender:nil];
    }else if(item.tag == 1){
        if ([self.configData getUserRole:CUSTOM]) {
            [self performSegueWithIdentifier:@"mapTocustom" sender:nil];
        }else{
            ALERT(@"没有相关的权限");
        }
        
    }else if(item.tag == 2){
        if ([self.configData getUserRole:PROCUSTOM]) {
        [self performSegueWithIdentifier:@"mapTosubject" sender:nil];
        }else{
            ALERT(@"没有相关的权限");
        }
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)esriViewDetails:(esriView *)controller details:(AGSGraphic *)agsGraphic queryParams:(QueryParams *)queryParams{
    self.detailsAGS = agsGraphic;
    self.queryParams = queryParams;
  
    if ([self.esriView.ghLayer.name isEqualToString:@"EqimLayer"]) {
            [self performSegueWithIdentifier:@"mapToeqimDetails" sender:nil];
    }else if([self.esriView.ghLayer.name isEqualToString:@"CustomLayer"]){
            [self performSegueWithIdentifier:@"mapTocustDetails" sender:nil];
    }else if([self.esriView.ghLayer.name isEqualToString:@"SubLayer"]||[self.esriView.dmsLayer.name isEqualToString:@"SubLayer"]){
            [self performSegueWithIdentifier:@"mapTosubDetails" sender:nil];
    }
}



-(void)subjectViewControllerReturn:(SubjectViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)subjectViewControllerEnter:(SubjectViewController *)controller subData:(AGSFeatureSet *) subData queryParams:(QueryParams *)queryParams{
    self.featrueSet = subData;
    self.queryParams = queryParams;
    [self.esriView addSubjectLayer:subData select:nil queryParams:queryParams];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)subjectViewControllerSelect:(SubjectViewController *)controller subData:(AGSFeatureSet *) subData queryParams:(QueryParams *)queryParams selectCell:(AGSGraphic *)select{
    self.featrueSet = subData;
    self.queryParams = queryParams;
    [self.esriView addSubjectLayer:subData select:select queryParams:queryParams];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)subDetailsViewControllerReturn:(SubDetailsViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)custDetailsViewControllerReturn:(CustDetailsViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)eqimDetailsViewControllerReturn:(EqimDetailsViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)eqimListViewControllerReturn:(EqimListViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)customViewControllerReturn:(CustomViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)customViewControllerEnter:(CustomViewController *)controller custData:(NSDictionary *) custData custType:(NSString *)type{
    
    [self.esriView addCustLayer:custData select:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)eqimListViewControllerEnter:(EqimListViewController *)controller eqimData:(NSArray *) eqimData eqimType:(NSString *)type eqimDays:(NSString *)days{
    
    self.type = type;
    self.days = days;
    //NSLog(@"OK :%@", "222");
    [self.esriView addEqimLayer:eqimData select:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

-(void)eqimListViewControllerSelect:(EqimListViewController *)controller eqimData:(NSDictionary *) eqimData eqimType:(NSString *)type eqimDays:(NSString *)days selectCell:(NSDictionary *)select{
    
    //NSLog(@"OK :%@", "111");
    self.type = type;
    self.days = days;
    [self.esriView addEqimLayer:eqimData select:select];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)customViewControllerSelect:(CustomViewController *)controller custData:(NSDictionary *) custData custType:(NSString *)type selectCell:(NSDictionary *)select{

    [self.esriView addCustLayer:custData select:select];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)returnHome:(id)sender{
    [self.delegate eqimViewControllerReturn:self];
}


@end
