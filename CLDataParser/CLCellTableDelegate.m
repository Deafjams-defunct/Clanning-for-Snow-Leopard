//
//  CLCellTableDelegate.m
//  Clanning
//
//  Created by Dylan Foster on 6/21/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import "CLCellTableDelegate.h"
#import "NSArray+CLArrayUtilities.h"
#import "Constants.h"

@interface CLCellTableDelegate()

@property (nonatomic, strong) NSMutableSet *announcements;

@property (nonatomic, strong) NSArray *previousPlayers;

@end
@implementation CLCellTableDelegate

@synthesize players = _players;
@synthesize delegate = _delegate;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    
    return (NSInteger) _players.count;
    
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
    if ( [aTableColumn.identifier isEqualToString:@"image"] )
    {
        
        return [_players imageAtRow:rowIndex];
        
    }
    else if ( [aTableColumn.identifier isEqualToString:@"text"] ) 
    {
        
        if ( [[[NSUserDefaults standardUserDefaults] stringForKey:@"viewType"] isEqualToString:@"Original"] && [NSUserDefaults.standardUserDefaults boolForKey:@"clanInOriginalView"])
        {
            
            return [[_players nameAtRow:rowIndex] stringByAppendingFormat:@"\n%@", [_players  clanAtRow:rowIndex]];
                    
        }
        
        return [_players nameAtRow:rowIndex];
        
    }
    else if ( [aTableColumn.identifier isEqualToString:@"professionIcon"] )
    {
        
        return [Constants imageForProfession:[_players professionAtRow:rowIndex]];
        
    }
    else if ( [aTableColumn.identifier isEqualToString:@"clan"] )
    {
        
        return [_players clanAtRow:rowIndex];
        
    }
    else if ( [aTableColumn.identifier isEqualToString:@"timeClanning"] )
    {
        
        return [_players clanningTimeAtRow:rowIndex];
        
    }
    
    return nil;
    
}

-(void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
    
    [_players sortUsingDescriptors:tableView.sortDescriptors];
    
    [tableView reloadData];
    
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    
    //Original view
    if ([[NSUserDefaults.standardUserDefaults stringForKey:@"viewType"] isEqualToString:@"Original"]) { return 39; }
    //Compact view
    else { return 17; }
    
}


//Adds a new player to the data source
-(void)addPlayer:(CLPlayer *)player
{
    
    //If player is not already part of the player list
    if ( ![self.players containsObject:player] )
    {
        
        //Tells datasource delegate to perform action
        if ( ![self.previousPlayers containsObject:player] ) { [_delegate addedPlayer:player]; }
        
        [self.players addObject:player];
        
    }
    
}

@end
