//
//  VideoSoap.h
//  EarthQuake
//
//  Created by 于华 on 14-8-10.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
#import "ConverUtil.h"
@class VideoSoap;
@protocol VideoSoapDelegate
-(void)videoSoapDidReturn:(VideoSoap *) p_soap;
@end
@interface VideoSoap : NSObject<SOAPToolDelegate>

-(void)UploadVideo:(NSString *)pVideoName
        videoType :(NSString*)pVideoType
         videoFkid:(NSString*)pVideoFkid
           earthId:(NSString*)pEarthId
              data:(NSData*)pData;


@property (weak,nonatomic)id <VideoSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
