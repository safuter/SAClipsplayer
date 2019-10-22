//
//  SAClipPlayerController.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/18.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAClipPlayerController.h"
#import "SAPlayerViewModel.h"
#import "SAClipPlayerToftView.h"
#import "SAClipPlayerHandleView.h"

@interface SAClipPlayerController () <SAClipPlayerHandleViewDelegate>
@property (nonatomic, strong) SAPlayerViewModel *playerViewModel;
@property (nonatomic, strong) SAClipPlayerToftView *toftView;
@property (nonatomic, strong) SAClipPlayerHandleView *handleView;
@end

@implementation SAClipPlayerController

- (instancetype)initWithPlayUrlStr:(NSString *)playUrlStr corverUrlStr:(NSString *)corverUrlStr {
    if (self = [super init]) {
        self.url = playUrlStr;
        self.corverImgUrl = corverUrlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _playerViewModel = [[SAPlayerViewModel alloc] initWithUrlStr:self.url];
    
    _toftView = [[SAClipPlayerToftView alloc] init];
    _toftView.player = _playerViewModel.player;
    _toftView.corverImageUrl = _corverImgUrl;
    [self.view addSubview:_toftView];
    
    _handleView = [[SAClipPlayerHandleView alloc] init];
    _handleView.delegate = self;
    _toftView.handleView = _handleView;
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    back.frame = CGRectMake(20, 80, 40, 40);
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    [self setupNotification];
    
    weak_block_self;
    _playerViewModel.playStateChanged = ^(SAPlayState playState) {
        weakSelf.handleView.playState = playState;
    };
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _toftView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}

#pragma mark - SAClipPlayerHandleViewDelegate
- (void)playOrPauseAction:(UIButton *)sender {
    if (sender.isSelected) { // playing
        [self.playerViewModel pause];
    } else {
        [self.playerViewModel play];
    }
}

@end
