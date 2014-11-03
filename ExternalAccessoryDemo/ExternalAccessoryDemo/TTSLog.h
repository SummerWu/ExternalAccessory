//
//  TTSLog.h
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-28.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TTSLOG(text) [[TTSLog shareInstance] writeFile:text];

@interface TTSLog : NSObject

+(TTSLog *)shareInstance;

-(void)writeFile:(NSString *)file;

- (NSString *)readFile;

@property(strong, nonatomic) NSString  *  logs;

@end
