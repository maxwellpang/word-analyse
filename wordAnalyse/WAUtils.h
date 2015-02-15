//
//  WAUtils.h
//  Swiftly
//
//  Created by maxwell pang on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAUtils : NSObject

/**
 * @brief 保存数据到指定的目录
 *
 */
+ (void)saveData:(NSDictionary *)dic filePath:(NSString*)filePath;

/**
 * @brief 从指定的目录读取指定文件
 *
 */
+ (NSDictionary *)readDataFromPath:(NSString *)filePath;

@end
