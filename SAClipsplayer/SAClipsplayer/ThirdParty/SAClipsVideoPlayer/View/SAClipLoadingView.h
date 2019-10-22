//
//  SAClipLoadingView.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/20.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAClipLoadingView : UIView

/// default is whiteColor.
@property (nonatomic, strong) UIColor *lineColor;

/// Sets the line width of the spinner's circle.
@property (nonatomic) CGFloat lineWidth;

/// Sets whether the view is hidden when not animating.
@property (nonatomic) BOOL hidesWhenStopped;

/// Property indicating the duration of the animation, default is 1.5s.
@property (nonatomic, readwrite) NSTimeInterval duration;


- (void)startActivity;
- (void)stopActivity;

@end

NS_ASSUME_NONNULL_END
