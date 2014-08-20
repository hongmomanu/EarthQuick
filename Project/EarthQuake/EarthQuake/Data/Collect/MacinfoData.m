//
//  MacinfoData.m
//  EarthQuake
//
//  Created by hvit-pc on 14-5-26.
//  Copyright (c) 2014年 hvit-pc. All rights reserved.
//

#import "MacinfoData.h"

@implementation MacinfoData
+(id)initDb:(FMDatabase*) db{
    
    MacinfoData *t_MacinfoData = [[MacinfoData alloc] init];
    t_MacinfoData.db = db;
    
    return t_MacinfoData;
}

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
         SaveType:(NSString*)p_saveType{
    self.success = NO;
    if ([self QueryById:p_infoId]) {
        NSLog(@"Tab_Proinformation本地数据存在，修改");
        
        if ([self.db open]) {
            self.success=  [self.db executeUpdate:@"UPDATE Tab_MacInformation SET InfoId = ?,Name = ?,UserId = ?,Department = ?,Longitude = ?,Latitude = ? ,Address = ? ,Description = ? ,Date = ? ,Time = ? ,SaveType = ? WHERE InfoId = ? ",
                            p_infoId, p_name, p_userId,p_department, p_longitude,p_latitude,p_address,p_description,p_date,p_time,p_saveType,p_infoId];
            [self.db close];
        }
    }else{
        if ([self.db open]) {
            NSLog(@"Tab_Proinformation本地数据不存在，插入");
            self.success=  [self.db executeUpdate:@"INSERT INTO Tab_MacInformation (InfoId, Name, UserId,Department, Longitude, Latitude,Address,Description,Date,Time,SaveType) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
                            p_infoId, p_name, p_userId,p_department, p_longitude,p_latitude,p_address,p_description,p_date,p_time,p_saveType];
            [self.db close];
        }
    }
    
    return self.success;
};


-(BOOL)QueryById:(NSString*)p_infoId{
    self.success = NO;
    if ([self.db open]) {
        
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM Tab_MacInformation WHERE InfoId=?",p_infoId];
        
        while ([rs next]) {
            self.dataDic = [rs resultDictionary];
            self.success = YES;
            continue;
        }
        
        [rs close];
        
        [self.db close];
    }else{
        NSLog(@"本地宏观异常获取失败");
    }
    
    return self.success;
};

-(BOOL)UpdateSaveType:(NSString *)p_infoId SaveType:(NSString *)p_saveType{
    self.success = NO;
    if ([self.db open]) {
        self.success=  [self.db executeUpdate:@"UPDATE Tab_MacInformation SET  SaveType = ? WHERE InfoId = ? ",
                        p_saveType,p_infoId];
        [self.db close];
    }else{
        NSLog(@"本地宏观异常修改失败");
    }
    return self.success;
};

-(BOOL)QueryData{
    self.success = NO;
    if ([self.db open]) {
        self.dataArr = [[NSMutableArray alloc]init];
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM Tab_MacInformation ORDER BY SaveType DESC, InfoId DESC"];
        while ([rs next]) {
            [self.dataArr addObject:[rs resultDictionary]];
            self.success = YES;
        }
        [rs close];
        
        [self.db close];
    }else{
        NSLog(@"本地宏观异常获取失败");
    }
    return self.success;
};

-(BOOL)DeleteData:(NSString*)p_infoId{
    
    self.success = NO;
    if ([self.db open]) {
        self.success = [self.db executeUpdate:@"DELETE FROM Tab_MacInformation WHERE InfoId=?",p_infoId];
        [self.db close];
    }else{
        NSLog(@"本地宏观异常删除失败");
    }
    
    return self.success;
}

@end
