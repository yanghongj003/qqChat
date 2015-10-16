//
//  ChatView.h
//  qq聊天
//
//  Created by zpon on 15-4-10.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatViewDelegate <NSObject>
@optional
- (void)chatViewDelegateEmotionAction;
- (void)chatViewDelegateAddAction;
- (void)chatViewDelegateSoundAction;
@end
@interface ChatView : UIView
@property (nonatomic,weak) id <ChatViewDelegate> delegate;
@end
