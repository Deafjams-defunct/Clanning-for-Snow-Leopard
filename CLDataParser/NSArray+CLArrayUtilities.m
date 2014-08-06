//
//  NSArray+CLArrayUtilities.m
//  Clanning
//
//  Created by Dylan Foster on 5/8/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import "NSArray+CLArrayUtilities.h"

@implementation NSArray (CLArrayUtilities)

-(NSString *)nameAtRow:(NSUInteger)row
{
    
    if ( row > [self count] ) { return nil; }
    
    return [[self objectAtIndex:row] name];
    
}

-(NSString *)clanAtRow:(NSUInteger)row
{
    
    if ( row > [self count] ) { return nil; }
    
    return [[self objectAtIndex:row] clan];
    
}

-(NSInteger)raceAtRow:(NSUInteger)row
{
    
    if ( row > [self count] ) { return -1; }
    
    return [[self objectAtIndex:row] race];
    
}

-(NSInteger)sexAtRow:(NSUInteger)row
{
    
    if ( row > [self count] ) { return -1; }
    
    return [[self objectAtIndex:row] sex];
    
}

-(NSImage *)imageAtRow:(NSUInteger)row
{
    
    if ( row > [self count] ) { return nil; }
    
    return [[self objectAtIndex:row] image];
    
}

-(NSInteger)professionAtRow:(NSUInteger)row
{
    
    if ( row > [self count] ) { return -1; }
    
    return (NSInteger) [[self objectAtIndex:row] profession];
   
}

-(NSString *)clanningTimeAtRow:(NSUInteger)row
{
    
    const int SECONDS_IN_MINUTE = 60, SECONDS_IN_HOUR = 3600, SECONDS_IN_DAY = 86400;
    
    if ( row > [self count] ) { return nil; }
    
    NSDate *startTime = [[self objectAtIndex:row] startTime];
    NSDate *currentTime = [NSDate date];
    
    NSTimeInterval timeClanning = [currentTime timeIntervalSinceDate:startTime];
    
    int daysClanning = timeClanning / SECONDS_IN_DAY;
    if ( daysClanning != 0 ) { timeClanning -= daysClanning * SECONDS_IN_DAY; }
    
    int hoursClanning = timeClanning / SECONDS_IN_HOUR;
    if ( hoursClanning != 0 ) { timeClanning -= hoursClanning * SECONDS_IN_HOUR; }
    
    int minutesClanning = timeClanning / SECONDS_IN_MINUTE;
    
    NSString *stringTimeClanning;
    
    if ( hoursClanning == 0 ) { stringTimeClanning = [[NSString alloc] initWithFormat:@"%dm", minutesClanning]; }
    else if ( daysClanning == 0 ) { stringTimeClanning = [[NSString alloc] initWithFormat:@"%dh %dm", hoursClanning, minutesClanning]; }
    else { stringTimeClanning = [[NSString alloc] initWithFormat:@"%dd %dh %dm", daysClanning, hoursClanning, minutesClanning]; }
    
    return stringTimeClanning;
    
} 

@end
