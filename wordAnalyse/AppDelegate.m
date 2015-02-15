//
//  AppDelegate.m
//  wordAnalyse
//
//  Created by pangmengyu on 13-12-14.
//  Copyright (c) 2013年 pangmengyu. All rights reserved.
//

#import "AppDelegate.h"
#import "WordDataManager.h"
#import "WordBookManager.h"
#import "WAMainTableCellView.h"
#import "LearningBookWindowController.h"
#import "ArticalPasteWindowController.h"
#import "SentenceViewController.h"

const NSTimeInterval ChangeKeyWordDelay = 0.3;

@implementation AppDelegate
{
    LearningBookWindowController *_learningBookWindowController;
    ArticalPasteWindowController *_pasteWindowController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:nil];
    
    _wordDataMgr = [[WordDataManager alloc]init];
    _wordBookMgr = [WordBookManager sharedManager];
    _pasteWindowController = nil;
}



#pragma mark -notification

-(void) windowWillClose:(NSNotification*)notification
{
    [_wordDataMgr saveNewKnowedWordToFile];
    [_wordBookMgr saveUnsavedRememberListWordToFile];
}

#pragma mark -tableview delegate

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_wordDataMgr.dicArray count];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    WAMainTableCellView *cellView = [_tableViewMain makeViewWithIdentifier:@"MainCell" owner:self];
    cellView.text.stringValue = [[_wordDataMgr.dicArray objectAtIndex:row] description];
    return cellView;
}

- (void)changeKeyWords:(NSString*)keyWord
{    
    NSInteger row = [_wordDataMgr rowOfSearchKey:keyWord];
    if (row >= 0) {
        [_tableViewMain scrollRowToVisible:row];
    }
}

#pragma mark - Popover

- (void)createPopoverWithSentence:(NSString *)sentence
{
    if (self.sentencePopover == nil)
    {
        SentenceViewController *sentenceViewController = [[SentenceViewController alloc] initWithNibName:@"SentenceViewController" bundle:nil];
        
        
        self.sentencePopover = [[NSPopover alloc] init];
        self.sentencePopover.contentViewController = sentenceViewController;

        self.sentencePopover.behavior = NSPopoverBehaviorTransient;
        self.sentencePopover.delegate = self;
    }
    SentenceViewController *viewController = (SentenceViewController *)self.sentencePopover.contentViewController;
    [viewController.textView setString:sentence];
}

#pragma mark -IBAction

- (IBAction)btnRemoveRowClick:(id)sender {
    NSInteger row = [_tableViewMain rowForView:sender];
    if (row != -1) {
        [_wordDataMgr addWordToFilter:[[_wordDataMgr.dicArray objectAtIndex:row] key]];
        [_wordDataMgr.dicArray removeObjectAtIndex:row];
        [_tableViewMain removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:row] withAnimation:NSTableViewAnimationEffectFade];
    }
}

- (IBAction)addToRememberList:(id)sender
{
    NSInteger row = [_tableViewMain rowForView:sender];
    if (row != -1) {
        [_wordBookMgr addWordToRememberList:[[_wordDataMgr.dicArray objectAtIndex:row] key]];
        [_wordDataMgr.dicArray removeObjectAtIndex:row];
        [_tableViewMain removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:row] withAnimation:NSTableViewAnimationEffectFade];
    }
}

- (IBAction)showSentencePopover:(id)sender
{
    NSInteger row = [_tableViewMain rowForView:sender];
    if (row != -1) {
        wordEntity *item = [_wordDataMgr.dicArray objectAtIndex:row];
        if (item.sentences != nil) {
            NSString *sentence = [item.sentences objectAtIndex:0];
            
            [self createPopoverWithSentence:sentence];
            NSButton *targetButton = (NSButton *)sender;
            [self.sentencePopover showRelativeToRect:[targetButton bounds] ofView:sender preferredEdge:CGRectMaxXEdge];
        }
    }
}

- (IBAction)openFilePanel:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setResolvesAliases:YES];
    [openPanel setCanChooseFiles:YES];
    
    NSInteger rv = [openPanel runModal];
    if (rv == NSFileHandlingPanelOKButton) {
		[_wordDataMgr analyseFile:[[[openPanel URL] path] stringByResolvingSymlinksInPath]];
        [_tableViewMain scrollRowToVisible:0];
	}
}

- (IBAction)openLearningBook:(id)sender
{
    if (!_learningBookWindowController) {
        _learningBookWindowController = [[LearningBookWindowController alloc]initWithWindowNibName:@"LearningBookWindowController"];
    }
    [_learningBookWindowController showWindow:nil];
}

- (IBAction)saveFilter:(id)sender {
    [_wordDataMgr saveNewKnowedWordToFile];
    [_wordBookMgr saveUnsavedRememberListWordToFile];
}

- (IBAction)keyWordsDidChange:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeKeyWords:) object:nil];
    [self performSelector:@selector(changeKeyWords:) withObject:[(NSSearchField*)sender stringValue] afterDelay:ChangeKeyWordDelay];
}

- (IBAction)openArticalPasteSheet:(id)sender
{
    if (_pasteWindowController == nil) {
        _pasteWindowController = [[ArticalPasteWindowController alloc]initWithWindowNibName:@"ArticalPasteWindowController"];
    }
    
    [self.window beginSheet:_pasteWindowController.window completionHandler:^(NSModalResponse returnCode) {
        ;
    }];


}

@end
