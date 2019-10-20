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

@interface SAClipPlayerController ()
@property (nonatomic, strong) SAPlayerViewModel *playerViewModel;
@property (nonatomic, strong) SAClipPlayerToftView *toftView;
@end

@implementation SAClipPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _playerViewModel = [[SAPlayerViewModel alloc] initWithUrlStr:self.url];
    
    _toftView = [[SAClipPlayerToftView alloc] init];
    _toftView.player = _playerViewModel.player;
    _toftView.corverImageUrl = self.corverImgUrl;
    [self.view addSubview:_toftView];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    back.frame = CGRectMake(20, 80, 40, 40);
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _toftView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}


@end
