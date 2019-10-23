//
//  SAModalTransitionManager.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/22.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAModalTransitionManager.h"
#import "SAClipPlayerToftView.h"

/// 动画持续时间
static const CGFloat KTransitionDuration = 0.3;

@interface SAModalTransitionManager()

@end

@implementation SAModalTransitionManager

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return KTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    if (toVC.isBeingPresented) { // 入场动效
        toView.alpha = 0.0;
        [containerView addSubview:toView];
        
        CGRect toFrame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        toView.frame = toFrame;
        
        CGRect fromRect = [self getFrameInWindowWithView:self.playerController.sourceContainerView];
       
        UIView *view = self.playerController.toftView;
        view.frame = fromRect;
        [containerView addSubview:view];
        
        CGFloat toH = ScreenWidth * self.playerController.videoScale;
        CGRect viewToFrame = CGRectMake(0, (ScreenHeight - toH) * 0.5, ScreenWidth, toH);

        [view layoutSubviews];
        [view setNeedsLayout];
        
        [UIView animateWithDuration:KTransitionDuration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            toView.alpha = 1;
            view.frame = viewToFrame;
        } completion:^(BOOL finished) {
            [toView addSubview:view];
            [toView sendSubviewToBack:view];
            [transitionContext completeTransition:YES];
        }];
    } else {
        CGRect toRect = [self getFrameInWindowWithView:self.playerController.sourceContainerView];
        SAClipPlayerToftView *toftView = self.playerController.toftView;
        toftView.playerScreenView.hidden = YES;
        fromView.backgroundColor = [UIColor clearColor];
        
        [UIView animateWithDuration:KTransitionDuration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            toftView.frame = toRect;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

#pragma mark - Utility
- (CGRect)getFrameInWindowWithView:(UIView *)view {
    return view ? [view convertRect:view.bounds toView:[self getNormalWindow]] : CGRectZero;
}

- (UIWindow *)getNormalWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * temp in windows) {
            if (temp.windowLevel == UIWindowLevelNormal) {
                window = temp;
                break;
            }
        }
    }
    return window;
}


@end
