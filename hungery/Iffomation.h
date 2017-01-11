//
//  Iffomation.h
//  XtuanMoive2.0
//
//  Created by X团 on 14-7-11.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeanUser.h"
#import "NSKeyedUnarchiver+SafeUnarchive.h"
@interface Iffomation : NSObject
+ (Iffomation *)createInformations;

- (void)writeToFile;
- (void)readFromFile;
- (void)removeFile;
/**
 *
 * 用户数据  BeanBuyer
 */


@property (strong, nonatomic) BeanUser*beanuser;




@end
