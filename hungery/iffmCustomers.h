//
//  iffmCustomers.h
//  naocutong
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeanCustomer.h"
#import "NSKeyedUnarchiver+SafeUnarchive.h"
@interface iffmCustomers : NSObject
+ (iffmCustomers *)createInformations;

- (void)writeToFile;
- (void)readFromFile;
- (void)removeFile;
/**
 *
 * 用户数据  BeanBuyer
 */


@property (strong, nonatomic) BeanCustomer*beanCustomer;
@end
