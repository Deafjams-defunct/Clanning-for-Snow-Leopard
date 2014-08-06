//
//  NSTextFieldCell+NSTextFieldCell_CLUtilities.m
//  Clanning
//
//  Created by Dylan Foster on 6/22/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import "NSTextFieldCell+CLUtilities.h"

@implementation NSTextFieldCell (CLUtilities)

- (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y = theRect.origin.y + (theRect.size.height - titleSize.height) / 2.0;
    return titleFrame;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    [[self attributedStringValue] drawInRect:titleRect];
}

@end
