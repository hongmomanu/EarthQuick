//
//  QzRunCriSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-4.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class QzRunCriSoap;
@protocol QzRunCriSoapDelegate
-(void)qzRunCriSoapDidReturn:(QzRunCriSoap *) p_soap;
@end
@interface QzRunCriSoap : NSObject<SOAPToolDelegate>


-(void)getQzRunCri:(NSString*)p_stationId;

@property (weak,nonatomic)id <QzRunCriSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
