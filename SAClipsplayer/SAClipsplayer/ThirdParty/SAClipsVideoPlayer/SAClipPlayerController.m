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

@interface SAClipPlayerController () <SAClipPlayerHandleViewDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) SAPlayerViewModel *playerViewModel;
@property (nonatomic, strong) SAClipPlayerHandleView *handleView;

@property (nonatomic, strong) SAModalTransitionManager *transitionManager;
@end

@implementation SAClipPlayerController

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
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _toftView = [[SAClipPlayerToftView alloc] init];
    _toftView.corverImageUrl = _corverImgUrl;
    _toftView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_toftView];
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

#pragma mark - System Delegate Methods
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.transitionManager;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.transitionManager;
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
