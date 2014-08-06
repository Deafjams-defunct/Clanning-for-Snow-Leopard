//
//  CLPopoverController.h
//  Clanning
//
//  Created by Dylan Foster on 6/26/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CLCellTableDelegate.h"
#import "CLButton.h"

@interface CLMenuController : NSViewController <NSMenuDelegate>
{
    
    CLCellTableDelegate *_dataSource;
    NSMenu *_menu;
    NSMenuItem *_name;
    NSMenuItem *_clan;
    NSMenuItem *_playTime;
    CLButton *_image;
    CLButton *_professionIcon;
    NSTableView *_originalTableView;
    NSTableView *_compactTableView;
    NSTableView *_originalTableViewWithClan;
    
    @private
    NSInteger _currentRow;
        
}

@property (nonatomic) IBOutlet NSTableView *originalTableView;
@property (nonatomic) IBOutlet NSTableView *compactTableView;
@property (nonatomic) IBOutlet NSTableView *originalTableViewWithClan;

@property (nonatomic) CLCellTableDelegate *dataSource;

@property (nonatomic) IBOutlet NSMenu *menu;
@property (nonatomic) IBOutlet NSMenuItem *name;
@property (nonatomic) IBOutlet NSMenuItem *clan;
@property (nonatomic) IBOutlet NSMenuItem *playTime;
@property (nonatomic) IBOutlet NSButton *image;
@property (nonatomic) IBOutlet NSButton *professionIcon;

- (IBAction)professionIconClicked:(id)sender;
- (IBAction)buttonClicked:(id)sender;

@end
