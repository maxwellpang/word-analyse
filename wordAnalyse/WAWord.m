//
//  WAWord.m
//  wordAnalyse
//
//  Created by Max on 10/28/14.
//  Copyright (c) 2014 pangmengyu. All rights reserved.
//

#import "WAWord.h"

@implementation WAWord

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_word forKey:@"word"];
    [coder encodeObject:@(_count) forKey:@"wordCount"];
    [coder encodeObject:@(_rating) forKey:@"wordRating"];
}

- (id) initWithCoder:(NSCoder *)coder
{
    _word = [coder decodeObjectForKey:@"word"];
    _count = [[coder decodeObjectForKey:@"wordCount"] integerValue];
    _rating = [[coder decodeObjectForKey:@"wordRating"] integerValue];
    
    return self;
}


@end
