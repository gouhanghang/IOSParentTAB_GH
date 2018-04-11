//
//  ValidateTool.m
//  ParentTAB_GH
//
//  Created by 苟应航 on 2018/4/10.
//  Copyright © 2018年 GouHang. All rights reserved.
//

#import "ValidateTool.h"

@implementation ValidateTool
//这里要移到另外一个类
+ (UIColor *)colorWithHex:(NSString *)hexColor
{
    
    if (hexColor == nil) {
        return nil;
    }
    if ([hexColor length] < 7 ) {
        return nil;
    }
    
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
    
}

@end
