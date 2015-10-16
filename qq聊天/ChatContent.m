//
//  ChatContent.m
//  qq聊天
//
//  Created by zpon on 15-4-10.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import "ChatContent.h"

@implementation ChatContent

+ (instancetype)chatContentWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (NSAttributedString *)attributedStr{
    _attributedStr = [RegexUtil attributeStringWithText:self.text withTextFont:[UIFont systemFontOfSize:15]];
    return _attributedStr;
}
@end
