//
//  LearningBookWindowController.m
//  wordAnalyse
//
//  Created by Max on 10/30/14.
//  Copyright (c) 2014 pangmengyu. All rights reserved.
//

#import "LearningBookWindowController.h"
#import "WordBookManager.h"
#import "WordsBook.h"
#import "WAWord.h"
#import "WALearningBookTableCellView.h"

@interface LearningBookWindowController ()
{
    WordBookManager *_wordBookManager;
    NSMutableArray *_wordsArray;
}
@property IBOutlet NSTableView *learningBookTableView;

- (IBAction)rateWord:(id)sender;
- (IBAction)deleteSelectionWord:(id)sender;

@end

@implementation LearningBookWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    _wordsArray = [[NSMutableArray alloc] initWithCapacity:10];
    _wordBookManager = [WordBookManager sharedManager];
    [self generateWordsArray];
    [_learningBookTableView reloadData];
}

- (void)generateWordsArray
{
    [_wordsArray removeAllObjects];
    [_wordBookManager.learningWordBook.wordDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [_wordsArray addObject:obj];
    }];
    
}

#pragma mark - IBAction
- (IBAction)rateWord:(id)sender
{
    NSInteger row = [_learningBookTableView rowForView:sender];
    if (row != -1) {
        WAWord *currentWord = [_wordsArray objectAtIndex:row];
        currentWord.rating = [sender integerValue];
        [_wordBookManager.learningWordBook.wordDictionary setObject:currentWord forKey:currentWord.word];
    }
}

- (IBAction)deleteSelectionWord:(id)sender
{
    NSInteger row = [_learningBookTableView rowForView:sender];
    if (row != -1) {
        WAWord *currentWord = [_wordsArray objectAtIndex:row];
        [_wordsArray removeObject:currentWord];
        [_wordBookManager.learningWordBook.wordDictionary removeObjectForKey:currentWord.word];
        [_learningBookTableView reloadData];
    }
}

#pragma mark -tableview delegate

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_wordsArray count];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    WALearningBookTableCellView *cellView = [_learningBookTableView makeViewWithIdentifier:@"WordCell" owner:self];
    cellView.text.stringValue = [[_wordsArray objectAtIndex:row] word];
    [cellView.levelIndicator setIntegerValue:[[_wordsArray objectAtIndex:row] rating]];
    return cellView;
}

@end
