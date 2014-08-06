//
//  CLAnnouncement.h
//  Clanning
//
//  Created by Dylan Foster on 6/26/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLAnnouncement : NSObject
{
    
    NSUInteger _type;
    NSDate *_time;
    NSString *_messenger;
    NSString *_message;
    NSString *_awardee;
    NSImage *_image;
    
}

-(BOOL) isColiseumMessage;

@property (nonatomic) NSUInteger type;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *messenger;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *awardee;
@property (nonatomic, strong) NSImage *image;

@end
