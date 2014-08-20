//
//  CzRunSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-3.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class CzRunSoap;
@protocol CzRunSoapDelegate
-(void)czRunSoapDidReturn:(CzRunSoap *) p_soap;
@end

@interface CzRunSoap : NSObject<SOAPToolDelegate>

-(void)getCzRun:(NSString*)p_stationId
                Months:(NSString*)p_months;

@property (weak,nonatomic)id <CzRunSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
