//
//  LogVC.m
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-28.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "LogVC.h"
#import "TTSLog.h"


@interface LogVC ()

@end

@implementation LogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderUI];
    
    self.title = @"Log";
    [_logTextView setEditable:NO];
    _logTextView.text = [[TTSLog shareInstance] readFile];
    // Do any additional setup after loading the view from its nib.
}

-(void)setHeaderUI
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Copy all" style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(myAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)myAction
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:_logTextView.text];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"Copy successsully !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
