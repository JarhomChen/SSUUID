//
//  JHUUID.m
//  UUID
//
//  Created by 陈家宏 on 16/2/4.
//  Copyright © 2016年 Jarhom. All rights reserved.
//

#import "SSUUID.h"
#import "SSKeychain.h"

#define keychain_service @"uuid"
#define keychain_account @"appuuid"

@implementation SSUUID

+(NSString *)getUUID {
    
    NSString *strUUID = [SSKeychain passwordForService:keychain_service
                                               account:keychain_account];
    NSError *error=nil;
    
    if (strUUID==nil || [strUUID isEqualToString:@"" ] || strUUID.length==0) {
        
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        
        assert(uuid != NULL);
        
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        
        strUUID = [NSString stringWithFormat:@"%@",uuidStr];
        
        BOOL  succcess = [SSKeychain setPassword:strUUID
                                      forService:keychain_service
                                         account:keychain_account
                                           error:&error];
        if(succcess)
        {
            NSLog(@"keychain success 获取的UUID is %@",strUUID);
        }
    }
    
    // BOOL delete = [SSKeychain deletePasswordForService:keychain_service account:keychain_account]; // if (delete) { // // NSLog(@"delete is success"); // } NSLog(@"SSKeychain 获取不变的UUID is %@",strUUID);
    
    return strUUID;
}


@end
