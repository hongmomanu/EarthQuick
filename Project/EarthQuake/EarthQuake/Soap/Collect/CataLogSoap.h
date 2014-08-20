//
//  CataLogSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-20.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"

@class CataLogSoap;
@protocol CataLogSoapDelegate

-(void)cataLogSoapDidReturn:(CataLogSoap *) p_soap data:(NSDictionary *)p_cataData;
@end

@interface CataLogSoap : NSObject<SOAPToolDelegate>
-(void)getData;

@property (weak,nonatomic)id<CataLogSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;

@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property (assign,nonatomic) BOOL *success;
@property (strong,nonatomic) NSString *msg;
@end
