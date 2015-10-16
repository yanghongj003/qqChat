//
//  NSString+extion.m
//  微博04
//
//  Created by zpon on 15-4-6.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import "NSString+extention.h"

@implementation NSString (Extention)

- (CGSize)calculateSizeWithMaxWidth:(CGFloat)width WithFont:(UIFont *)font
{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size;
}

@end
