//
//  PreInfoSoap.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-28.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
#import "ImageSoap.h"
#import "VideoSoap.h"

@class PreInfoSoap;
@protocol PreInfoSoapDelegate
-(void)preInfoSoapDidReturn:(PreInfoSoap *) p_soap;
@end
@interface PreInfoSoap : NSObject<SOAPToolDelegate>
-(void)uploadDataPre:(NSString*)p_infoId
             EarthId:(NSString*)p_earthId
                Name:(NSString*)p_name
              UserId:(NSString*)p_userId
           Longitude:(NSString*)p_longitude
            Latitude:(NSString*)p_latitude
             Address:(NSString*)p_address
          SIntensity:(NSString*)p_sIntensity
          PIntensity:(NSString*)p_pIntensity
        SDescription:(NSString*)p_sDescription
        PDescription:(NSString*)p_pDescription
                Date:(NSString*)p_date
                Time:(NSString*)p_time;

@property (strong,nonatomic) NSMutableArray *photoArr;
@property (strong,nonatomic) NSMutableArray *videoArr;
@property (strong,nonatomic) NSString *strMoudleType;
@property (strong,nonatomic) NSString *strInfoId;
@property (strong,nonatomic) NSString *strEarthId;
@property NSUInteger photoIndex;
@property NSUInteger videoIndex;

@property (strong,nonatomic) VideoSoap *videoSoap;
@property (strong,nonatomic) ImageSoap *imageSoap;

@property (weak,nonatomic)id <PreInfoSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
