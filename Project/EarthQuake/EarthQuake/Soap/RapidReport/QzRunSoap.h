//
//  QzRunSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-5.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class QzRunSoap;
@protocol QzRunSoapDelegate
-(void)qzRunSoapDidReturn:(QzRunSoap *) p_soap;
@end
@interface QzRunSoap : NSObject<SOAPToolDelegate>
-(void)getQzRun:(NSString*)p_stationId
         ItemId:(NSString*)p_itemId
     InstrtType:(NSString*)p_instrtType
         Months:(NSString*)p_months;

@property (weak,nonatomic)id <QzRunSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
