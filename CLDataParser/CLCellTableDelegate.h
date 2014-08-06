//
//  CLCellTableDelegate.h
//  Clanning
//
//  Created by Dylan Foster on 6/21/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLPlayer.h"
#import "CLAnnouncement.h"

@protocol CLDataSourceDelegate <NSObject>
@optional
-(void)startingNewData;
-(void)endedNewData;
-(void)addedPlayer:(CLPlayer *)player;
-(void)removedPlayer:(CLPlayer *)player;
-(void)addedAnnouncement:(CLAnnouncement *)announcement;
-(CLPlayer *)playerForRow:(NSUInteger)row;
-(NSString *)nameForRow:(NSUInteger)row;
-(NSString *)clanForRow:(NSUInteger)row;
-(NSInteger)raceForRow:(NSUInteger)row;
-(NSInteger)sexForRow:(NSUInteger)row;
-(NSImage *)imageForRow:(NSUInteger)row;
-(NSInteger)professionForRow:(NSUInteger)row;
-(NSString *)clanningTimeForRow:(NSUInteger)row;
@end

@interface CLCellTableDelegate : NSObject <NSTableViewDelegate, NSTableViewDataSource> {
    
    NSMutableArray *_players;
    id<CLDataSourceDelegate> _delegate;
    
}

@property (strong) IBOutlet id<CLDataSourceDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *players;

@end
