//
//  CLMainWindowController.h
//  Clanning
//
//  Created by Dylan Foster on 4/28/13.
//  Copyright (c) 2013 barg. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CLMainWindowController : NSWindowController {
    
    __unsafe_unretained NSView *_originalView;
    __unsafe_unretained NSView *_compactView;
    __unsafe_unretained NSView *_originalViewWithClan;
    __unsafe_unretained NSView *_iClanView;
    
    __unsafe_unretained NSTableView *_originalTable; 
    __unsafe_unretained NSTableView *_compactTable;
    __unsafe_unretained NSTableView *_originalTableWithClan;
    __unsafe_unretained NSTableView *_iClanTable;
    
}

@property (strong) IBOutlet NSTableView *originalTable;
@property (nonatomic, __unsafe_unretained) IBOutlet NSTableView *compactTable;
@property (nonatomic, __unsafe_unretained) IBOutlet NSTableView *originalTableWithClan;
@property (nonatomic) IBOutlet NSTableView *iClanTable;

@property (nonatomic, __unsafe_unretained) IBOutlet NSView *originalView;
@property (nonatomic, __unsafe_unretained) IBOutlet NSView *compactView;
@property (nonatomic, __unsafe_unretained) IBOutlet NSView *originalViewWithClan;
@property (nonatomic) IBOutlet NSView *iClanView;

-(void)update;
-(void)displayProperTableWithResize:(BOOL)shouldResize;
-(void)displayNoConnectionView;

@end
