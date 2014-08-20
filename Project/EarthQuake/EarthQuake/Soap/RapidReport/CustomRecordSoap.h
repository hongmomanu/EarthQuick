//
//  CustomRecordSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-17.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class CustomRecordSoap;
@protocol CustomRecordSoapDelegate

-(void)customRecordSoapDidReturn:(CustomRecordSoap *) p_loginSoap;
@end

@interface CustomRecordSoap : NSObject<SOAPToolDelegate>
-(void)GetRecordCus:(NSString *) p_userName
             currentPageIndex:(NSString *)p_currentPageIndex
           pageSize:(NSString *)p_pageSize;

@property (weak,nonatomic)id<CustomRecordSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property(assign,nonatomic)BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
