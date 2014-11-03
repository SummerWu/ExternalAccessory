//
//  SelectVC.h
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-27.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectVC : UIViewController<UITableViewDataSource>

@property (strong,nonatomic) NSArray   *protocolStrings;
@property (strong,nonatomic) NSString  *eaName;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel   *headerLabel;
@property (weak, nonatomic) IBOutlet UITableView   *selectTableView;

@end
