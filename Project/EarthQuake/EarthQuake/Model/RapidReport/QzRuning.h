//
//  QzRuning.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-4.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"
#import "MRProgressOverlayView.h"
#import "NSConfigData.h"
#import "QzRunCriSoap.h"
#import "QzRunSoap.h"
#import "CustomIOS7AlertView.h"

@interface QzRuning : UIView<QzRunCriSoapDelegate>

@property (weak,nonatomic) UIView *supView;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong,nonatomic) NSString *stationId;
@property (strong,nonatomic) QzRunCriSoap *qzRunCriSoap;
@property (strong,nonatomic) QzRunSoap *qzRunSoap;

@property (strong,nonatomic) NSMutableArray *itemArr;
@property (strong,nonatomic) NSMutableArray *itemStrArr;
@property (strong,nonatomic) NSMutableArray *inStrArr;

-(void)getQzRunCri;
@property (weak, nonatomic) IBOutlet UILabel *runLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullLabel;
@property (weak, nonatomic) IBOutlet UITextField *itemField;
@property (weak, nonatomic) IBOutlet UITextField *instrField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;

- (IBAction)itemChange:(id)sender;
- (IBAction)instrChange:(id)sender;
- (IBAction)dateChange:(id)sender;

@end
