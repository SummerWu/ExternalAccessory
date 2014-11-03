//
//  RootVC.m
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-27.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "RootVC.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <ExternalAccessory/ExternalAccessory.h>

#import "SelectVC.h"
#import "LogVC.h"
#import "TTSLog.h"

@interface RootVC ()
{
    NSMutableArray *_accessoryList;
    EAAccessory    *_selectedAccessory;
    UIView         *_noExternalAccessoriesPosterView;
    UILabel        *_noExternalAccessoriesLabelView;
    UIActionSheet  *_protocolSelectionActionSheet;
    SelectVC       *_selectVC;
    LogVC          *_logVC;
    
}

@end

@implementation RootVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Accessories";
    }
    return self;
}

- (void)viewDidLoad
{
//    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
//    [pasteBoard setString:(NSString *)]
    [super viewDidLoad];
    [self setHeaderUI];
    _noExternalAccessoriesPosterView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_noExternalAccessoriesPosterView setBackgroundColor:[UIColor whiteColor]];
    _noExternalAccessoriesLabelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 768, 50)];
    [_noExternalAccessoriesLabelView setText:@"No Accessories Connected"];
    _noExternalAccessoriesLabelView.font = [UIFont systemFontOfSize:25];
    _noExternalAccessoriesLabelView.textAlignment = NSTextAlignmentCenter;
    [_noExternalAccessoriesPosterView addSubview:_noExternalAccessoriesLabelView];
    [_tableView addSubview:_noExternalAccessoriesPosterView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_accessoryDidConnect:) name:EAAccessoryDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_accessoryDidDisconnect:) name:EAAccessoryDidDisconnectNotification object:nil];
    [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
     _accessoryList = [[NSMutableArray alloc] initWithArray:[[EAAccessoryManager sharedAccessoryManager] connectedAccessories]];
    if ([_accessoryList count] == 0) {
        [_noExternalAccessoriesPosterView setHidden:NO];
    } else {
        [_noExternalAccessoriesPosterView setHidden:YES];
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setHeaderUI
{
    _headerLabel.layer.borderWidth = 1;
    _headerLabel.layer.borderColor = [UIColor blackColor].CGColor;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Log" style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(myAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)myAction
{
    _logVC = [[LogVC alloc]init];
    [self.navigationController pushViewController:_logVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accessoryList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *eaAccessoryCellIdentifier = @"eaAccessoryCellIdentifier";
    NSUInteger row = [indexPath row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:eaAccessoryCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eaAccessoryCellIdentifier];
    }
    if (row == 0) {
        TTSLOG(@"-------------------- Here are all the accessories can be connected ---------------------")
    }
    EAAccessory  *eaAccessory = [_accessoryList objectAtIndex:row];
    TTSLOG([eaAccessory description]);
    
    NSString *accessoryName = [[_accessoryList objectAtIndex:row] name];
    if (!accessoryName || [accessoryName isEqualToString:@""]) {
        accessoryName = @"unknown";
    }
    cell.textLabel.font = [UIFont systemFontOfSize:23];
    
	[[cell textLabel] setText:accessoryName];
	
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    _selectedAccessory = [_accessoryList objectAtIndex:row];
    TTSLOG(@"-------------------- Selected accessory --------------------")
    TTSLOG([_selectedAccessory description])
    _selectVC = [[SelectVC alloc]init];
    _selectVC.eaName = [NSString stringWithFormat:@"%@'s protocols", [_selectedAccessory name]];
    _selectVC.protocolStrings = [_selectedAccessory protocolStrings];
   // _selectVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.view addSubview:_selectVC.view];
   // [self presentViewController:_selectVC animated:NO completion:nil];
   // [self.navigationController pushViewController:_selectVC animated:YES];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)_accessoryDidConnect:(NSNotification *)notification {
    EAAccessory *connectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];
    [_accessoryList addObject:connectedAccessory];
    TTSLOG(@"-------------------- The following accessory connected: --------------------")
    TTSLOG([connectedAccessory description])
    
    if ([_accessoryList count] == 0) {
        [_noExternalAccessoriesPosterView setHidden:NO];
    } else {
        [_noExternalAccessoriesPosterView setHidden:YES];
    }

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([_accessoryList count] - 1) inSection:0];
    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)_accessoryDidDisconnect:(NSNotification *)notification {
    EAAccessory *disconnectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];
    
    TTSLOG(@"-------------------- The following accessory disconnected: --------------------")
    TTSLOG([disconnectedAccessory description])
    
    if (_selectedAccessory && [disconnectedAccessory connectionID] == [_selectedAccessory connectionID])
    {
        [_protocolSelectionActionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    }
    
    int disconnectedAccessoryIndex = 0;
    for(EAAccessory *accessory in _accessoryList) {
        if ([disconnectedAccessory connectionID] == [accessory connectionID]) {
            break;
        }
        disconnectedAccessoryIndex++;
    }
    
    if (disconnectedAccessoryIndex < [_accessoryList count]) {
        [_accessoryList removeObjectAtIndex:disconnectedAccessoryIndex];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:disconnectedAccessoryIndex inSection:0];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
	} else {
        NSLog(@"could not find disconnected accessory in accessory list");
        TTSLOG(@"---------------- could not find disconnected accessory in accessory list -----------------");
    }
    
    if ([_accessoryList count] == 0) {
        [_noExternalAccessoriesPosterView setHidden:NO];
    } else {
        [_noExternalAccessoriesPosterView setHidden:YES];
    }
}

@end
