//
//  WAWord.h
//  wordAnalyse
//
//  Created by Max on 10/28/14.
//  Copyright (c) 2014 pangmengyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAWord : NSObject<NSCoding>
@property NSString *word;
@property NSInteger count;
@property NSInteger rating;

@end
