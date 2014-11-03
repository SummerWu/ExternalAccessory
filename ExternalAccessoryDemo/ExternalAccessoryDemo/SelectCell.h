//
//  SelectCell.h
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-27.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCell : UITableViewCell

@property(weak,nonatomic) IBOutlet UILabel *protocolLabel;

-(void)updateCell:(NSString *)protocol;
@end
