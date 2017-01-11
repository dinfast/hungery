//
//  Iffomation.m
//  XtuanMoive2.0
//
//  Created by X团 on 14-7-11.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import "Iffomation.h"
//#import "CacheManager.h"

@implementation Iffomation
+ (Iffomation *)createInformations
{
    static Iffomation * informations = nil;
    if (!informations){
        informations = [[Iffomation alloc]init];
    }
    return informations;
}

- (void)writeToFile
{
    NSArray * documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * path = [documentArray objectAtIndex:0];
    //写入文件
    if (!path) {
        
        
    }else {
        
        NSString * pathFile = [path stringByAppendingPathComponent:@"beanMemberInfomation.txt"];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.beanuser];
        [data writeToFile:pathFile atomically:YES];
    }
}



- (void)readFromFile
{
    NSArray * documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * path = [documentArray objectAtIndex:0];
    //写入文件
    if (!path) {
        
        
    }else {
        
        NSString * pathFile = [path stringByAppendingPathComponent:@"beanMemberInfomation.txt"];
        NSData * data = [NSData dataWithContentsOfFile:pathFile];
        self.beanuser = [NSKeyedUnarchiver safeUnarchiveObjectWithData:data];
        
    }
}


-(void)removeFile
{
    //清楚用户信息
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray * docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * documentsPath = [docPath objectAtIndex:0];
    //写入文件
    if (!documentsPath) {
        
    }else {
        
        NSString * filePaht = [documentsPath stringByAppendingPathComponent:@"beanMemberInfomation.txt"];
        BOOL pictorialHave=[fileManager fileExistsAtPath:filePaht];
        if (!pictorialHave) {
            
            
            
        }else {
            BOOL pictorialDele = [fileManager removeItemAtPath:filePaht error:nil];
            if (pictorialDele) {
                self.beanuser = nil;
            
            }
        }
    }
}

@end
