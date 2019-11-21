//
//  SAInteractiveManager.h
//  SAClipsplayer
//
//  Created by zheng on 2019/11/21.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAInteractiveManager : UIPercentDrivenInteractiveTransition <UIViewControllerInteractiveTransitioning>

@property (nonatomic, assign, readwrite) BOOL isInteractive;

- (instancetype)initWithViewController:(UIViewController *)viewController;

- (void)panGestureAction:(UIPanGestureRecognizer *)gestureRecognizer;

@end

NS_ASSUME_NONNULL_END
