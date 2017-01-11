//
//  ApiRequest.h
//  mjbang
//
//  Created by auto on 2015-06-08.
//  Copyright (c) 2015 mjbang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiRequest : NSObject

/**
 * 判断用户是否已登录
 */
+ (BOOL)isLogin;

/**
 * cookie处理
 */
+ (void)cookieProcess;


+ (void)httpPost:(NSString *)url withParams:(NSDictionary *)params withDelegate:(id)delegate withTag:(NSObject *)tag withReturnClassName:(NSString *)className;

@end
