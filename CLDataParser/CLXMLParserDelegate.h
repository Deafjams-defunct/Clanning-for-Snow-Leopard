//
//  CLXMLParserDelegate.h
//  Clanning
//
//  Created by Dylan Foster on 6/26/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLPlayer.h"
#import "CLAnnouncement.h"

@interface CLXMLParserDelegate : NSObject <NSXMLParserDelegate>
{
    
    NSMutableArray *_players;
    NSMutableArray *_announcements;
    int _population;
    
    @private
    NSMutableString *_currentElement;
    CLPlayer *_player;
    NSArray *_previousPlayers;
    NSArray *_previousAnnouncements;
    CLAnnouncement *_announcement;
    NSDate *_refreshTime;
    
}

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSMutableArray *announcements;
@property (nonatomic) int population;

-(NSArray *)getNewPlayers;
-(NSArray *)getNewAnnouncements;
-(NSArray *)getStatusAnnouncementsFromPreviousHour;
-(NSArray *)getLoggedOffPlayers;

@end
