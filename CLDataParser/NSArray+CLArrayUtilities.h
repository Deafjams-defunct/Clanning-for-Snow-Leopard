//
//  NSArray+CLArrayUtilities.h
//  Clanning
//
//  Created by Dylan Foster on 5/8/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLPlayer.h"

@interface NSArray (CLArrayUtilities)

-(NSString *)nameAtRow:(NSUInteger)row;
-(NSString *)clanAtRow:(NSUInteger)row;
-(NSInteger)raceAtRow:(NSUInteger)row;
-(NSInteger)sexAtRow:(NSUInteger)row;
-(NSImage *)imageAtRow:(NSUInteger)row;
-(NSString *)clanningTimeAtRow:(NSUInteger)row;
-(NSInteger)professionAtRow:(NSUInteger)row;


@end
