//
//  AppDelegate.h
//  wordAnalyse
//
//  Created by pangmengyu on 13-12-14.
//  Copyright (c) 2013年 pangmengyu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WordDataManager;
@class WordBookManager;
@interface AppDelegate : NSObject <NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate,NSPopoverDelegate>
{
}

@property (assign) IBOutlet NSWindow *window;
@property WordDataManager *wordDataMgr;
@property WordBookManager *wordBookMgr;
@property NSPopover *sentencePopover;

@property IBOutlet NSTableView *tableViewMain;
@property IBOutlet NSTextField *listInfo;



- (IBAction)btnRemoveRowClick:(id)sender;
- (IBAction)addToRememberList:(id)sender;
- (IBAction)showSentencePopover:(id)sender;
- (IBAction)openFilePanel:(id)sender;
- (IBAction)saveFilter:(id)sender;
- (IBAction)openLearningBook:(id)sender;
- (IBAction)openArticalPasteSheet:(id)sender;

@end
