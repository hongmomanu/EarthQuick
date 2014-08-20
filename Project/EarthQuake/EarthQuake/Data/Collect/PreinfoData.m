//
//  ProinfoData.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-22.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "PreinfoData.h"

@implementation PreinfoData
+(id)initDb:(FMDatabase*) db{
    
    PreinfoData *t_ProinfoData = [[PreinfoData alloc] init];
    t_ProinfoData.db = db;
    
    return t_ProinfoData;
}


-(BOOL)InsertData:(NSString*)p_infoId
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
             Time:(NSString*)p_time
         SaveType:(NSString*)p_saveType
{

    self.success = NO;
    if ([self QueryById:p_infoId]) {
        NSLog(@"Tab_Proinformation本地数据存在，修改");
        
        if ([self.db open])
        {
            self.success=  [self.db executeUpdate:@"UPDATE Tab_Proinformation SET InfoId = ?,EarthId = ?,Name = ?,UserId = ?,Longitude = ?,Latitude = ? ,Address = ? ,SIntensity = ? ,PIntensity = ? ,SDescription = ? ,PDescription = ? ,Date = ? ,Time = ? ,SaveType = ? WHERE InfoId = ? ",
                            p_infoId, p_earthId, p_name, p_userId, p_longitude,p_latitude,p_address,p_sIntensity,p_pIntensity,p_sDescription,p_pDescription,p_date,p_time,p_saveType,p_infoId];
            [self.db close];
        }
    }else{
        if ([self.db open]) {
            NSLog(@"Tab_Proinformation本地数据不存在，插入");
            self.success=  [self.db executeUpdate:@"INSERT INTO Tab_Proinformation (InfoId, EarthId, Name, UserId, Longitude, Latitude,Address,SIntensity,PIntensity,SDescription,PDescription,Date,Time,SaveType) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                            p_infoId, p_earthId, p_name, p_userId, p_longitude,p_latitude,p_address,p_sIntensity,p_pIntensity,p_sDescription,p_pDescription,p_date,p_time,p_saveType];
            [self.db close];
        }
    }
    
    return self.success;
};


-(BOOL)QueryById:(NSString*)p_infoId{
    self.success = NO;
    if ([self.db open]) {
        
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM Tab_Proinformation WHERE InfoId=?",p_infoId];
        
        while ([rs next]) {
            self.dataDic = [rs resultDictionary];
            self.success = YES;
            continue;
        }
        
        [rs close];
        
        [self.db close];
    }else{
        NSLog(@"本地现场采集获取失败");
    }
    
    return self.success;
};

-(BOOL)UpdateSaveType:(NSString *)p_infoId SaveType:(NSString *)p_saveType{
    self.success = NO;
    if ([self.db open]) {
        self.success=  [self.db executeUpdate:@"UPDATE Tab_Proinformation SET  SaveType = ? WHERE InfoId = ? ",
                        p_saveType,p_infoId];
        [self.db close];
    }else{
        NSLog(@"本地宏观异常获取失败");
    }
    return self.success;
};

-(BOOL)QueryData{
    self.success = NO;
    if ([self.db open]) {
       self.dataArr = [[NSMutableArray alloc]init];
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM Tab_Proinformation ORDER BY SaveType DESC, InfoId DESC"];
        while ([rs next]) {
            [self.dataArr addObject:[rs resultDictionary]];
            self.success = YES;
        }
        [rs close];
        
        [self.db close];
    }else{
        NSLog(@"本地现场采集获取失败");
    }
    
    return self.success;
};

-(BOOL)DeleteData:(NSString*)p_infoId{
    
    self.success = NO;
    if ([self.db open]) {
        self.success = [self.db executeUpdate:@"DELETE FROM Tab_Proinformation WHERE InfoId=?",p_infoId];
        [self.db close];
    }else{
        NSLog(@"本地现场采集删除失败");
    }
    
    return self.success;
}
@end
