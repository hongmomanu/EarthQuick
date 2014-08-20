//
//  StationSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-4-28.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//  前兆和测震台站Web serviceS服务调用

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
@class StationSoap;
@protocol StationSoapDelegate
// 查询成功后协议
-(void)stationSoapDidReturn:(StationSoap *) p_stationSoap stationData:(NSDictionary *) p_stationData;
@end
@interface StationSoap : NSObject<SOAPToolDelegate>
-(void)GetStation:(NSString *) p_station; //活的台站数据

@property (strong,nonatomic) NSString *station;
@property (weak,nonatomic)id<StationSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property(assign,nonatomic)BOOL *success;   //是否成功
@property (strong,nonatomic) NSString *msg; //消息
@end
