//
//  Player.h
//  Clanning
//
//  Created by Dylan Foster on 12/24/11.
//  Copyright (c) 2011 Finger Lakes Community College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLPlayer : NSObject {
    
    NSDate *_startTime;
    NSString *_clan;
    NSString *_name;
    NSImage *_image;
    NSDictionary *_colors;
    NSInteger _race;
    NSInteger _sex;
    NSUInteger _profession;
    BOOL _isVIP;
    
}

@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSString *clan;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSImage *image;
@property (nonatomic, retain) NSDictionary *colors;
@property (nonatomic) NSUInteger profession;
@property (nonatomic) NSInteger race;
@property (nonatomic) NSInteger sex;
@property (nonatomic) BOOL isVIP;


-(void)setColorsWithArray:(NSArray *)colors;
-(NSString *)description;

@end
