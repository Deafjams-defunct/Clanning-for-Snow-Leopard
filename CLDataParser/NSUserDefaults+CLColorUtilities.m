//
//  NSUserDefaults+CLColorUtilities.m
//  Clanning
//
//  Created by Dylan Foster on 4/28/13.
//  Copyright (c) 2013 Dylan Foster. All rights reserved.
//

#import "NSUserDefaults+CLColorUtilities.h"

@implementation NSUserDefaults (CLColorUtilities)

- (void)setColor:(NSColor *)aColor forKey:(NSString *)aKey
{
    NSData *theData=[NSArchiver archivedDataWithRootObject:aColor];
    [self setObject:theData forKey:aKey];
}

- (NSColor *)colorForKey:(NSString *)aKey
{
    NSColor *theColor=nil;
    NSData *theData=[self dataForKey:aKey];
    if (theData != nil)
        theColor=(NSColor *)[NSUnarchiver unarchiveObjectWithData:theData];
    return theColor;
}

@end
