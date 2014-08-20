//
//  CustDetailsViewController.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-18.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@class CustDetailsViewController;
@protocol CustDetailsViewControllerDelegate <NSObject>
-(void)custDetailsViewControllerReturn:(CustDetailsViewController *)controller ;

@end

@interface CustDetailsViewController : UIViewController
@property (weak,nonatomic) id <CustDetailsViewControllerDelegate> delegate;
@property (weak, nonatomic) AGSGraphic *agsGraphic;         
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
- (IBAction)returnTomap:(id)sender;

@end
