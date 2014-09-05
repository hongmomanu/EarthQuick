//
//  SentimentDeatiController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-9-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SentimentDeatiController.h"

@interface SentimentDeatiController ()

@end

@implementation SentimentDeatiController

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
    [self.contentView loadHTMLString:[_selDic objectForKey:@"Content"] baseURL:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnToList:(id)sender {
    [self.delegate SentimentDeatiControllerReturn:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
