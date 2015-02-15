//
//  ArticalPasteWindowController.m
//  wordAnalyse
//
//  Created by Max on 14/11/26.
//  Copyright (c) 2014年 pangmengyu. All rights reserved.
//

#import "ArticalPasteWindowController.h"
#import "WordDataManager.h"
#import "AppDelegate.h"

@interface ArticalPasteWindowController ()
{
    IBOutlet NSTextView *_contentTextView;
}

@end

@implementation ArticalPasteWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(IBAction)doAnalyse:(id)sender
{
    [[(AppDelegate*)[NSApp delegate] wordDataMgr] analyseContent:[_contentTextView string]];
    [self close];
}

@end
