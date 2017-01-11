//
//  HttpApi.m
//  XtuanMoive
//
//  Created by ppl on 14-11-4.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import "HttpApi.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
@implementation HttpApi

#pragma mark - NSURLConnectionDataDelegate

//- (void)httpGet:(NSString *)url withParams:(NSDictionary *)params withTimeout:(NSTimeInterval)timeout
//{
//    [self stop];
//
////    if ([self filterNetWork]) {
////        return;
////    }
//
//    NSMutableString *body = [NSMutableString string];
//
//    if (params) {
//        //参数的集合的所有key的集合
//        NSArray *keys= [params allKeys];
//        //添加其他参数
//        for(int i=0;i<[keys count];i++) {
//            //得到当前key
//            NSString *key=[keys objectAtIndex:i];
//            id value = [params objectForKey:key];
//
//            if ([value isKindOfClass:[NSArray class]]) {
//                NSArray *array = (NSArray *)value;
//
//                for (id item in array) {
//                    if (body.length > 0) {
//                        [body appendString:@"&"];
//                    }
//
//                    [body appendFormat:@"%@[]=%@", key, [self encodeURL:[item description]]];
//                }
//            } else {
//                if (body.length > 0) {
//                    [body appendString:@"&"];
//                }
//
//                [body appendFormat:@"%@=%@", key, [self encodeURL:[value description]]];
//            }
//        }
//    }
//
//    NSString *fullUrl = url;
//
//    if (body.length > 0) {
//        fullUrl = [NSString stringWithFormat:@"%@?%@", url, [body description]];
//    }
//
//    NSLog(@"%@", fullUrl);
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:[self statisticsHeader] forHTTPHeaderField:@"statistics"];
//
//    if (timeout > 0) {
//        [request setTimeoutInterval:timeout];
//    }
//
//    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
//}

- (void)httpPost:(NSString *)url withParams:(NSDictionary *)params withTimeout:(NSTimeInterval)timeout
{
    [self stop];
    
    //    if ([self filterNetWork]) {
    //        return;
    //    }
    
    NSMutableString *body = [NSMutableString string];
    
    if (params) {
        //参数的集合的所有key的集合
        NSArray *keys= [params allKeys];
        
        //添加其他参数
        for(int i=0;i<[keys count];i++) {
            //得到当前key
            NSString *key=[keys objectAtIndex:i];
            id value = [params objectForKey:key];
            
            if ([value isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)value;
                
                for (id item in array) {
                    if (body.length > 0) {
                        [body appendString:@"&"];
                    }
                    
                    [body appendFormat:@"%@[]=%@", key, [self encodeURL:[item description]]];
                }
            } else {
                
                if (body.length > 0) {
                    [body appendString:@"&"];
                }
                
                [body appendFormat:@"%@=%@", key, [self encodeURL:[value description]]];
            }
        }
    }
    
    NSLog(@"%@", url);
    NSLog(@"%@", body);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    //    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (timeout > 0) {
        
        self.timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(onTimeout:) userInfo:nil repeats:NO];
    }
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

/**
 * 上传文件
 * files:key-文件标识 value-文件路径
 */
- (void)httpPostFile:(NSString *)url withParams:(NSDictionary *)params withFile:(NSDictionary *)files withTimeout:(NSTimeInterval)timeout
{
    //    if ([self filterNetWork]) {
    //        return;
    //    }
    
    NSMutableDictionary *newDictionary = [NSMutableDictionary dictionary];
    NSArray *keys = [files allKeys];
    for (int i = 0; i < [keys count]; i++) {
        NSString *key = [keys objectAtIndex:i];
        NSString *filePath = [files objectForKey:key];
        NSString *fileName = [filePath lastPathComponent];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        [newDictionary setObject:[NSArray arrayWithObjects:fileName, data, nil] forKey:key];
    }
    [self httpPostData:url withParams:params withData:newDictionary withTimeout:timeout];
}

/**
 * 上传文件内容
 * datas:key-文件标识 value-array(0-文件名,1-文件内容)
 */
- (void)httpPostData:(NSString *)url withParams:(NSDictionary *)params withData:(NSDictionary *)datas withTimeout:(NSTimeInterval)timeout
{
    [self stop];
    
    //    if ([self filterNetWork]) {
    //        return;
    //    }
    
    NSString *hyphens = @"--";
    NSString *boundary = @"*****";
    NSString *end = @"\r\n";
    
    NSMutableData *myRequestData1=[NSMutableData data];
    
    if (datas) {
        //遍历数组，添加多张图片
        NSArray *dataKeys= [datas allKeys];
        for (int i = 0; i < [dataKeys count]; i ++) {
            NSString *key=[dataKeys objectAtIndex:i];
            NSArray *arr = [datas objectForKey:key];
            if (arr.count < 2) {
                continue;
            }
            
            NSString *fileName = [arr objectAtIndex:0];
            NSData *data = [arr objectAtIndex:1];
            
            //所有字段的拼接都不能缺少，要保证格式正确
            [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
            [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
            [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSMutableString *fileTitle=[[NSMutableString alloc]init];
            //要上传的文件名和key，服务器端用file接收
            [fileTitle appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"", key, fileName];
            
            [fileTitle appendString:end];
            
            [fileTitle appendString:[NSString stringWithFormat:@"Content-Type:%@%@", [self mimeTypeForFileAtPath:fileName], end]];
            [fileTitle appendString:end];
            
            [myRequestData1 appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
            
            [myRequestData1 appendData:data];
            
            [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
            
        }
        
        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (params) {
        //参数的集合的所有key的集合
        NSArray *keys= [params allKeys];
        
        //添加其他参数
        for(int i=0;i<[keys count];i++) {
            
            NSMutableString *body=[[NSMutableString alloc]init];
            [body appendString:hyphens];
            [body appendString:boundary];
            [body appendString:end];
            //得到当前key
            NSString *key=[keys objectAtIndex:i];
            //添加字段名称
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"", key];
            
            [body appendString:end];
            
            [body appendString:end];
            
            //添加字段的值
            [body appendFormat:@"%@", [params objectForKey:key]];
            
            [body appendString:end];
            
            [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
            
            //            NSLog(@"%@=%@", key, [params objectForKey:key]);
        }
    }
    
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:20];
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[self statisticsHeader] forHTTPHeaderField:@"statistics"];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData1 length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData1];
    //http method
    [request setHTTPMethod:@"POST"];
    
    if (timeout > 0) {
        self.timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(onTimeout:) userInfo:nil repeats:NO];
    }
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)stop
{
    if (self.connection) {
        [self.connection cancel];
        self.connection = nil;
    }
    
    if (self.timeoutTimer) {
        [self.timeoutTimer invalidate];
        self.timeoutTimer = nil;
    }
}

- (void)onTimeout:(NSTimer *)timer
{
    if (self.connection) {
        [self.connection cancel];
        self.connection = nil;
    }
    
    self.timeoutTimer = nil;
    
    if (self.delegate) {
        ApiResponse *apiResponse = [[ApiResponse alloc] init];
        
        if ([self.delegate apiWillFinishLoading:apiResponse withTag:self.tag]) {
            [self.delegate apiDidFinishLoading:apiResponse withTag:self.tag];
        }
    }
}


#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData = [NSMutableData data];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    self.statusCode = httpResponse.statusCode;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
 
    [self.receiveData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.timeoutTimer) {
        
        [self.timeoutTimer invalidate];
        self.timeoutTimer = nil;
    }
    self.connection = nil;

//    NSError *error = nil;

   
    if (self.statusCode != 200) {
        NSError *err;
        
        NSString *message = [NSString stringWithFormat:@"请求错误"];
        
        if (self.receiveData.length > 0 && (self.statusCode == 400 || self.statusCode == 401 || self.statusCode == 402 || self.statusCode == 403 || self.statusCode == 410)) {
            message = [[NSString alloc] initWithData:self.receiveData encoding:NSUTF8StringEncoding];
        }
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:self.statusCode], @"status", message, @"message", nil];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
        
        if (data != nil) {
            self.receiveData = [NSMutableData dataWithData:data];
        }
    }
    //    NSLog(@"%@", [[NSString alloc] initWithData:self.receiveData encoding:NSUTF8StringEncoding]);
    
    
    if (self.delegate) {
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.receiveData options:NSJSONReadingMutableContainers error:&error];
        ApiResponse *apiResponse = [[ApiResponse alloc] init];
        
        id statusObject = [dict objectForKey:@"status"];
        id messageObject = [dict objectForKey:@"msg"];
        id dataObject = [dict objectForKey:@"data"];
        id errcode=[dict objectForKey:@"errCode"];
        
        apiResponse.errorcode=[NSString stringWithFormat:@"%@",errcode];
        
        if (statusObject && [statusObject isKindOfClass:[NSNumber class]]) {
            apiResponse.status = [NSString stringWithFormat:@"%@",statusObject] ;
        }
        
        if (messageObject) {
            apiResponse.message = [messageObject description];
        }
        
        
        if ([apiResponse.status intValue]==1) {
            //                if ([dataObject isKindOfClass:[NSDictionary class]]) {
            //                    NSDictionary *dataDict = dataObject;
            apiResponse.data=dataObject;
            
            //                }
            
        }
        
     
        else{
            
            
            [apiResponse parse:self.receiveData withReturnClassName:self.returnClassName];
            
        }
        
        if ([self.delegate apiWillFinishLoading:apiResponse withTag:self.tag]) {
            [self.delegate apiDidFinishLoading:apiResponse withTag:self.tag];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.timeoutTimer) {
        [self.timeoutTimer invalidate];
        self.timeoutTimer = nil;
    }
    
    self.connection = nil;
    
    if (self.delegate) {
        
        ApiResponse *apiResponse = [[ApiResponse alloc] init];
        
        if ([self.delegate apiWillFinishLoading:apiResponse withTag:self.tag]) {
            [self.delegate apiDidFinishLoading:apiResponse withTag:self.tag];
        }
        
    }
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return NO;
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
}

#pragma mark - private
- (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return @"";
}

- (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
    // Borrowed from http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)MIMEType;
}

- (BOOL) filterNetWork
{
    //    AHReach * defaultHostReach = [AHReach reachForDefaultHost];
    //    if(![defaultHostReach isReachable]) {
    //
    //        ApiResponse *apiResponse = [[ApiResponse alloc] init];
    //        apiResponse.status = 101;
    //        apiResponse.message = @"网络连接失败，请检查网络！";
    //        apiResponse.data = nil;
    //
    //        if ([self.delegate apiWillFinishLoading:apiResponse withTag:self.tag]) {
    //            [self.delegate apiDidFinishLoading:apiResponse withTag:self.tag];
    //        }
    //
    //        return YES;
    //
    //    } else {
    //
    //        return NO;
    //    }
    return YES;
}

- (NSString *)statisticsHeader
{
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    
    //    Iffomation *iffomation = [Iffomation createInformations];
    
    [header setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [header setValue:@"appstore" forKey:@"channel"];
    [header setValue:@"1" forKey:@"system_type"];
    [header setValue:@"4.0" forKey:@"api_version"];
    [header setValue:[[UIDevice currentDevice] systemVersion] forKey:@"system_version"];
    [header setValue:[[UIDevice currentDevice] model] forKey:@"system_model"];
    //    [header setValue:iffomation.registerMac forKey:@"mac"];
    //    [header setValue:iffomation.registerIdfa forKey:@"idfa"];
    //    [header setValue:iffomation.registerIdfv forKey:@"idfv"];
    
    NSArray *keys = [[header allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableString *signString = [NSMutableString string];
    NSMutableString *result = [NSMutableString string];
    
    for (NSString *key in keys) {
        [signString appendFormat:@"%@=%@&", key, [header valueForKey:key]];
        
        [result appendFormat:@"%@=%@&", key, [self encodeURL:[header valueForKey:key]]];
    }
    
    [signString appendString:@"key=lsj92oWEjou2309u"];
    
    [result appendFormat:@"sign=%@", [self signMd5:signString]];
    
    return result;
}

- (NSString *)signMd5:(NSString *)src
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    const char *original_str = [src UTF8String];
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return hash;
}

@end
