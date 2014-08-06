//
//  NSUserDefaults+CLColorUtilities.h
//  Clanning
//
//  Created by Dylan Foster on 4/28/13.
//  Copyright (c) 2013 barg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (CLColorUtilities)

- (void)setColor:(NSColor *)aColor forKey:(NSString *)aKey;
- (NSColor *)colorForKey:(NSString *)aKey;

@end
