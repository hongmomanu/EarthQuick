//
//  CataLogData.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-20.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "CataLogData.h"

@implementation CataLogData

+(id)initDb:(FMDatabase*) db
{
    
    CataLogData *t_CataLogData = [[CataLogData alloc] init];
    t_CataLogData.db = db;
    
    return t_CataLogData;
}
-(BOOL)QueryById:(NSString*)p_id
{
    self.success = NO;
    if ([self.db open]) {
        
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM Tab_Catalog WHERE Id=?",p_id];

        while ([rs next]) {
            self.dataDic = [rs resultDictionary];
            self.success = YES;
            continue;
        }
        
        [rs close];
        
        [self.db close];
    }
    else
    {
        NSLog(@"本地最新标注地震获取失败");
    }
    
    return self.success;
}

-(BOOL)QueryByOtime {
    if ([self.db open]) {
        self.success = NO;
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM Tab_Catalog ORDER BY Id DESC"];
        
        while ([rs next]) {
            self.dataDic = [rs resultDictionary];
            self.success = YES;
            continue;
        }
        
        [rs close];
        
        [self.db close];
    }else{
        NSLog(@"本地最新标注地震获取失败");
    }
    
    return self.success;
}

-(BOOL)InsertData:(NSString*)p_id
              Lat:(NSString*)p_lat
              Lon:(NSString*)p_lon
                M:(NSString*)p_m
            OTime:(NSString *)p_oTime
                locationName:(NSString *)p_locationName{
   
     self.success = NO;
    
        if ([self QueryById:p_id]) {
            NSLog(@"Tab_Catalog本地数据存在，修改");
            
            if ([self.db open]) {
            self.success=  [self.db executeUpdate:@"UPDATE Tab_Catalog SET Id = ?,EpiLat = ?,EpiLon = ?,M = ?,OTime = ?,LocationName = ? WHERE Id = ? ",
                       p_id, p_lat, p_lon, p_m, p_oTime,p_locationName,p_id];
                [self.db close];
            }
        }else{
            if ([self.db open]) {
            NSLog(@"Tab_Catalog本地数据不存在，插入");
            self.success=  [self.db executeUpdate:@"INSERT INTO Tab_Catalog (Id, EpiLat, EpiLon, M, OTime, LocationName) VALUES (?,?,?,?,?,?)",
                       p_id, p_lat, p_lon, p_m, p_oTime,p_locationName];
                [self.db close];
                [self QueryById:p_id];
            }
        }
    
    return self.success;
}



@end
