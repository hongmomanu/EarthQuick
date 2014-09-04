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



@class SentimentViewController;
@protocol SentimentViewControllerDelegate <NSObject>

-(void)sentimentViewControllerReturn:(SentimentViewController *)controller ;

@end


@interface SentimentViewController : UIViewController<SentimentSoapDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak,nonatomic) id <SentimentViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *sentimentTabView;
@property (nonatomic, strong) NSDictionary *sentimentData;
@property (strong,nonatomic) SentimentSoap *sentimentSoap;
@property (nonatomic, weak) NSString *type;
@property (nonatomic, weak) NSString *page;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) NSConfigData *configData;

@end
