//
//  FeelViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeelColViewController.h"
#import "esriView.h"
@class FeelViewController;
@protocol FeelViewControllerDelegate <NSObject>
-(void)feelViewControllerReturn:(FeelViewController *)controller ;

@end
@interface FeelViewController : UIViewController
@property (weak,nonatomic) id <FeelViewControllerDelegate> delegate;

@property (strong,nonatomic) FeelColViewController *feelColViewController;
@property (strong,nonatomic)  esriView *esriView;

@property (weak, nonatomic) IBOutlet UIView *conView;
- (IBAction)addFeelCol:(id)sender;
- (IBAction)returnToHome:(id)sender;

@end
