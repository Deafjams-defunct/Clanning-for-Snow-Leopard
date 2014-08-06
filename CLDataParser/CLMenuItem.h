//
//  CLMenuItem.h
//  Clanning
//
//  Created by Dylan Foster on 7/4/12.
//  Copyright (c) 2012 barg. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface CLMenuItem : NSMenuItem
{
    
    NSString *_identifier;
    
}

@property (nonatomic, strong) NSString *identifier;

@end
