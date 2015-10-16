//
//  RegexUtil.h
//  qq聊天
//
//  Created by TomPro on 15/10/15.
//  Copyright © 2015年 zpon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexUtil : NSObject
/**
 *  把普通字符串转成富文本字符串
 */
+ (NSAttributedString*)attributeStringWithText:(NSString *)regexStr withTextFont:(UIFont*)font;
@end
