//
//  SentimentViewController.m
//  EarthQuake
//
//  Created by hvit-pc on 14-9-3.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "SentimentViewController.h"
#define PROSENTIMENT @"YQZD"

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
    
    self.sentimentSoap =[[SentimentSoap alloc]init];
    self.sentimentSoap.delegate = self;
    
    self.page=@"1";
    self.type=@"0";
    
    self.sentimentTabView.delegate = self;
    self.sentimentTabView.dataSource = self;
    self.configData = [[NSConfigData alloc]init];
    
    if (self.sentimentData == nil) {
        [self showProView];
        [self.sentimentSoap getPublicSentiment:self.type p_page:self.page];
    }
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]  isEqualToString:@"SentimentToDetai"]){
        self.sentimentDeatiController = [segue destinationViewController];
        self.sentimentDeatiController.selDic = self.selDic;
        self.sentimentDeatiController.delegate = self;
    }
    
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
    
    return self.sentimentData.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

   
    //CellIdentifier 所指向的字符串必须与故事板中 Table View Cell 对象的Identifier 属性一致
    
      static NSString *CellIdentifier = @"SentimentCell";
      UINib *nib = [UINib nibWithNibName:@"SentimentTabCell" bundle:nil];
      [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
        if([indexPath row] == [self.sentimentData count])
        {
            //新建一个单元格, 并且将其样式调整成我们需要的样子.
            
            cell=[[UITableViewCell alloc] initWithFrame:CGRectZero
                                        reuseIdentifier:@"LoadMoreIdentifier"];
            cell.font = [UIFont boldSystemFontOfSize:13];
            
            cell.textLabel.text = @"读取更多...";
            return cell;
        }
        else
        {
            //其它单元格的初始化事件. 自定义单元格的读取, 或者是单元格的设置等.
            SentimentTabCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            NSDictionary *catalogDic = [(NSArray *)self.sentimentData objectAtIndex:indexPath.row];
            
            cell.title = [[catalogDic objectForKey:@"Title"] description];
            cell.evaluatestr=[[catalogDic objectForKey:@"Evaluatestr"] description];
            cell.levelchar = [[catalogDic objectForKey:@"Degreestrchn"] description];
            cell.levelstr = [[catalogDic objectForKey:@"Degreestr"] description];
            cell.otime=[[catalogDic objectForKey:@"Publishtime"] description];
            
            return cell;
        }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.delegate eqimListViewControllerSelect:self eqimData:self.eqimData eqimType:self.type eqimDays:self.days selectCell:[(NSArray *)self.eqimData objectAtIndex:indexPath.row]];
    
    if([indexPath row] == [self.sentimentData count])
    {
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath];
        loadMoreCell.textLabel.text=@"正在读取更信息 …";
        [self loadMore];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    else
    {
        _selDic = [(NSArray *)_sentimentData objectAtIndex:indexPath.row];
        
        
        [self performSegueWithIdentifier:@"SentimentToDetai" sender:nil];
    }
    
    
    
}

-(void)loadMore
{   //当你按下这个按钮的时候, 意味着你需要看下一页了, 因此当前页码加1
   
    //NSLog(@"1212121 %@",[self.configData getUserDic]);
    int currentPage=[self.page intValue] ;
    currentPage++;
    self.page=[@(currentPage) stringValue];
    [self showProView];
    [self.sentimentSoap getPublicSentiment:self.type p_page:self.page];
    
    
}
-(void) appendTableWith:(NSMutableArray *)data
{   //将loadMore中的NSMutableArray添加到原来的数据源listData中.
   
    for (int i=0;i<[data count];i++) {
        [self.sentimentData addObject:[data objectAtIndex:i]];
    }
   
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];

    for (int ind = 0; ind < [data count]; ind++) {
        NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[self.sentimentData indexOfObject:[data objectAtIndex:ind]] inSection:0];
        [insertIndexPaths addObject:newPath];
    }

    //重新调用UITableView的方法, 来生成行.
    [self.sentimentTabView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
}

-(void)sentimentSoapFailReturn{
    [_configData performBlock:^{
        
        [_progressView close];
        [_configData showAlert:@"加载失败"];
        
        
        
    } afterDelay:1.0];


}
-(void)sentimentSoapDidReturn:(SentimentSoap *) p_soap sentimentData:(NSDictionary *)p_data{
    

        [_configData performBlock:^{
            if([self.sentimentData count]==0){
                
                self.sentimentData = [NSMutableArray arrayWithArray:[p_data objectForKey:@"ItabPublicsentimentinfo"]];
                
                [self.sentimentTabView reloadData];
            
            }else{
                [self appendTableWith:[NSMutableArray arrayWithArray:[p_data objectForKey:@"ItabPublicsentimentinfo"]]];
            }
            
                [_progressView close];
                [_configData showAlert:@"加载成功"];
            
            
            
        } afterDelay:1.0];
    
    
}

-(void)SentimentDeatiControllerReturn:(SentimentDeatiController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
