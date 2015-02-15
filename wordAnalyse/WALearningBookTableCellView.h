//
//  WALearningBookTableCellView.h
//  wordAnalyse
//
//  Created by Max on 10/30/14.
//  Copyright (c) 2014 pangmengyu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WALearningBookTableCellView : NSTableCellView
@property IBOutlet NSTextField *text;
@property IBOutlet NSLevelIndicator *levelIndicator;
@end
