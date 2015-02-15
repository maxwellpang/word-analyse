//
//  WordBookManager.h
//  wordAnalyse
//
//  Created by Max on 10/30/14.
//  Copyright (c) 2014 pangmengyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WordsBook;
@interface WordBookManager : NSObject
{
    WordsBook *_learningWordBook;
    NSMutableString *_learningContent;
}

@property WordsBook *learningWordBook;

+ (WordBookManager *)sharedManager;

-(void) addWordToRememberList:(NSString *)word;
-(void) saveUnsavedRememberListWordToFile;

@end
