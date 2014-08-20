//
//  CustomInfoSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-25.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class CustomRecordSoap;
@protocol CustomInfoSoapDelegate

-(void)customInfoSoapDidReturn:(CustomRecordSoap *) p_loginSoap cusData:(NSDictionary *) p_cusData;
@end
@interface CustomInfoSoap : NSObject<SOAPToolDelegate>
-(void)GetInfoCus:(NSString *) p_userId
 infoType:(NSString *) p_infoType;

@property (weak,nonatomic)id<CustomInfoSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property(assign,nonatomic)BOOL *success;
@property (strong,nonatomic) NSString *msg;
@end
