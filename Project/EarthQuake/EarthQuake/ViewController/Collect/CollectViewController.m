//
//  CollectViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-12.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CollectViewController.h"
#define PROFESSION @"PROFESSION"
#define MACROSCOPIC @"MACROSCOPIC"
#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"浙江地震信息网" message:msg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];[alert show];}


@interface CollectViewController ()

@end

@implementation CollectViewController

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
    
    self.esriView               = [[esriView alloc] initWithFrame:self.conView.frame];
    self.esriView.delegate      = self;
    self.tabBar.selectedItem    = self.tabItemBar;
    self.tabBar.delegate        = self;
    
    [self.conView addSubview:self.esriView];
    [self.esriView locationAct:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"mapTopubcollect"]){
        self.pubViewController              = [segue destinationViewController];
        self.pubViewController.delegate     =self;
        self.pubViewController.locationGP   = self.esriView.locationGrp;
        
    }else if([[segue identifier]  isEqualToString:@"mapToprecollect"]){
        self.preViewController              = [segue destinationViewController];
        self.preViewController.delegate     =self;
        self.preViewController.locationGP   =self.esriView.locationGrp;

    }else if ([[segue identifier]  isEqualToString:@"mapTomaclist"]){
        self.macListViewController              = [segue destinationViewController];
        self.macListViewController.delegate     =self;
        self.macListViewController.locationGP   =self.esriView.locationGrp;
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 0) {        
    }else if(item.tag == 1){
        [self performSegueWithIdentifier:@"mapTopubcollect" sender:nil];
    }else if(item.tag == 2){
         if ([self.configData getUserRole:PROFESSION]) {
             [self performSegueWithIdentifier:@"mapToprecollect" sender:nil];
         }else{
             ALERT(@"没有相关的权限");
         }
    }else if(item.tag == 3){
        if ([self.configData getUserRole:PROFESSION]) {
        [self performSegueWithIdentifier:@"mapTomaclist" sender:nil];
        }else{
            ALERT(@"没有相关的权限");
        }
    }
}

-(void)MacListViewControllerReturn:(MacListViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)PreViewControllerReturn:(PreViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)PubViewControllerReturn:(PubViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToHome:(id)sender {
      [self.delegate CollectViewControllerReturn:self];
}
@end
