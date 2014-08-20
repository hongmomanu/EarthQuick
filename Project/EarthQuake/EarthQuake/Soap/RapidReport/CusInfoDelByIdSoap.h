//
//  CusInfoDelByIdSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-16.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class CusInfoDelByIdSoap;
@protocol CusInfoDelByIdSoapDelegate

-(void)cusInfoDelByIdSoapDidReturn:(CusInfoDelByIdSoap *) p_soap;
@end
@interface CusInfoDelByIdSoap : NSObject<SOAPToolDelegate>

-(void)DelInfoCusById:(NSString *) p_id;

@property (weak,nonatomic)id<CusInfoDelByIdSoapDelegate> delegate;
@property (strong,nonatomic) NSIndexPath *cellIndex;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property(assign,nonatomic)BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
