//
//  WordsBook.m
//  wordAnalyse
//
//  Created by Max on 10/28/14.
//  Copyright (c) 2014 pangmengyu. All rights reserved.
//

#import "WordsBook.h"
#import "WAWord.h"
#import "WAUtils.h"

@implementation WordsBook


- (instancetype)initWithFilePath:(NSString *)filePath
{
    self = [super init];
    if (self) {
        _wordDictionary = [[NSMutableDictionary alloc] initWithDictionary:[WAUtils readDataFromPath:filePath]];
        if (!_wordDictionary) {
            _wordDictionary = [[NSMutableDictionary alloc]initWithCapacity:10];
        }
    }
    return self;
}


- (NSUInteger)wordCount
{
    return [_wordDictionary count];
}

- (void)addWord:(NSString *)word
{
    WAWord *newWord =[_wordDictionary objectForKey:word];
    if (newWord) {
        newWord.count++;
    }
    else
    {
        newWord = [[WAWord alloc]init];
        newWord.word = word;
        newWord.count = 1;
        newWord.rating = 0;
    }
    [_wordDictionary setObject:newWord forKey:word];
}

- (void)delWord:(NSString *)word
{
    [_wordDictionary removeObjectForKey:word];
}

- (void)saveToFile:(NSString *)filePath
{
    [WAUtils saveData:_wordDictionary filePath:filePath];
}


@end
