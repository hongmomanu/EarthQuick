//
//  MacinfoData.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-26.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface MacinfoData : NSObject
+(id)initDb:(FMDatabase*) db;
-(BOOL)InsertData:(NSString*)p_infoId
             Name:(NSString*)p_name
           UserId:(NSString*)p_userId
       Department:(NSString*)p_department
        Longitude:(NSString*)p_longitude
         Latitude:(NSString*)p_latitude
          Address:(NSString*)p_address
     Description:(NSString*)p_description
             Date:(NSString*)p_date
             Time:(NSString*)p_time
         SaveType:(NSString*)p_saveType;

-(BOOL)QueryById:(NSString*)p_infoId;
-(BOOL)UpdateSaveType:(NSString *)p_infoId SaveType:(NSString *)p_saveType;
-(BOOL)QueryData;
-(BOOL)DeleteData:(NSString*)p_infoId;

@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSMutableArray *dataArr;
@property (strong,nonatomic) NSDictionary *dataDic;
@property (strong,nonatomic) FMDatabase *db;
@end
