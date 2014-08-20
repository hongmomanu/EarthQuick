//
//  CusInfoCusByUserId.h
//  EarthQuake
//
//  Created by hvit-pc on 14-6-13.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"

@class CusInfoCusByUserIdSoap;
@protocol CusInfoCusByUserIdSoapDelegate

-(void)cusInfoCusByUserIdSoapDidReturn:(CusInfoCusByUserIdSoap *) p_soap;
@end
@interface CusInfoCusByUserIdSoap : NSObject<SOAPToolDelegate>
-(void)getInfoCusByUserId:(NSString *) p_userId;

@property (weak,nonatomic)id<CusInfoCusByUserIdSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property(assign,nonatomic)BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
