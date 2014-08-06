//
//  CLPreferencesWindowController.h
//  Clanning
//
//  Created by Dylan Foster on 6/26/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CLGrowlDelegate.h"
#import "CLPreferenceView.h"
#import "CLMainWindowController.h"

@interface CLPreferencesWindowController : NSWindowController <NSWindowDelegate>
{
    
    NSWindow *_mainWindow;
    NSView *_originalView;
    NSView *_compactView;
    NSView *_originalViewWithClan;
    NSView *_iClanView;
    
    NSTableView *_originalTable;
    NSTableView *_compactTable;
    NSTableView *_originalTableClan;
    NSTableView *_iClanTable;
    
    CLPreferenceView *_generalView;
    CLPreferenceView *_notificationsView;
    CLPreferenceView *_VIPView;
    
    NSTableView *_vipTable;
    
    CLGrowlDelegate *_growlDelegate;
    CLMainWindowController *_mainWindowController;
    
}

@property NSWindow *mainWindow;

@property (unsafe_unretained) NSView *originalView;
@property (nonatomic) NSView *compactView;
@property (nonatomic) NSView *originalViewWithClan;
@property (nonatomic) NSView *iClanView;

@property (nonatomic) NSTableView *originalTable;
@property (nonatomic) NSTableView *compactTable;
@property (nonatomic) NSTableView *originalTableWithClan;
@property (nonatomic) NSTableView *iClanTable;

@property (strong) IBOutlet CLPreferenceView *generalView;
@property (strong) IBOutlet CLPreferenceView *notificationsView;
@property (strong) IBOutlet CLPreferenceView *VIPView;

@property (strong) IBOutlet NSTableView *vipTable;

@property (nonatomic) CLGrowlDelegate *growlDelegate;
@property (nonatomic, strong) CLMainWindowController *mainWindowController;

- (IBAction)generalButtonPressed:(id)sender;
- (IBAction)notificationsButtonPressed:(id)sender;
- (IBAction)VIPbuttonPressed:(id)sender;

- (IBAction)viewPreferenceChanged:(id)sender;

@end
