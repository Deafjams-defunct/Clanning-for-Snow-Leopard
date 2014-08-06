//
//  CLXMLParserDelegate.m
//  Clanning
//
//  Created by Dylan Foster on 6/26/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import "CLXMLParserDelegate.h"
#import "CLVIPDataSource.h"
#import "CLAnnouncement.h"
#import "Constants.h"

@interface CLXMLParserDelegate()

@property (nonatomic, strong) NSMutableString *currentElement;
@property (nonatomic, strong) CLPlayer *player;
@property (nonatomic, strong) CLAnnouncement *announcement;
@property (nonatomic, strong) NSArray *previousPlayers;
@property (nonatomic, strong) NSArray *previousAnnouncements;
@property (nonatomic, strong) NSDate *refreshTime;

@end

@implementation CLXMLParserDelegate

@synthesize player = _player;
@synthesize players = _players;
@synthesize previousPlayers = _previousPlayers;
@synthesize population = _population;
@synthesize announcement = _announcement;
@synthesize announcements = _announcements;
@synthesize previousAnnouncements = _previousAnnouncements;
@synthesize currentElement = _currentElement;
@synthesize refreshTime = _refreshTime;

-(NSMutableArray *)players
{
    
    if ( !_players ) { _players = [[NSMutableArray alloc] initWithCapacity:10]; }
    return _players;
    
}

-(NSMutableArray *)announcements
{
    
    if ( !_announcements ) { _announcements = [[NSMutableArray alloc] initWithCapacity:10]; }
    return _announcements;
    
}

-(NSArray *)previousAnnouncements
{
    
    if ( !_previousAnnouncements ) { _previousAnnouncements = [[NSArray alloc] init]; }
    return _announcements;
    
}

-(NSArray *)previousPlayers
{
    
    if ( !_previousPlayers ) { _previousPlayers = [[NSArray alloc] init]; }
    return _previousPlayers;
    
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    //New document started, place current players and announcements in their previous holders and clear them.
    
    self.previousPlayers = [_players copy];
    [_players removeAllObjects];
    
    self.previousAnnouncements = [_announcements copy];
    [_announcements removeAllObjects];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    //Create a new player object for exile in XML
    if ( [elementName isEqualToString:@"exile"] ){ _player = [[CLPlayer alloc] init]; }
    //Create a new announcement object for announcement in XML
    else if ( [elementName isEqualToString:@"announcement"] ) { _announcement = [[CLAnnouncement alloc] init]; }
    
    //Reset the current element
    _currentElement = nil;

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    //Working through an element. If the element does not exist, create it. If it does, append text to it.
    if ( !_currentElement ){ _currentElement = [[NSMutableString alloc] initWithString:string]; }
    else { [_currentElement appendString:string]; }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    //Population
    if ( [elementName isEqualToString:@"population"] ) { _population = _currentElement.intValue; }
    
    //Player
    if ( [elementName isEqualToString:@"exile"] ) { 
        
        if( [CLVIPDataSource.sharedVIPDataSource contains:_player.name] || [CLVIPDataSource.sharedVIPDataSource contains:_player.clan] ) { _player.isVIP = YES; }
        
        [self.players addObject:_player];
    
    }
    else if ( [elementName isEqualToString:@"name"] ) { _player.name = _currentElement; }
    else if ( [elementName isEqualToString:@"started"] ) { _player.startTime = [NSDate dateWithNaturalLanguageString:_currentElement]; }
    else if ( [elementName isEqualToString:@"clan"] ) { _player.clan = _currentElement; }
    else if ( [elementName isEqualToString:@"race"] ) { _player.race = [Constants raceFromString:_currentElement]; }
    else if ( [elementName isEqualToString:@"picture"] ) { _player.image = [Constants imageFromIdentifier:_currentElement.intValue]; }
    else if ( [elementName isEqualToString:@"sex"] ) { _player.sex = [_currentElement isEqualToString:@"male"] ? MALE : FEMALE; }
    else if ( [elementName isEqualToString:@"colors"] ) { [_player setColorsWithArray:[_currentElement componentsSeparatedByString:@" "]]; }
    else if ( [elementName isEqualToString:@"profession"] ) { _player.profession = [Constants professionFromString:_currentElement]; }
    
    //Announcement
    if ( [elementName isEqualToString:@"announcement"] ) { [self.announcements addObject:_announcement]; }
    else if ( [elementName isEqualToString:@"type"] ) { _announcement.type = [Constants announcmentTypeFromString:_currentElement]; }
    else if ( [elementName isEqualToString:@"time"] ) { _announcement.time = [NSDate dateWithNaturalLanguageString:_currentElement]; }
    else if ( [elementName isEqualToString:@"messenger"] ) { _announcement.messenger = _currentElement; }
    else if ( [elementName isEqualToString:@"message"] ) { _announcement.message = _currentElement; }
    else if ( [elementName isEqualToString:@"awardee"] ) { _announcement.awardee = _currentElement; }
    
    //Refresh time
    if ( [elementName isEqualToString:@"lastrefresh"] ) { _refreshTime = [NSDate dateWithNaturalLanguageString:_currentElement]; }
    
    _currentElement = nil;
    
}

/**
 Gives the players that have begun clanning since the last data update.
*/
- (NSArray *)getNewPlayers
{
    
    NSMutableArray *newPlayers = [self.players mutableCopy];
    
    [newPlayers removeObjectsInArray:self.previousPlayers];
    
    return [NSArray arrayWithArray:newPlayers];
    
}

/**
 Gives announcements since the last data update.
 */
-(NSArray *)getNewAnnouncements
{
    
    //Get date that is two refresh times ago (time compensation for /statuseseses
    NSDateComponents *compenents = [[NSDateComponents alloc] init];
    [compenents setSecond:(NSInteger) REFRESH_TIME * -1];
    
    NSDate *refreshTimeAgo = [[NSCalendar currentCalendar] dateByAddingComponents:compenents toDate:_refreshTime options:0];
    
    //Remove all announcements that were sent before two refresh times ago
    NSMutableArray *newAnnouncements = [[NSMutableArray alloc] initWithArray:_announcements];
    
    for ( CLAnnouncement *announcement in _announcements )
    {
        
        if ( [[refreshTimeAgo earlierDate:announcement.time] isEqualToDate:announcement.time] )
        {
            
            [newAnnouncements removeObject:announcement];
            
        }
        
    }
    
    return [NSArray arrayWithArray:newAnnouncements];
    
}

/**
 Gets players that logged off since last data update
 */
-(NSArray *)getLoggedOffPlayers
{
    
    NSMutableArray *loggedPlayers = [self.previousPlayers mutableCopy];
    
    [loggedPlayers removeObjectsInArray:self.players];
    
    return [NSArray arrayWithArray:loggedPlayers];
    
}


/**
 Gets statuses from the last hour
 */
-(NSArray *)getStatusAnnouncementsFromPreviousHour
{
    
    //Create date that is one hour ago
    NSDateComponents *compenents = [[NSDateComponents alloc] init];
    [compenents setHour:-1];
    
    NSDate *hourAgo = [[NSCalendar currentCalendar] dateByAddingComponents:compenents toDate:[NSDate date] options:0];
    
    //Remove all the announcements that aren't status updates or were sent over an hour ago
    NSMutableArray *newAnnouncements = [[NSMutableArray alloc] initWithArray:_announcements];
    
    for ( CLAnnouncement *announcement in _announcements )
    {
        
        if ( [[hourAgo earlierDate:announcement.time] isEqualToDate:announcement.time] || announcement.type != ALERT )
        {
            
            [newAnnouncements removeObject:announcement];
            
        }
        
    }
    
    return [NSArray arrayWithArray:newAnnouncements];
    
}

@end
