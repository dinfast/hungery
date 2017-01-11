//
//  iffmCustomers.m
//  naocutong
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "iffmCustomers.h"
#import "BeanCustomer.h"
#import "NSKeyedUnarchiver+SafeUnarchive.h"
@implementation iffmCustomers
+ (iffmCustomers *)createInformations
{
    static iffmCustomers * informatios = nil;
    if (!informatios){
        informatios = [[iffmCustomers alloc]init];
    }
    return informatios;
}

- (void)writeToFile
{
    NSArray * documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * path = [documentArray objectAtIndex:0];
    //写入文件
    if (!path) {
        
        
    }else {
        
        NSString * pathFile = [path stringByAppendingPathComponent:@"beanCustomersInfomation.txt"];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.beanCustomer];
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
        
        NSString * pathFile = [path stringByAppendingPathComponent:@"beanCustomersInfomation.txt"];
        NSData * data = [NSData dataWithContentsOfFile:pathFile];
        self.beanCustomer = [NSKeyedUnarchiver safeUnarchiveObjectWithData:data];
        
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
        
        NSString * filePaht = [documentsPath stringByAppendingPathComponent:@"beanCustomersInfomation.txt"];
        BOOL pictorialHave=[fileManager fileExistsAtPath:filePaht];
        if (!pictorialHave) {
            
            
            
        }else {
            BOOL pictorialDele = [fileManager removeItemAtPath:filePaht error:nil];
            if (pictorialDele) {
                self.beanCustomer = nil;
                
            }
        }
    }
}

@end
