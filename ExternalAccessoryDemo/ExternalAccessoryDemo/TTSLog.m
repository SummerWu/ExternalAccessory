//
//  TTSLog.m
//  ExternalAccessoryDemo
//
//  Created by Summer Wu on 14-10-28.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "TTSLog.h"

@implementation TTSLog

+(TTSLog *)shareInstance
{
    static TTSLog *_instance = nil;
    
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
            _instance.logs = @"";
        }
    }
    return _instance;
}

-(void)writeFile:(NSString *)file

{
    NSString *oldfile =[self readFile];
    if (oldfile == nil) {
        oldfile = @"";
    }
    file = [NSString stringWithFormat:@"%@ \n%@",oldfile,file];
    
    //创建文件管理器
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    
    //1、参数NSDocumentDirectory要获取的那种路径
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    //2、得到相应的Documents的路径
    
    NSString* documentDirectory = [paths objectAtIndex:0];
    
    //3、更改到待操作的目录下
    
    [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
    
    //4、创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    
   // [fileManager removeItemAtPath:@"username" error:nil];
    
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"username"];
    
    //5、创建数据缓冲区
    
    NSMutableData *writer = [[NSMutableData alloc] init];
    
    //6、将字符串添加到缓冲中
    
    [writer appendData:[file dataUsingEncoding:NSUTF8StringEncoding]];
    
    //7、将其他数据添加到缓冲中
    
    //将缓冲的数据写入到文件中
    
    [writer writeToFile:path atomically:YES];
}


- (NSString *)readFile

{
    
    //创建文件管理器
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    //获取文件路径
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:@"username"];
    
    NSData* reader = [NSData dataWithContentsOfFile:path];
    
    return [[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding];

    
}

@end
