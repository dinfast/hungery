//
//  HttpApi.h
//  XtuanMoive
//
//  Created by ppl on 14-11-4.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AHReach.h"
#import "ApiResponse.h"

@interface HttpApi : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<ApiResponseDelegate> delegate;
@property (nonatomic, strong) NSObject *tag;
@property (nonatomic, strong) NSString *returnClassName;

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *receiveData;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSTimer *timeoutTimer;

- (void)httpGet:(NSString *)url withParams:(NSDictionary *)params withTimeout:(NSTimeInterval)timeout;
- (void)httpPost:(NSString *)url withParams:(NSDictionary *)params withTimeout:(NSTimeInterval)timeout;
- (void)httpPostFile:(NSString *)url withParams:(NSDictionary *)params withFile:(NSDictionary *)files withTimeout:(NSTimeInterval)timeout;
- (void)httpPostData:(NSString *)url withParams:(NSDictionary *)params withData:(NSDictionary *)datas withTimeout:(NSTimeInterval)timeout;

- (void)stop;

@end
