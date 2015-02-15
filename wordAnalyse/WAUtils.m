
//
//  SCPreferenceUtils.m
//  Swiftly
//
//  Created by maxwell pang on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WAUtils.h"

@implementation WAUtils

+ (void)saveData:(NSDictionary *)dic filePath:(NSString*)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSAssert([fileManager fileExistsAtPath:filePath], @"file path not exsit");
    
    [NSKeyedArchiver archiveRootObject:dic toFile:filePath];
    
    return;
}


+ (NSDictionary *)readDataFromPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    return nil;
}

@end
