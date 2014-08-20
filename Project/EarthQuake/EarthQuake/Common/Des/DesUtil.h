//
//  DesUtil.h
//  RootViewController
//
//  Created by XmL on 13-3-19.
//  Copyright (c) 2013年 XmL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesUtil : NSObject
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
+ (NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key ;
+(NSString *) parseByte2HexString:(Byte *) bytes;
+(NSString *) parseByteArray2HexString:(Byte[]) bytes;
@end
