//
//  XTLabel.m
//  XtuanMoive
//
//  Created by X团 on 14-12-3.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import "XTLabel.h"
#define FONTSIZESYSFONT(A) [UIFont systemFontOfSize:A];

@implementation XTLabel

-(id)init {

    self = [super init];
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.color = [UIColor clearColor];
    
    [super touchesBegan:touches withEvent:event];
    

}

-(void)withcontent:(NSString*)content andfont:(CGFloat)size andlimitwidt:(CGFloat)limtwidt andx:(CGFloat)x andy:(CGFloat)y andtextcolor:(UIColor*)color
{
        self.numberOfLines=0;
        UIFont *fnt = FONTSIZESYSFONT(size);
        CGRect tmpRect = [content boundingRectWithSize:CGSizeMake(limtwidt, 1000000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
        CGFloat heig = tmpRect.size.height;
        self.frame=CGRectMake(x, y,tmpRect.size.width, heig);
        self.font=[UIFont systemFontOfSize:size];
        self.textColor=color;
        self.text=content;
  
        
        
   
}

-(void)withcentercontent:(NSString*)content andfont:(CGFloat)size andlimitwidt:(CGFloat)limtwidt andx:(CGFloat)x andy:(CGFloat)y andtextcolor:(UIColor*)color
{
    self.numberOfLines=0;
    UIFont *fnt = FONTSIZESYSFONT(size);
    CGRect tmpRect = [content boundingRectWithSize:CGSizeMake(limtwidt, 1000000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    CGFloat heig = tmpRect.size.height;
    self.frame=CGRectMake(limtwidt/2-tmpRect.size.width/2, y,tmpRect.size.width, heig);
    self.font=[UIFont systemFontOfSize:size];
    self.textColor=color;
    self.text=content;
    
    
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    [self setBackgroundColor:self.color];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesCancelled:touches withEvent:event];
    [self setBackgroundColor:self.color];
}

@end
