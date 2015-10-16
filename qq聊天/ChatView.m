//
//  ChatView.m
//  qq聊天
//
//  Created by zpon on 15-4-10.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import "ChatView.h"

@interface ChatView()
@property (nonatomic,weak) IBOutlet UIButton *emotionBtn;
@property (nonatomic,weak) IBOutlet UIButton *addBtn;
@property (nonatomic,weak) IBOutlet UIButton *soundBtn;
@end

@implementation ChatView
- (void)awakeFromNib {
    self.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark -按钮点击
- (IBAction)soundBtnAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(chatViewDelegateSoundAction)]) {
        [self.delegate chatViewDelegateSoundAction];
    }
}
- (IBAction)addBtnAction:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(chatViewDelegateAddAction)]) {
        [self.delegate chatViewDelegateAddAction];
    }
}
- (IBAction)emotionBtnAction:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(chatViewDelegateEmotionAction)]) {
        [self.delegate chatViewDelegateEmotionAction];
    }
}
@end
