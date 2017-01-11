//
//  MyRefresh.m
//  XtuanMoive2.0
//
//  Created by X团 on 14-8-21.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import "MyRefresh.h"
#define STATUS_HEIGHT ([[UIDevice currentDevice].systemVersion doubleValue] < 7.0 ? 44.0 : 64.0)
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//屏幕物理高度
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕物理宽度
#define SCREENWITH   [UIScreen mainScreen].bounds.size.width
@implementation MyRefresh

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        if (frame.size.height == 80.0) {
            
            self.frame = frame;
            
        } else if (frame.size.height == SCREENHEIGHT - STATUS_HEIGHT - 30) {
            
            self.frame = CGRectMake(SCREENWITH/2-40, frame.size.height / 2 - 40, 80, 80);
            
        } else {
            if (IOS_VERSION >= 7.0) {
                self.frame = CGRectMake(SCREENWITH/2-40, SCREENHEIGHT/2-40, 80, 80);
                
            } else {
                self.frame = CGRectMake(SCREENWITH/2-40, (SCREENHEIGHT-20)/2-40, 80, 80);
            }
        }
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40-24, 40-24, 48, 48)];
        imageView.userInteractionEnabled = YES;
        UIImage *aImage = [UIImage imageNamed:@"loading.png"];
        imageView.image = aImage;
        [self addSubview:imageView];
        self.loadingImage = imageView;
    }
    
    return self;
}

/*
 * 停止菊花转动
 */
-(void)stopAcivity
{
    //界面消失
    angle = 0;
    isStopAnimation = YES;
    [self removeFromSuperview];
}

/*
 * 展示刷新图标
 */
-(void)show
{
    //root
    UIViewController * root = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (root.presentedViewController) {
        root = root.presentedViewController;
    }
    
    self.frame = CGRectMake(SCREENWITH/2-40, SCREENHEIGHT/2-40, 80, 80);
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    [root.view addSubview:self];
    
    //转动
    isStopAnimation = NO;
    [self startAnimation];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
//    [timer fireDate];//启动定时器
}

//将视图贴在所在的ViewController中，而
-(void)start
{
    //转动
    isStopAnimation = NO;
    [self startAnimation];
}

-(void)remove
{
    //界面消失
    angle = 0;
    isStopAnimation = YES;
}

//开始转动
-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    if (isStopAnimation) {
        [UIView setAnimationDelegate:nil];
    }else
    {
        [UIView setAnimationDelegate:self];
    }
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    _loadingImage.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

//停止转动
-(void)endAnimation
{
    angle += 5;
    [self startAnimation];
}

//定时器，判断连接超时
-(void)timerFired:(NSTimer *)time
{
    [self stopAcivity];
    [time invalidate];//停止定时器
}

@end
