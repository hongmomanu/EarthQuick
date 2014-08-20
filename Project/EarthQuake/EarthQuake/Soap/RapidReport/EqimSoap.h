//
//  EqimSoap.h
//  RapidReport_P
//
//  Created by hvit-pc on 14-3-30.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class EqimSoap;
@protocol EqimSoapDelegate

-(void)eqimSoapDidReturn:(EqimSoap *) p_soap eqimData:(NSDictionary *) p_eqimData;
@end
@interface EqimSoap : NSObject<SOAPToolDelegate>

-(void)getCataLogEx:(NSString *)p_eqimType Day:(NSString *)p_day;
@property (weak,nonatomic)id<EqimSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property(assign,nonatomic)BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
