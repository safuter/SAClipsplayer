//
//  SAInteractiveManager.m
//  SAClipsplayer
//
//  Created by zheng on 2019/11/21.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAInteractiveManager.h"

@interface SAInteractiveManager()
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign) CGFloat startScale;
@end

@implementation SAInteractiveManager
- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self = [super init]) {
        _isInteractive = NO;
        _viewController = viewController;
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.viewController.view].x / (self.viewController.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    NSLog(@"------- %f", progress);
    self.isInteractive = YES;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        [self.viewController dismissViewControllerAnimated:YES completion:^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:KVideoFeedDetailControllerDismissNotification object:nil];
        }];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.3) {
            [self finishInteractiveTransition];
        }
        
        else {
            [self cancelInteractiveTransition];
        }
        
        self.isInteractive = NO;
    }
}

@end
