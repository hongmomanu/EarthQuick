//
//  SubDetailsViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-4-30.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SubDetailsViewController.h"

@interface SubDetailsViewController ()

@end

@implementation SubDetailsViewController

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
    self.navTitle.title = self.queryParams.layerName;
    self.tabView.frame = CGRectMake(self.tabView.frame.origin.x,
                                    self.tabView.frame.origin.y,
                                    self.tabView.frame.size.width,
                                    self.agsGraphic.allAttributes.count * self.tabView.rowHeight);
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    
    self.runView.frame = CGRectMake(self.tabView.frame.origin.x,
                                    self.tabView.frame.origin.y + self.tabView.frame.size.height,
                                    self.tabView.frame.size.width,
                                    self.view.frame.size.height - self.tabView.frame.size.height);
    if ([self.queryParams.layerType isEqualToString:@"czLayer"]) {
        self.czRuning = [[CzRuning alloc] initWithFrame:self.runView.frame];
        self.czRuning.supView = self.view;
        self.czRuning.stationId = [[self.agsGraphic.allAttributes objectForKey:@"Stationid"]description];
        [self.czRuning getCzRun:self.czRuning.dateField.text];
        [self.runView addSubview:self.czRuning];
    }else if([self.queryParams.layerType isEqualToString:@"qzLayer"]){
        self.qzRuning = [[QzRuning alloc] initWithFrame:self.runView.frame];
        self.qzRuning.supView = self.view;
        self.qzRuning.stationId = [[self.agsGraphic.allAttributes objectForKey:@"Stationid"]description];
        [self.qzRuning getQzRunCri];
        [self.runView addSubview:self.qzRuning];
    }

}

//定义tableview 条数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.agsGraphic.allAttributes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SubDetailsCell";
    
    UINib *nib = [UINib nibWithNibName:@"SubDetailsCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    self.subDetailsCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self.subDetailsCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //获得排序
    int order = 0;
    for (int i=0; i<self.queryParams.fieldOrder.count; i++) {
        if ([[self.queryParams.fieldOrder objectAtIndex:i] integerValue] == indexPath.row+1) {
            order = i;
            break;
        }
    }
    
    self.subDetailsCell.key = [self.queryParams.fieldAlias objectAtIndex:order];
    self.subDetailsCell.value = [[self.agsGraphic.allAttributes objectForKey:[self.queryParams.fieldOut objectAtIndex:order]] description];
    return self.subDetailsCell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnMap:(id)sender {
    [self.delegate subDetailsViewControllerReturn:self];
}
@end
