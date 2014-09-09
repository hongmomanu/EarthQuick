//
//  SentimentSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-9-4.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class SentimentSoap;
@protocol SentimentSoapDelegate

-(void)sentimentSoapDidReturn:(SentimentSoap *) p_soap sentimentData:(NSDictionary *) p_sentimentData;
-(void)sentimentSoapFailReturn;
@end

@interface SentimentSoap : NSObject<SOAPToolDelegate>

-(void)getPublicSentiment:(NSString *)p_sentimentType p_page:(NSString *)p_pPageNo;
@property (weak,nonatomic)id<SentimentSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property(assign,nonatomic)BOOL success;
@property (strong,nonatomic) NSString *msg;
@end



