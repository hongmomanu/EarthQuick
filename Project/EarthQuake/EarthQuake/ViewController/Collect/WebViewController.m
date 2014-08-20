//
//  WebViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-14.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cysj13" ofType:@"html"];
    
    NSURL *url=[NSURL fileURLWithPath:path];
    
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnTopub:(id)sender {
    [self.delegate WebViewControllerReturn:self];
}
@end
