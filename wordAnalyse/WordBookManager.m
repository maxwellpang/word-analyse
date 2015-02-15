//
//  WordBookManager.m
//  wordAnalyse
//
//  Created by Max on 10/30/14.
//  Copyright (c) 2014 pangmengyu. All rights reserved.
//

#import "WordBookManager.h"
#import "WordsBook.h"

#define LEARNING_BOOK_PLIST @"/Users/maxwellpang/Project/wordAnalyse/wordAnalyse/learningBook.plist"

@implementation WordBookManager

+ (WordBookManager *)sharedManager
{
    static WordBookManager *s_WordBookManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_WordBookManager = [[WordBookManager alloc] init];
    });
    
    return s_WordBookManager;
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        _learningWordBook = [[WordsBook alloc]initWithFilePath:LEARNING_BOOK_PLIST];
        
    }
    return self;
    
}

- (void)addWordToRememberList:(NSString *)word
{
    [_learningWordBook addWord:word];
}

- (void)saveUnsavedRememberListWordToFile
{
    [_learningWordBook saveToFile:LEARNING_BOOK_PLIST];
    
}

@end
