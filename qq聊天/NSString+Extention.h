//
//  NSString+extion.h
//  微博04
//
//  Created by zpon on 15-4-6.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface NSString (Extention)

/**
 *  计算文字的size,
 *
 *  @param width,font 给定的最大宽度,字体大小
 */
- (CGSize)calculateSizeWithMaxWidth:(CGFloat)width WithFont:(UIFont *)font;

@end
