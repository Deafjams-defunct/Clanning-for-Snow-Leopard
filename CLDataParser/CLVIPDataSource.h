//
//  CLVIPDataSource.h
//  Clanning
//
//  Created by Dylan Foster on 8/16/12.
//  Copyright (c) 2012 Dylan Foster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLVIPDataSource : NSObject <NSTableViewDelegate, NSTableViewDataSource> {
    
    @private
    NSMutableArray *_VIPs;
    NSTableView *_currentTable;
    
}

+(CLVIPDataSource *)sharedVIPDataSource;

-(void)save;

-(void)addVIP:(NSString *)VIP;
-(void)removeVIP:(NSString *)VIP;

-(BOOL)contains:(NSString *)VIP;

-(NSString *)VIPAtRow:(NSUInteger)row;

@end
