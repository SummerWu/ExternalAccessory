//
//  RootVC.h
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-27.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property(weak,nonatomic) IBOutlet UILabel      *headerLabel;
@property(weak,nonatomic) IBOutlet UITableView  *tableView;

@end
