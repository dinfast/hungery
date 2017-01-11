#import "UIViewExt.h"
#import "Toast+UIView.h"
#import <QuartzCore/QuartzCore.h>
#import "MyRefresh.h"
#import "ApiRequest.h"
#import "ApiResponse.h"
#import "Iffomation.h"
#import "BeanUser.h"
#import "BeanCustomer.h"
#import "iffmCustomers.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


//#import "RCCallSingleCallViewController.h"
//#import <RongIMKit/RongIMKit.h>
//屏幕物理高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define COLOR(R,G,B,A) [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:A]
