//
//  CataLogData.h
//  EarthQuake
//
//  Created by hvit-pc on 14-5-20.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface CataLogData : NSObject
+(id)initDb:(FMDatabase*) db;
-(BOOL)QueryById:(NSString*)p_id ;
-(BOOL)QueryByOtime ;
-(BOOL)InsertData:(NSString*)p_id
              Lat:(NSString*)p_lat
              Lon:(NSString*)p_lon
                M:(NSString*)p_m
            OTime:(NSString *)p_oTime
     locationName:(NSString *)p_locationName;

@property (assign,nonatomic) BOOL success;
@property (strong,nonatomic) NSDictionary *dataDic;
@property (strong,nonatomic) FMDatabase *db;

@end
