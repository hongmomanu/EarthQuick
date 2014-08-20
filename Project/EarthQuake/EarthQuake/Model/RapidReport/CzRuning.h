//
//  CzRuning.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-3.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"
#import "CzRunSoap.h"
#import "MRProgressOverlayView.h"
#import "NSConfigData.h"
#import "CustomIOS7AlertView.h"

@interface CzRuning : UIView<CzRunSoapDelegate>

@property (weak,nonatomic) UIView *supView;
@property (strong,nonatomic) CustomIOS7AlertView *progressView;
@property (strong, nonatomic) CzRunSoap *czRunSoap;
@property (strong,nonatomic) NSConfigData *configData;
@property (strong, nonatomic) NSString *stationId;
-(void)getCzRun:(NSString *)p_moths;

@property (weak, nonatomic) IBOutlet UILabel *runingLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
- (IBAction)dateChange:(id)sender;

@end
