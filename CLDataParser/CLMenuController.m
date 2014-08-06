//
//  CLPopoverController.m
//  Clanning
//
//  Created by Dylan Foster on 6/26/12.
//  Copyright (c) 2012 Finger Lakes Community College. All rights reserved.
//

#import "CLMenuController.h"
#import "NSArray+CLArrayUtilities.h"
#import "CLCellDelegate.h"
#import "Constants.h"

@interface CLMenuController()

@property (nonatomic) NSInteger currentRow;

@end

@implementation CLMenuController
@synthesize menu = _menu;
@synthesize originalTableView = _originalTableView;
@synthesize compactTableView = _compactTableView;
@synthesize originalTableViewWithClan = _originalTableViewWithClan;
@synthesize name = _name;
@synthesize clan = _clan;
@synthesize playTime = _playTime;
@synthesize image = _image;
@synthesize professionIcon = _professionIcon;
@synthesize dataSource = _dataSource;
@synthesize currentRow = _currentRow;

-(void)awakeFromNib
{
        
    _image.identifier = @"image";
        
}

- (void)menuWillOpen:(NSMenu *)menu
{
    
    if ( [[NSUserDefaults.standardUserDefaults stringForKey:@"viewType"] isEqualToString:@"Original"] )
    {
        
        if ( [NSUserDefaults.standardUserDefaults boolForKey:@"clanInOriginalView"] )
        {
            
            if ( _originalTableViewWithClan.selectedRow != -1 )
            {
                
                _dataSource = (CLCellTableDelegate *)_originalTableViewWithClan.dataSource;
                _currentRow = _originalTableViewWithClan.selectedRow;
                
            }
            
        }
        else
        {
            
            if ( _originalTableView.selectedRow != -1 )
            {
                
                _dataSource = (CLCellTableDelegate *)_originalTableView.dataSource;
                _currentRow = _originalTableView.selectedRow;
                
            }
            
        }
        
    }
    else
    {
        
        if ( _compactTableView.selectedRow != -1 )
        {
            
            _dataSource = (CLCellTableDelegate *)_compactTableView.dataSource;
            _currentRow = _compactTableView.selectedRow;
            
        }
        
    }
    
    if ( _dataSource )
    {
        
        _name.title = [_dataSource.players nameAtRow:_currentRow];
        _clan.title = [_dataSource.players clanAtRow:_currentRow];
        _playTime.title = [_dataSource.players clanningTimeAtRow:_currentRow];
        _image.image = [_dataSource.players imageAtRow:_currentRow];
        _professionIcon.image = [Constants imageForProfession:[_dataSource.players professionAtRow:_currentRow]];
        
    }
    
}

/**
 One of the buttons on the popover was pressed, open proper website
 */
- (IBAction)buttonClicked:(id)sender {
    
    NSMutableString* name;
    
    if ( [[sender identifier] isEqualToString:@"image"] ) { name = [_name.title mutableCopy]; }
    else { name = [[NSMutableString alloc] initWithString:[sender title]]; }
    
    //Cleaning up name
    [name replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, name.length)];
    [name replaceOccurrencesOfString:@"'" withString:@"" options:0 range:NSMakeRange(0, name.length)];
    [name replaceOccurrencesOfString:@"&" withString:@"And" options:0 range:NSMakeRange(0, name.length)];
    
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:[@"http://puddleopedia.org/entry.php?n=Entry." stringByAppendingString:name]]];
    
}

/**
 Profession picture was clicked, open proper website
 */
- (IBAction)professionIconClicked:(id)sender
{
    
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:[@"http://puddleopedia.org/entry.php?n=Entry." stringByAppendingString:[Constants nameForProfession:[_dataSource.players professionAtRow:_currentRow]]]]];
    
}


@end
