//
//  SentimentViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-9-3.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SentimentSoap.h"
#import "SentimentTabCell.h"
#import "CustomIOS7AlertView.h"
#import "NSConfigData.h"
#import "SentimentDeatiController.h"



@class SentimentViewController;
@protocol SentimentViewControllerDelegate <NSObject>

-(void)sentimentViewControllerReturn:(SentimentViewController *)controller ;

@end


@interface SentimentViewController:UIViewController<SentimentSoapDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak,nonatomic) id <SentimentViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *sentimentTabView;
@property (nonatomic, strong) NSMutableArray *sentimentData;
@property (strong,nonatomic) SentimentSoap *sentimentSoap;
@property (strong,nonatomic) SentimentDeatiController *sentimentDeatiController;
@property (nonatomic, weak) NSString *type;
@property (nonatomic, weak) NSString *page;
@property (strong,nonatomic) NSDictionary *selDic;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) NSConfigData *configData;

@end
