//
//  CLPreferencesWindowController.m
//  Clanning
//
//  Created by Dylan Foster on 6/26/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import "CLPreferencesWindowController.h"
#import "CLVIPDataSource.h"
#import "Constants.h"

@interface CLPreferencesWindowController()

- (void)updateNotificationSettings:(NSUInteger)setting;

@end

@implementation CLPreferencesWindowController
@synthesize generalView = _generalView;
@synthesize notificationsView = _notificationsView;
@synthesize originalView = _originalView;
@synthesize compactView = _compactView;
@synthesize originalTable = _originalTable;
@synthesize compactTable = _compactTable;
@synthesize originalTableWithClan = _originalTableClan;
@synthesize originalViewWithClan = _originalViewWithClan;
@synthesize iClanView = _iClanView;
@synthesize iClanTable = _iClanTable;
@synthesize mainWindow = _mainWindow;
@synthesize growlDelegate = _growlDelegate;

- (void)windowDidLoad
{
    
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    _generalView.identifier = @"general";
    _notificationsView.identifier = @"notifications";
    
    [self.window setDelegate:self];

    [self.window setContentView:_generalView];
    
    self.vipTable.dataSource = [CLVIPDataSource sharedVIPDataSource];
    self.vipTable.delegate = [CLVIPDataSource sharedVIPDataSource];
    
    [self.vipTable reloadData];
    
}

/**
 Saves selection of original or compact view.
 */
- (IBAction)viewPreferenceChanged:(id)sender
{
    
    //Set preference
    if ( [[sender identifier] isEqualToString:@"clanInOriginalView"] )
    {
        
        [NSUserDefaults.standardUserDefaults setBool:([sender state] == 1 ? YES : NO) forKey:@"clanInOriginalView"];
        
    }
    else
    {
        
        [NSUserDefaults.standardUserDefaults setValue:[sender title] forKey:@"viewType"];
        
    }
    
    //Update view
    [self.mainWindowController displayProperTableWithResize:YES];
    [self.mainWindowController update];
    
}

/**
 Displays a notification giving example notification when sticky checkbox is toggled
 */
- (IBAction)checkBoxToggled:(id)sender
{
    
    //Display sticky notification
    if ( [sender state] == NSOnState ) { [self.growlDelegate displayStickyExampleNotification]; }
    //Display non-sticky notification
    else { [self.growlDelegate displayNonStickyExampleNotification]; }
    
}

/**
 Window view shifts to general tab
 */
- (IBAction)generalButtonPressed:(id)sender
{
    
    [self.window setContentView:_generalView];
    
    NSRect rect = self.window.frame;
    
    rect.origin.y += rect.size.height - 150;
    
    rect.size.width = 240;
    rect.size.height = 150;
    
    [self.window setFrame:rect display:YES animate:YES];
    
}

/**
 Window shifts to notifications tab
 */
- (IBAction)notificationsButtonPressed:(id)sender
{
    
    [self.window setContentView:_notificationsView];
    
    NSRect rect = self.window.frame;
    
    rect.origin.y += rect.size.height - 389;
    
    rect.size.width = 431;
    rect.size.height = 389;
    
    [self.window setFrame:rect display:YES animate:YES];
    
}

- (IBAction)VIPbuttonPressed:(id)sender
{
    
    [self.window setContentView:_VIPView];
    
    NSRect rect = self.window.frame;
    
    rect.origin.y += rect.size.height - 336;
    
    rect.size.width = 317;
    rect.size.height = 336;
    
    [self.window setFrame:rect display:YES animate:YES];
    
    [self.vipTable reloadData];
    
}

@end
