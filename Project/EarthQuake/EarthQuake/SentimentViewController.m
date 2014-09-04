//
//  SentimentViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-9-3.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SentimentViewController.h"

@interface SentimentViewController ()

@end

@implementation SentimentViewController

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
    NSLog(@"viewDidLoad begin");
    self.sentimentSoap =[[SentimentSoap alloc]init];
    self.sentimentSoap.delegate = self;
    
    self.page=@"1";
    self.type=@"1";
    
    self.sentimentTabView.delegate = self;
    self.sentimentTabView.dataSource = self;
    self.configData = [[NSConfigData alloc]init];
    
    if (self.sentimentData == nil) {
        [self showProView];
        [self.sentimentSoap getPublicSentiment:self.type p_page:self.page];
    }
    // Do any additional setup after loading the view.
}


-(void)showProView{
    //弹出等待友好界面
    self.progressView = [self.configData getAlert:@"加载中..."];
    [self.progressView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//定义tableview 条数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sentimentData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

   
    //CellIdentifier 所指向的字符串必须与故事板中 Table View Cell 对象的Identifier 属性一致
    
      static NSString *CellIdentifier = @"SentimentCell";
      UINib *nib = [UINib nibWithNibName:@"SentimentTabCell" bundle:nil];
      [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
       SentimentTabCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     NSLog(@"hello index %ld",(long)indexPath.row);

    
    NSDictionary *catalogDic = [(NSArray *)self.sentimentData objectAtIndex:indexPath.row];
    NSLog(@"ROW DATA %@",[[catalogDic objectForKey:@"Title"] description]);
      cell.title = [[catalogDic objectForKey:@"Title"] description];
      cell.levelchar = [[catalogDic objectForKey:@"Degreestrchn"] description];
      cell.levelstr = [[catalogDic objectForKey:@"Degreestr"] description];
      cell.otime=[[catalogDic objectForKey:@"Publishtime"] description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.delegate eqimListViewControllerSelect:self eqimData:self.eqimData eqimType:self.type eqimDays:self.days selectCell:[(NSArray *)self.eqimData objectAtIndex:indexPath.row]];
}



-(void)sentimentSoapDidReturn:(SentimentSoap *) p_soap sentimentData:(NSDictionary *)p_data{
    
        [_configData performBlock:^{
            self.sentimentData = (NSArray *)[p_data objectForKey:@"ItabPublicsentimentinfo"];
            NSLog(@"data return %lu" ,(unsigned long)self.sentimentData.count);
            [self.sentimentTabView reloadData];
            [_progressView close];
            [_configData showAlert:@"加载成功"];
        } afterDelay:1.0];
    
    
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
