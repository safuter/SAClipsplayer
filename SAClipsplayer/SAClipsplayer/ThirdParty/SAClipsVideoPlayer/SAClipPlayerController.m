//
//  SAClipPlayerController.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAClipPlayerController.h"
#import "SAPlayerViewModel.h"
#import "SAClipPlayerHandleView.h"
#import "SAModalTransitionManager.h"
#import "SAInteractiveManager.h"

@interface SAClipPlayerController () <SAClipPlayerHandleViewDelegate,UIViewControllerTransitioningDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) SAPlayerViewModel *playerViewModel;
@property (nonatomic, strong) SAClipPlayerHandleView *handleView;

@property (nonatomic, strong) SAModalTransitionManager *transitionManager;
// 转场动画手势交互管理器
@property (nonatomic, strong) SAInteractiveManager *interactiveManager;
@end

@implementation SAClipPlayerController {
    CGFloat startScaleWidthInAnimationView; //开始拖动时比例
    CGFloat startScaleheightInAnimationView;    //开始拖动时比例
    CGRect frameOfOriginalOfImageView;  //开始拖动时图片frame
    CGFloat totalOffsetXOfAnimateVideoView; //总共的拖动偏移x
    CGFloat totalOffsetYOfAnimateVideoView; //总共的拖动偏移y
    CGFloat lastPointX; //上一次触摸点x值
    CGFloat lastPointY; //上一次触摸点y值
    CGRect frameOfOriginalOfVideoViewFrame;
    CGFloat dragScale; // 拖动中比例
}

- (instancetype)initWithPlayUrlStr:(NSString *)playUrlStr
                      corverUrlStr:(NSString *)corverUrlStr
                        videoScale:(CGFloat)videoScale {
    if (self = [super init]) {
        self.url = playUrlStr;
        self.corverImgUrl = corverUrlStr;
        self.videoScale = videoScale;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitionManager = [[SAModalTransitionManager alloc] init];
        self.transitionManager.playerController = self;
        self.transitionManager.animationType = SAVideoFeedTransitionTypeMove;
        self.transitioningDelegate = self;
        
        self.interactiveManager = [[SAInteractiveManager alloc] initWithViewController:self];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _toftView = [[SAClipPlayerToftView alloc] init];
    _toftView.corverImageUrl = _corverImgUrl;
    _toftView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.view addSubview:_toftView];
    
    UIPanGestureRecognizer *panGestureRecognizer =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)dealloc {
    NSLog(@"vc dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(activityStart) name:SA_NOTIFICATION_NAME_START_ACTIVITY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(activityStop) name:SA_NOTIFICATION_NAME_STOP_ACTIVITY object:nil];
}

- (void)activityStart {
    [self.handleView startActivity];
}

- (void)activityStop {
    [self.handleView stopActivity];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private
- (void)setupPlayerViewModel {
    NSString *urlStr = [self.url copy];
    _playerViewModel = [[SAPlayerViewModel alloc] initWithUrlStr:urlStr];
    
    [_toftView setPlayer:_playerViewModel.player];
    
    _handleView = [[SAClipPlayerHandleView alloc] init];
    _handleView.delegate = self;
    _toftView.handleView = _handleView;
    
    weak_block_self;
    _playerViewModel.playStateChanged = ^(SAPlayState playState) {
        NSLog(@"block 调用");
        weakSelf.handleView.playState = playState;
        
    };
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    back.frame = CGRectMake(20, 80, 40, 40);
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
   
    [self setupNotification];
}

#pragma mark - Action
- (void)panGestureAction:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.view];

    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (_transitionManager.animationType == SAVideoFeedTransitionTypeMove) {
                        CGFloat progress = [gestureRecognizer translationInView:self.view].y / (self.view.bounds.size.height * 1.0);
            progress = MIN(1.0, MAX(0.0, progress));
            NSLog(@"------ %f", progress);
            
            if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
                [self dragWithPoint:point container:self.view];
            }
        } else {
            [self.interactiveManager panGestureAction:gestureRecognizer];
        }
    }


    
//    return;
//
    
    // 修改动画类型 侧滑返回时候用侧滑返回的动画
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        self.transitionManager.animationType = SAVideoFeedTransitionTypeSlide;
        
        
        CGPoint velocityPoint = [gestureRecognizer velocityInView:self.view];
        if (velocityPoint.x > velocityPoint.y) {
            _transitionManager.animationType = SAVideoFeedTransitionTypeSlide;
                        [self.interactiveManager panGestureAction:gestureRecognizer];
        } else {
                        _transitionManager.animationType = SAVideoFeedTransitionTypeMove;
            
            self.view.backgroundColor = [UIColor clearColor];

            frameOfOriginalOfImageView = [self.toftView convertRect:self.toftView.bounds toView:[SAUtility getCurrentWindow]];
            frameOfOriginalOfVideoViewFrame = self.toftView.frame;
            startScaleWidthInAnimationView = (point.x - frameOfOriginalOfImageView.origin.x) / frameOfOriginalOfImageView.size.width;
            startScaleheightInAnimationView = (point.y - frameOfOriginalOfImageView.origin.y) / frameOfOriginalOfImageView.size.height;
            

            lastPointY = point.y;
            lastPointX = point.x;
        }
        
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_transitionManager.animationType == SAVideoFeedTransitionTypeMove) { // 下拉返回
            if (dragScale >= 0.6) { // 恢复
                [UIView animateWithDuration:0.2 delay:0.03 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionLayoutSubviews animations:^{
                    self.toftView.frame = frameOfOriginalOfVideoViewFrame;
                    self.view.backgroundColor = [UIColor blackColor];
                } completion:^(BOOL finished) {
                    totalOffsetXOfAnimateVideoView = 0.0;
                    totalOffsetYOfAnimateVideoView = 0.0;
                    frameOfOriginalOfVideoViewFrame = CGRectZero;
                }];
                return;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        } else { // 右滑返回
            [self.interactiveManager panGestureAction:gestureRecognizer];
            self.transitionManager.animationType = SAVideoFeedTransitionTypeMove;
        }
    }
}

- (void)dragWithPoint:(CGPoint)point container:(UIView *)container {
    

    CGFloat maxHeight = frameOfOriginalOfVideoViewFrame.size.height;
    if (maxHeight <= 0) return;
    
    CGFloat offsetX = point.x - lastPointX;
    CGFloat offsetY = point.y - lastPointY;

    totalOffsetXOfAnimateVideoView += offsetX;
    totalOffsetYOfAnimateVideoView += offsetY;

    NSLog(@"---------totalOffsetYOfAnimateVideoView = %f", totalOffsetYOfAnimateVideoView);
    //缩放比例
    CGFloat scale = (1 - totalOffsetYOfAnimateVideoView / maxHeight);
    if (scale > 1) scale = 1;
    if (scale < 0) scale = 0;
    
    if (scale < 0.5) {
        scale = 0.5;
    }
    dragScale = scale;
    
    NSLog(@"---------scale = %f", scale);
    CGFloat height = (frameOfOriginalOfVideoViewFrame.size.height)* scale;

    CGFloat width = height / _videoScale;
    
    self.toftView.frame = CGRectMake(point.x - width * startScaleWidthInAnimationView, point.y - height * startScaleheightInAnimationView, width, height);
    
    lastPointY = point.y;
    lastPointX = point.x;
}

#pragma mark - UIGestureRecognizerDelegate


#pragma mark - System Delegate Methods
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.transitionManager;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.transitionManager;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {

    // 同时如果返回  interactiveAnimator，那么 animationControllerForDismissedController: 则必须实现
    return self.interactiveManager.isInteractive ? self.interactiveManager : nil;
}

#pragma mark - Custom Delegate Methods
#pragma mark - SAClipPlayerHandleViewDelegate
- (void)playOrPauseAction:(UIButton *)sender {
    if (sender.isSelected) { // playing
        [self.playerViewModel pause];
    } else {
        [self.playerViewModel play];
    }
}

#pragma mark - Getter

@end
