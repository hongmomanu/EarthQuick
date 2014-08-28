//
//  ViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-8.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.configData =[[NSConfigData alloc] init];
    [self.configData CreateMyDb];
    self.userDic = [self.configData getUserDic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"homeToin"]){
        self.logininViewController = [segue destinationViewController];
        self.logininViewController.delegate =self;
        
    }else if([[segue identifier]  isEqualToString:@"homeTooff"]){
        self.loginoffViewController = [segue destinationViewController];
        self.loginoffViewController.delegate =self;
    }else if([[segue identifier]  isEqualToString:@"homeTorapidReport"]){
        self.eqimViewController = [segue destinationViewController];
        self.eqimViewController.delegate = self;
    }else if([[segue identifier]  isEqualToString:@"homeTocollect"]){
        self.collectViewController = [segue destinationViewController];
        self.collectViewController.delegate = self;
    }else if([[segue identifier]  isEqualToString:@"homeTofeel"]){
        self.feelViewController = [segue destinationViewController];
        self.feelViewController.delegate = self;
    }
}

- (IBAction)userBtnAct:(id)sender {
    if([self.userDic objectForKey:@"Userpwd"]){
        if([[self.userDic objectForKey:@"Userpwd"] isEqualToString:@""]){
            [self performSegueWithIdentifier:@"homeTooff" sender:nil];
        }else{
            [self performSegueWithIdentifier:@"homeToin" sender:nil];
        }
    }else{
        [self performSegueWithIdentifier:@"homeTooff" sender:nil];
    }
    
}

- (IBAction)rapidReportAct:(id)sender {
     [self performSegueWithIdentifier:@"homeTorapidReport" sender:nil];
}

- (IBAction)collectAct:(id)sender {
     [self performSegueWithIdentifier:@"homeTocollect" sender:nil];
}

- (IBAction)feelAct:(id)sender {
    [self performSegueWithIdentifier:@"homeTofeel" sender:nil];
}

- (IBAction)sentimentAct:(id)sender {
    [self performSegueWithIdentifier:@"homeTofeel" sender:nil];
}


-(void)feelViewControllerReturn:(FeelViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)CollectViewControllerReturn:(CollectViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)eqimViewControllerReturn:(EqimViewController *)controller {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)loginoffViewControllerReturn:(LoginoffViewController *)controller {
    [self viewDidLoad];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)logininViewControllerReturn:(LogininViewController *)controller {
    [self viewDidLoad];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
