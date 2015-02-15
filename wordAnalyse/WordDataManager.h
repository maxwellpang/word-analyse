//
//  WordDataManager.h
//  wordAnalyse
//
//  Created by pangmengyu on 13-12-14.
//  Copyright (c) 2013年 pangmengyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wordEntity : NSObject
{
    
}

- (NSString *)description;

@property NSString *key;
@property NSInteger count;
@property NSArray *sentences;
@end

@interface WordDataManager : NSObject
{
    NSMutableString *_filterContent;
    NSArray *_postfixArray;
    
    NSMutableString *_newKnowedWordList;
}

@property NSMutableArray *dicArray;
@property NSString *currentContent;
@property NSArray *sentenceArray;

-(void) analyseFile:(NSString*) path;
- (void)analyseContent:(NSString *)fileContent;
-(void) addWordToFilter:(NSString *)word;
-(void) saveNewKnowedWordToFile;
-(NSInteger) rowOfSearchKey:(NSString*) key;

@end
