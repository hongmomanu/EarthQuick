//
//  ImageSoap.h
//  EarthQuake
//
//  Created by 于华 on 14-8-9.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYSoapTool.h"
#import "NSConvert.h"
#import "NSConfigData.h"
#import "ConverUtil.h"
@class ImageSoap;
@protocol ImageSoapDelegate
-(void)imageSoapDidReturn:(ImageSoap *) p_soap;
@end
@interface ImageSoap : NSObject<SOAPToolDelegate>

-(void)UploadImage:(NSString *)pImageName
      imageType :(NSString*)pImageType
         imgFkid:(NSString*)pImgFkid
         earthId:(NSString*)pEarthId
            data:(NSData*)pData;


@property (weak,nonatomic)id <ImageSoapDelegate> delegate;
@property (strong,nonatomic) SYSoapTool *soap;
@property (strong,nonatomic) NSMutableDictionary *returnDic;
@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSString *msg;
@end
