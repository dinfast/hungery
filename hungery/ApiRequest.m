//
//  ApiRequest.m
//  mjbang
//
//  Created by auto on 2015-06-08.
//  Copyright (c) 2015 mjbang. All rights reserved.
//

#import "ApiRequest.h"
#import "HttpApi.h"
//#import "BeanUserFile.h"

#define BASE_URL     @"http://firstaid.dddaozhen.com"

#define BASE_NEW_URL @"http://v5.owner.yun.mjbang.cn"
//#define BASE_NEW_URL @"http://v5.owner.mjbang.cn"

#define HTTP_GET_TIMEOUT 10
#define HTTP_POST_TIMEOUT 10

@implementation ApiRequest

//+ (BOOL)isLogin {
//    NSFileManager* fileManager=[NSFileManager defaultManager];
//    NSArray * documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString * path = [documentArray objectAtIndex:0];
//    NSString * pathFile = [path stringByAppendingPathComponent:@"beanMemberInfomation.txt"];
//    BOOL pictorialHave = [fileManager fileExistsAtPath:pathFile];
//    if (pictorialHave) {
//        NSData * data = [NSData dataWithContentsOfFile:pathFile];
//        if ([NSKeyedUnarchiver safeUnarchiveObjectWithData:data]) {
//            return YES;
//        } else {
//            return NO;
//        }
//    }else {
//        return NO;
//    }
//}

+ (void)cookieProcess {
    NSURL *url = [NSURL URLWithString:BASE_URL];
    NSString *domain = url.host;
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSMutableArray *addArray = [NSMutableArray array];
    
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        if (![domain isEqualToString:cookie.domain]) {
            NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionaryWithDictionary:cookie.properties];
            
            [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
            
            NSHTTPCookie *newCookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
            [addArray addObject:newCookie];
        }
    }
    
    for (NSHTTPCookie *addCookie in addArray) {
        BOOL isAdd = YES;
        
        for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
            if ([addCookie.domain isEqualToString:cookie.domain] && [addCookie.name isEqualToString:cookie.name]) {
                isAdd = NO;
                break;
            }
        }
        
        if (isAdd) {
            [cookieStorage setCookie:addCookie];
        }
    }
}


+ (void)httpPost:(NSString *)url withParams:(NSDictionary *)params withDelegate:(id)delegate withTag:(NSObject *)tag withReturnClassName:(NSString *)className {
    HttpApi *api = [[HttpApi alloc] init];
    
    api.delegate = delegate;
    api.tag = tag;
    api.returnClassName = className;
    
    NSMutableDictionary *newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    //    [newParams setValue:[Iffomation createInformations].beanMember.userToken forKey:@"user_token"];
    
    [api httpPost:url withParams:newParams withTimeout:HTTP_POST_TIMEOUT];
}

@end
