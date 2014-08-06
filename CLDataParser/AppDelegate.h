//
//  AppDelegate.h
//  CLDataParser
//
//  Created by Dylan Foster on 12/23/11.
//  Copyright (c) 2011 Finger Lakes Community College. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CLCellTableDelegate.h"
#import "Growl/Growl.h"
#import "CLBugReportWindowController.h"
#import "CLPreferencesWindowController.h"
#import "CLMainWindowController.h"
#import "CLMenuController.h"
#import "CLGrowlDelegate.h"
#import "CLXMLParserDelegate.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate> {
    
    NSWindow *_window;
    CLMainWindowController *_mainWindowController;
    __unsafe_unretained CLCellTableDelegate *_dataSource;
    __unsafe_unretained NSPanel *_firstRunPanel;
    
    @private
    CLXMLParserDelegate *_parserDelegate;
    CLGrowlDelegate *_growlDelegate;
    CLMenuController *_menuController;
    CLPreferencesWindowController *_preferencesWindowController;
    CLBugReportWindowController *_bugReportWindowController;

}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet CLMainWindowController *_mainWindowController;
@property (nonatomic, strong) IBOutlet NSPanel *firstRunPanel;

- (IBAction)bugReportClicked:(id)sender;
- (IBAction)websiteClicked:(id)sender;
- (IBAction)viewPreferenceSelected:(id)sender;
- (IBAction)openPreferences:(id)sender;

- (IBAction)tableViewSelected:(id)sender;

@end
