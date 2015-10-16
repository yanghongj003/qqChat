//
//  EmotionView.h
//  qq聊天
//
//  Created by TomPro on 15/10/15.
//  Copyright © 2015年 zpon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Emotion;
@protocol EmotionViewDelegate <NSObject>
@optional
- (void)emotionViewDelegateClickEmotion:(Emotion *)emotion;
@end

@interface EmotionView : UIView

@property (nonatomic,weak) id <EmotionViewDelegate> delegate;

@end
