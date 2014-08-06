//
//  CLPreferenceView.h
//  Clanning
//
//  Created by Dylan Foster on 7/4/12.
//  Copyright (c) 2012 Dylan Foster. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface CLPreferenceView : NSView {
    
    NSString *_identifier;
    
}

@property (nonatomic, strong) NSString *identifier;

@end
