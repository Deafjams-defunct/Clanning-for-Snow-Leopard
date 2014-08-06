//
//  AppDelegate.m
//  CLDataParser
//
//  Created by Dylan Foster on 12/23/11.
//  Copyright (c) 2011 Finger Lakes Community College. All rights reserved.
//

#import "AppDelegate.h"
#import "NSArray+CLArrayUtilities.h"
#import "Constants.h"
#import "SystemConfiguration/SystemConfiguration.h"

@interface AppDelegate()

@property (nonatomic, strong) CLCellTableDelegate *dataSource;
@property (nonatomic, strong) CLBugReportWindowController *bugReportWindowController;
@property (nonatomic, strong) CLPreferencesWindowController *preferencesWindowController;
@property (nonatomic, strong) CLMenuController *menuController;
@property (nonatomic, strong) CLGrowlDelegate *growlDelegate;
@property (nonatomic, strong) CLXMLParserDelegate *parserDelegate;

-(void)refreshData;
-(BOOL)connected;
-(void)setDefaultPreferences;

@end

@implementation AppDelegate
@synthesize menuController = _menuController;
@synthesize preferencesWindowController = _preferencesWindowController;
@synthesize growlDelegate = _growlDelegate;
@synthesize firstRunPanel = _firstRunPanel;
@synthesize window = _window;
@synthesize dataSource = _dataSource;
@synthesize bugReportWindowController = _bugReportWindowController;
@synthesize parserDelegate = _parserDelegate;

- (CLGrowlDelegate *)growlDelegate
{
    
    if ( !_growlDelegate ) { _growlDelegate = [[CLGrowlDelegate alloc] init]; }
    return _growlDelegate;
    
}

-(CLXMLParserDelegate *)parserDelegate
{
    
    if ( !_parserDelegate ) { _parserDelegate = [[CLXMLParserDelegate alloc] init]; }
    return _parserDelegate;
    
}

- (CLCellTableDelegate *)dataSource
{
    
    if ( !_dataSource ) { _dataSource = [[CLCellTableDelegate alloc] init]; }
    return _dataSource;
    
}

- (CLBugReportWindowController *)bugReportWindowController
{
        
    if ( !_bugReportWindowController ) { _bugReportWindowController = [[CLBugReportWindowController alloc] initWithWindowNibName:@"CLBugReport"]; }
    return _bugReportWindowController;
    
}

- (CLPreferencesWindowController *)preferencesWindowController
{
    
    if ( !_preferencesWindowController )
    {
        
        _preferencesWindowController = [[CLPreferencesWindowController alloc] initWithWindowNibName:@"Preferences"];
        _preferencesWindowController.mainWindow = _window;
        _preferencesWindowController.originalView = _originalView;
        _preferencesWindowController.compactView = _compactView;
        _preferencesWindowController.originalViewWithClan = _originalViewWithClan;
        _preferencesWindowController.originalTable = _originalTable;
        _preferencesWindowController.compactTable = _compactTable;
        _preferencesWindowController.originalTableWithClan = _originalTableWithClan;
        _preferencesWindowController.iClanTable = _iClanTable;
        _preferencesWindowController.iClanView = _iClanView;
        _preferencesWindowController.growlDelegate = self.growlDelegate;
        
    }
    return _preferencesWindowController;
    
}

-(void)applicationWillBecomeActive:(NSNotification *)notification
{
    
    [_window makeKeyAndOrderFront:self];
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    //Reset user defaults
    //[[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];

    
    //Set preferences for notifications if there are none
    if ( ![NSUserDefaults.standardUserDefaults stringForKey:@"notificationSetting"] )
    {
        
        [self setDefaultPreferences];
        
    }
    
    if ( ![NSUserDefaults.standardUserDefaults stringForKey:@"firstLaunch"] ) { [_firstRunPanel makeKeyAndOrderFront:self]; }
    //Display selection panel even if user selected a view before 1.3
    else if ( [[NSUserDefaults.standardUserDefaults stringForKey:@"firstLaunch"] isEqualToString:@"No"] ) { [_firstRunPanel makeKeyAndOrderFront:self]; }
    else { [_window makeKeyAndOrderFront:self]; }
    
    if ( [[NSUserDefaults.standardUserDefaults stringForKey:@"viewType"] isEqualToString:@"Original"] )
    {
        
        if ( [NSUserDefaults.standardUserDefaults boolForKey:@"clanInOriginalView"] ) { [_window setContentView:_originalViewWithClan]; }
        else { [_window setContentView:_originalView]; }
        
    }
    else if ( [[NSUserDefaults.standardUserDefaults stringForKey:@"viewType"] isEqualToString:@"Original"] )
    {
        
        [_window setContentView:_compactView];
    
    }
    else
    {
        
        [_window setContentView:_iClanView];
     
    }
    
    //Setting table delegates and datasources
    [self.originalTable setDataSource:self.dataSource];
    [self.originalTable setDelegate:self.dataSource];
    [self.originalTableWithClan setDataSource:self.dataSource];
    [self.originalTableWithClan setDelegate:self.dataSource];
    [self.compactTable setDataSource:self.dataSource];
    [self.compactTable setDelegate:self.dataSource];
    [self.iClanTable setDataSource:self.dataSource];
    [self.iClanTable setDelegate:self.dataSource];
        
    //Creating new thread for data updates
    NSThread *dataRefreshThread = [[NSThread alloc] initWithTarget: self
                                                          selector: @selector(refreshData)
                                                            object: self];
    [dataRefreshThread start];
    
}

/**
 Updates data from server, updates views.
 */
- (void)refreshData
{
    
    NSXMLParser *parser = nil;
    NSURL *dataURL = [NSURL URLWithString:@"http://www.deltatao.com/clanlord/status/cldata.xml"];
    
    BOOL firstRun = YES;
    
    while ( YES )
    {
        
        //Get new data
        parser = [[NSXMLParser alloc] initWithContentsOfURL:dataURL];
        [parser setDelegate:self.parserDelegate];
          
        if ( [self connected] )
        {
            
            [parser parse];
            parser = nil;            
            
            //Update window title
            _window.title = [NSString stringWithFormat:@"%d Clanning", self.parserDelegate.population];
            
            if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"viewType"] isEqualToString:@"iClan"] )
            {
                
                [self.parserDelegate.players sortUsingDescriptors:_iClanTable.sortDescriptors];
                
            }
            
            self.dataSource.players = self.parserDelegate.players;
            
            if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"viewType"] isEqualToString:@"Original"] )
            {
                
                if ( [NSUserDefaults.standardUserDefaults boolForKey:@"clanInOriginalView"] ) { [_originalTableWithClan reloadData]; }
                else { [_originalTable reloadData]; }
                
            }
            else if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"viewType"] isEqualToString:@"Compact"] )
            {
                
                [_compactTable reloadData];
                
            }
            else
            {
                
                [_iClanTable reloadData];
                
            }
            
            if ( !firstRun )
            {
                
                //Send Growl notifications for new players, logged off players and all new announcements
                for ( CLAnnouncement *announcement in [_parserDelegate getNewAnnouncements] ) { [self.growlDelegate notificationForAnnouncement:announcement]; }
                for ( CLPlayer *player in [_parserDelegate getNewPlayers] ) { [self.growlDelegate playerBeginsClanning:player]; }
                for ( CLPlayer *player in [_parserDelegate getLoggedOffPlayers] ) { [self.growlDelegate playerStopsClanning:player]; }
                
            }
            else
            {
                
                if ( [NSUserDefaults.standardUserDefaults boolForKey:@"logon"] )
                {
                    
                    //for ( CLPlayer *player in [self.dataSource getCurrentVIPs] ) { [self.growlDelegate playerBeginsClanning:player]; }
                    
                }
                
                //Send all status notifications sent within the previous hour
                if ( [NSUserDefaults.standardUserDefaults boolForKey:@"checkStatusesAtLaunch"] )
                {
                    
                    for ( CLAnnouncement *announcement in [self.dataSource getStatusAnnouncementsFromPreviousHour] ) { [self.growlDelegate notificationForAnnouncement:announcement]; }
                    
                }
                
                firstRun = NO;
                
            }

            
        }
        else
        {
            
            _window.title = @"No connection - Clanning";
            
        }
        
        [NSThread sleepForTimeInterval:REFRESH_TIME];
        
    }
    
}

-(void)setDefaultPreferences
{
    
    [NSUserDefaults.standardUserDefaults setBool:NO forKey:@"onlyDisplayForVIPs"];
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"checkStatusesAtLaunch"];
    [NSUserDefaults.standardUserDefaults setColor:[NSColor colorWithCalibratedRed:0.4745098039f green:0.04705882353f blue:1.0f alpha:1.0f] forKey:@"vipColor"];
    [NSUserDefaults.standardUserDefaults setValue:[NSNumber numberWithInt:1] forKey:@"logon"];
    [NSUserDefaults.standardUserDefaults setValue:0 forKey:@"logoff"];
    [NSUserDefaults.standardUserDefaults setValue:[NSNumber numberWithInt:1] forKey:@"status"];
    [NSUserDefaults.standardUserDefaults setValue:[NSNumber numberWithInt:1] forKey:@"stickyStatus"];
    [NSUserDefaults.standardUserDefaults setValue:[NSNumber numberWithInt:1] forKey:@"congratulations"];
    [NSUserDefaults.standardUserDefaults setValue:0 forKey:@"koppi"];
    [NSUserDefaults.standardUserDefaults setValue:[NSNumber numberWithInt:30] forKey:@"koppiInterval"];
    [NSUserDefaults.standardUserDefaults setValue:0 forKey:@"crius"];
    [NSUserDefaults.standardUserDefaults setValue:[NSNumber numberWithInt:15] forKey:@"criusInterval"];
    
}

-(BOOL)connected
{

    //return !( [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable );
    
}

- (IBAction)bugReportClicked:(id)sender
{
            
    [self.bugReportWindowController showWindow:sender];
        
}

- (IBAction)websiteClicked:(id)sender
{
    
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:@"http://deafjams.com/clanning/"]];
    
}

/**
 Sets table view preference
 */
- (IBAction)viewPreferenceSelected:(id)sender {
    
    [NSUserDefaults.standardUserDefaults setValue:[sender title] forKey:@"viewType"];
    
    [self tableViewSelected:sender];
    
    [NSUserDefaults.standardUserDefaults setValue:@"No - iClan Added" forKey:@"firstLaunch"];
    
    [_firstRunPanel orderOut:self];
    [_window makeKeyAndOrderFront:self];
    
}

- (IBAction)openPreferences:(id)sender
{
    
    [self.preferencesWindowController showWindow:self];
    
}

- (IBAction)tableViewSelected:(id)sender
{
    
    [self.preferencesWindowController viewPreferenceChanged:sender];
    
}

@end
