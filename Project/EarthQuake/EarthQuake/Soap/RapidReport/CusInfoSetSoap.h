//
//  CusInfoSetSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-25.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"

@class CusInfoSetSoap;
@protocol CusInfoSetSoapDelegate

-(void)cusInfoSetSoapDidReturn:(CusInfoSetSoap *) p_cusSoap;
@end
@interface CusInfoSetSoap : NSObject<SOAPToolDelegate>
-(void)SetInfoCus:(NSString *) p_id
           userId:(NSString *) p_userId
             type:(NSString *) p_type
             maxx:(NSString *) p_maxx
             maxy:(NSString *) p_maxy
             minx:(NSString *) p_minx
             miny:(NSString *) p_miny
           mSmall:(NSString *) p_mSmall
           mLarge:(NSString *) p_mLarge
        conserStr:(NSString *) p_conserStr
         province:(NSString *) p_province;

@property (weak,nonatomic)id<CusInfoSetSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property(assign,nonatomic)BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
