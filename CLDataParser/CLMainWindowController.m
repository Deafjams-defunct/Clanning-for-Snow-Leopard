//
//  CLMainWindowController.m
//  Clanning
//
//  Created by Dylan Foster on 4/28/13.
//  Copyright (c) 2013 barg. All rights reserved.
//

#import "CLMainWindowController.h"

@implementation CLMainWindowController

@synthesize iClanTable = _iClanTable;
@synthesize compactTable = _compactTable;
@synthesize originalTableWithClan = _originalTableWithClan;
@synthesize originalTable = _originalTable;

@synthesize originalViewWithClan = _originalViewWithClan;
@synthesize originalView = _originalView;
@synthesize iClanView = _iClanView;
@synthesize compactView = _compactView;


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)update {
    
    
    
}

@end
