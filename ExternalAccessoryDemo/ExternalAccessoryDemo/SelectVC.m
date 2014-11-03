//
//  SelectVC.m
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-27.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "SelectVC.h"
#import "SelectCell.h"

@interface SelectVC ()

@end

@implementation SelectVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self.view2 layer]setCornerRadius:8.0f];
    self.headerLabel.text = self.eaName;
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
   // self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return _protocolStrings.count;
    else
        return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SelectCell";
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SelectCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell updateCell:[self.protocolStrings objectAtIndex:[indexPath row]]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)closeSelectVCTouchUpInside:(id)sender
{
    [self.view removeFromSuperview];
}

@end
