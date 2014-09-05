//
//  SentimentDeatiController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-9-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SentimentDeatiController;
@protocol SentimentDeatiControllerDelegate <NSObject>
-(void)SentimentDeatiControllerReturn:(SentimentDeatiController *)controller ;



-(void)SentimentDeatiControllerSelect:(SentimentDeatiController *)controller sentimentData:(NSDictionary *) sentimentData  selectCell:(NSDictionary *)select;
@end



@interface SentimentDeatiController : UIViewController

@property (strong,nonatomic) SentimentDeatiController *sentimentDeatiController;
@property (weak,nonatomic) id <SentimentDeatiControllerDelegate> delegate;
@property (strong,nonatomic) NSDictionary *selDic;
@property (weak, nonatomic) IBOutlet UIWebView *contentView;

- (IBAction)returnToList:(id)sender;


@end
