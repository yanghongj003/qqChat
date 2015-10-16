//
//  RegexUtil.m
//  qq聊天
//
//  Created by TomPro on 15/10/15.
//  Copyright © 2015年 zpon. All rights reserved.
//

#import "RegexUtil.h"
#import "RegexEmotion.h"
@implementation RegexUtil

/**
 *  把普通字符串转成富文本字符串
 */
+ (NSAttributedString*)attributeStringWithText:(NSString *)regexStr withTextFont:(UIFont*)font{
    
    NSMutableArray *attributedArray = [self regexSepatorWithText:regexStr];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] init];
    [attributedArray enumerateObjectsUsingBlock:^(RegexEmotion *obj, NSUInteger idx, BOOL *stop) {
        if (obj.isEmotion) { //表情文本
            
            NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
            obj.str = [obj.str  stringByReplacingOccurrencesOfString:@"[" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, obj.str.length)] ;
            obj.str = [obj.str  stringByReplacingOccurrencesOfString:@"]" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, obj.str.length)] ;
            
            NSString *imageName = [NSString stringWithFormat:@"Expression_%@",obj.str];
            attach.image = [UIImage imageNamed:imageName];
            attach.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
            
            NSAttributedString *emotionAttributr = [NSAttributedString attributedStringWithAttachment:attach];
            [attributeStr appendAttributedString:emotionAttributr];
            
        } else { //普通文本
            NSAttributedString *noemotionAttributr = [[NSAttributedString alloc]initWithString:obj.str];
            [attributeStr appendAttributedString:noemotionAttributr];
        }
    }];
    
    [attributeStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributeStr.length)];
  
    return attributeStr;

}
/**
 *  用正则切割文本
 */
+ (NSMutableArray*)regexSepatorWithText:(NSString *)regexStr{
    
    NSMutableArray *attributedArray = [NSMutableArray array];
    // 1:用正则取出表情字符串
    [regexStr enumerateStringsMatchedByRegex: @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        RegexEmotion *emotion = [[RegexEmotion alloc] init];
        emotion.str = *capturedStrings;
        emotion.emotion = YES;
        emotion.range = *capturedRanges;
        [attributedArray addObject:emotion];
    }];
    // 2:用正则切割非表情字符串
    [regexStr enumerateStringsSeparatedByRegex:@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        RegexEmotion *emotion = [[RegexEmotion alloc] init];
        emotion.emotion = NO;
        emotion.str = *capturedStrings;
        emotion.range = *capturedRanges;
        [attributedArray addObject:emotion];
    }];
    // 3:数组按照location排序
    [attributedArray sortUsingComparator:^NSComparisonResult(RegexEmotion *obj1, RegexEmotion *obj2) {
        if (obj1.range.location<obj2.range.location) {
            return NSOrderedAscending;
        }else if (obj1.range.location>obj2.range.location){
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return attributedArray;
}

@end
