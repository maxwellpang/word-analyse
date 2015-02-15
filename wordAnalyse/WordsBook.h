//
//  WordsBook.h
//  wordAnalyse
//
//  Created by Max on 10/28/14.
//  Copyright (c) 2014 pangmengyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordsBook : NSObject
{
    NSMutableDictionary *_wordDictionary;
}

@property NSMutableDictionary *wordDictionary;

- (instancetype)initWithFilePath:(NSString *)filePath;

- (void)addWord:(NSString *)word;
- (void)delWord:(NSString *)word;
- (NSUInteger)wordCount;

- (void)saveToFile:(NSString *)filePath;

@end
