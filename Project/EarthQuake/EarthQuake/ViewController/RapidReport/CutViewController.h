//
//  CutViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-24.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "esriView.h"
@class CutViewController;
@protocol CutViewControllerDelegate <NSObject>
-(void)cutViewControllerReturn:(CutViewController *)controller ;
-(void)cutViewControllerSave:(CutViewController *)controller envelopeData:(AGSEnvelope *) envelope;
@end

@interface CutViewController : UIViewController<esriViewDelegate>

@property (weak,nonatomic) id <CutViewControllerDelegate> delegate;
@property (strong,nonatomic) esriView *esriView;

@property (weak, nonatomic) IBOutlet UIView *conView;
- (IBAction)returnBarAct:(id)sender;
- (IBAction)saveBarAct:(id)sender;

@end
