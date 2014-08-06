//
//  CLButton.h
//  Clanning
//
//  Created by Dylan Foster on 7/4/12.
//  Copyright (c) 2012 barg. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface CLButton : NSButton
{
    
    NSString *_identifier;
    
}

@property (strong) NSString *identifier;

@end
