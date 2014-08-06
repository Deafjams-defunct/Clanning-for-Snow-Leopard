//
//  CLBugReportWindowController.h
//  Clanning
//
//  Created by Dylan Foster on 6/16/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CLBugReportWindowController : NSWindowController {
    
    NSTextField *_reportText;
    NSButton *_submitButton;
    NSView *_thankYouView;
    NSView *_mainView;
    
}

@property (nonatomic, retain) IBOutlet NSTextField *reportText;
@property (nonatomic, retain) IBOutlet NSButton *submitButton;

@property (retain) IBOutlet NSView *thankYouView;
@property (strong) IBOutlet NSView *mainView;

- (IBAction)submit:(id)sender;

@end
