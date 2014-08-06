//
//  CLDataDelegate.h
//  Clanning
//
//  Created by Dylan Foster on 7/18/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLCellTableDelegate.h"
#import "CLGrowlDelegate.h"

@interface CLDataDelegate : NSObject <CLDataSourceDelegate> {
    
    CLGrowlDelegate *_notificationsDelegate;
    BOOL _firstRun;
    
}

@property (__unsafe_unretained) IBOutlet CLGrowlDelegate *notificationsDelegate;

@end
