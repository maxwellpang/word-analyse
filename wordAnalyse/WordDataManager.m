//
//  WordDataManager.m
//  wordAnalyse
//
//  Created by pangmengyu on 13-12-14.
//  Copyright (c) 2013年 pangmengyu. All rights reserved.
//

#import "WordDataManager.h"
#import "postfix.h"
#import "AppDelegate.h"


#define BASIC_WORD_LIST_PATH @"/Users/maxwellpang/Project/wordAnalyse/wordAnalyse/BasicWordList.h"



@implementation wordEntity

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ = %ld",self.key,(long)self.count];
}

@end


@implementation WordDataManager

- (instancetype) init
{
    self = [super init];
    if (self) {
        _filterContent = [[NSMutableString alloc] initWithContentsOfFile:BASIC_WORD_LIST_PATH encoding:NSUTF8StringEncoding error:nil];
        _postfixArray = [NSArray arrayWithObjects:POSTFIX_LIST, nil];
        _newKnowedWordList = [[NSMutableString alloc] init];
        
    }
    return self;
    
}

-(void) analyseFile:(NSString*) path
{
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self analyseContent:fileContent];
}

- (void)analyseContent:(NSString *)fileContent
{
    self.currentContent = fileContent;
    NSArray *wordArray = [fileContent componentsSeparatedByCharactersInSet:[NSCharacterSet  whitespaceAndNewlineCharacterSet]];
    self.sentenceArray = [self.currentContent componentsSeparatedByCharactersInSet:[NSCharacterSet  characterSetWithCharactersInString:@".!?"]];
    
    NSMutableDictionary *wordCountDic = [[NSMutableDictionary alloc]initWithCapacity:500];
    
    for (NSString *eachItem in wordArray) {
        NSString *orgWord = [[eachItem stringByTrimmingCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]]lowercaseString];
        if (![orgWord isEqualToString:@""]) {
            NSNumber *count = [wordCountDic objectForKey:orgWord];
            if (nil == count) {
                count = [NSNumber numberWithInteger:1];
            }
            else
            {
                count = [NSNumber numberWithInteger:[count integerValue]+1];
            }
            [wordCountDic setObject:count forKey:orgWord];
        }
    }
    
    NSMutableArray *orgDicArray = [NSMutableArray arrayWithCapacity:6];
    [wordCountDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self isValidWord:key]) {
            if (![self isWordAlreadyKnown:key]) {
                wordEntity *item = [[wordEntity alloc]init];
                item.key = [key lowercaseString];
                item.count = [obj integerValue];
                item.sentences = [self generateRelatedSentence:item.key];
                [orgDicArray addObject:item];
            }
        }
        
    }];
    
    self.dicArray = [NSMutableArray arrayWithArray:[orgDicArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 count] > [obj2 count]) {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedDescending;
        }
    }]];
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    [appDelegate.tableViewMain reloadData];
    
    [appDelegate.listInfo setStringValue:[NSString stringWithFormat:@"words amount = %lu",(unsigned long)[_dicArray count]]];
    
//    NSLog(@"%@ \n %lu",_dicArray,(unsigned long)[_dicArray count]);
}

- (NSArray *)generateRelatedSentence:(NSString *)word
{
    for (NSString *sentence in self.sentenceArray) {
        NSRange wordRange = [sentence rangeOfString:word];
        if (wordRange.location != NSNotFound) {
            return [NSArray arrayWithObject:sentence];
        }
    }

    return nil;
}

-(BOOL) isValidWord:(NSString*) key
{
    if ([key length] > 15) {
        return NO;
    }
    if ([key rangeOfCharacterFromSet:[NSCharacterSet punctuationCharacterSet]].location != NSNotFound) {
        return NO;
    }
    return YES;
}

-(BOOL) isWordAlreadyKnown:(NSString*) key
{
    NSString *word = [key lowercaseString];
    NSInteger wordLen = [word length];
    
    if ([_filterContent rangeOfString:word].location != NSNotFound) {
        return YES;
    }
    
    for (NSString *postfix in _postfixArray) {
        NSInteger fixLen = [postfix length];
        
        if (wordLen > fixLen) {
            NSString *noneFixWord = [word substringToIndex:(wordLen - fixLen)];
            if ([_filterContent rangeOfString:noneFixWord].location != NSNotFound) {
                return YES;
            }
        }
        
    }
    
    return NO;
}

-(void) addWordToFilter:(NSString *)word
{
    NSString *newWord = [NSString stringWithFormat:@"\n%@",word];
    [_filterContent appendString:newWord];
    [_newKnowedWordList appendString:newWord];
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    [appDelegate.listInfo setStringValue:[NSString stringWithFormat:@"words amount = %lu",(unsigned long)[_dicArray count]]];
}

-(void) saveNewKnowedWordToFile
{
    if (![_newKnowedWordList isEqualToString:@""]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:BASIC_WORD_LIST_PATH];
        [fileHandle truncateFileAtOffset:[fileHandle seekToEndOfFile]];
        [fileHandle writeData:[_newKnowedWordList dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
        _newKnowedWordList = [[NSMutableString alloc]initWithString:@""];
    }
 
}

-(NSInteger) rowOfSearchKey:(NSString*) key
{
    NSInteger count = [_dicArray count];
    for (NSInteger i = 0; i < count; i++) {
        wordEntity *item = [_dicArray objectAtIndex:i];
        if ([item.key rangeOfString:key].location != NSNotFound) {
            return i;
        }
    }
    return -1;
}

@end
