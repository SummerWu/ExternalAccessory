//
//  SelectCell.m
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-27.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)updateCell:(NSString *)protocol
{
    self.protocolLabel.text = protocol;
}

-(IBAction)copyTouchUpInside:(id)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:_protocolLabel.text];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"Copy successsully !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
