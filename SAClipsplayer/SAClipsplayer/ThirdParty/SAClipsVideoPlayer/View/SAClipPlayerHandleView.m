//
//  SAClipPlayerHandleView.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/20.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAClipPlayerHandleView.h"
#import "SAClipLoadingView.h"

@interface SAClipPlayerHandleView()
@property (nonatomic, strong) UIButton *playOrPauseBtn;
@property (nonatomic, strong) SAClipLoadingView *loadingView;

@property (nonatomic, copy) dispatch_block_t hideOutControlViewBlock;

@property (nonatomic, strong) NSMutableArray *hideControlViewTasksArray;
@end

@implementation SAClipPlayerHandleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _loadingView = [[SAClipLoadingView alloc] init];
    [self addSubview:_loadingView];
    
    [self addSubview:self.playOrPauseBtn];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    [self addGestureRecognizer:singleTap];
}

#pragma mark - Public
- (void)startActivity {
    [_loadingView startActivity];
}

- (void)stopActivity {
    [_loadingView stopActivity];
}

#pragma mark - Private
static NSInteger blockIndex = 0;
- (void)showOutControlView {
    
    [self.hideControlViewTasksArray enumerateObjectsUsingBlock:^(dispatch_block_t  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_block_cancel(obj);
    }];

    dispatch_block_t block = dispatch_block_create(0, ^{
        [self hideOutControlView];
    });

    blockIndex++;
    
    [self.hideControlViewTasksArray addObject:block];
    
    [self cancelBlock:blockIndex - 1];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.playOrPauseBtn.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)cancelBlock:(NSInteger)index {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.hideControlViewTasksArray.count > index) {
            dispatch_block_t block = [self.hideControlViewTasksArray objectAtIndex:index];
            if (block) {
                block();
            }
        }
    });
}

- (void)hideOutControlView {
    [UIView animateWithDuration:1 animations:^{
        self.playOrPauseBtn.hidden = YES;
    }];
}

#pragma mark - Action
- (void)singleTapAction {
    if (!self.showControlView) {
        [self showOutControlView];
    } else {
        [self hideOutControlView];
    }
}

- (void)playOrPauseVideo:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playOrPauseAction:)]) {
        [self.delegate playOrPauseAction:sender];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _loadingView.frame = CGRectMake(0, 0, 66, 66);
    _loadingView.center = self.center;
    
    _playOrPauseBtn.frame = CGRectMake(0, 0, 44, 44);
    _playOrPauseBtn.center = self.center;
}

#pragma mark - Getter
- (UIButton *)playOrPauseBtn {
    if (!_playOrPauseBtn) {
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"Feed_Video_Play_Btn"] forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"Feed_Video_Pause"] forState:UIControlStateSelected];
        [_playOrPauseBtn addTarget:self action:@selector(playOrPauseVideo:) forControlEvents:UIControlEventTouchUpInside];
        _playOrPauseBtn.hidden = YES;
    }
    return _playOrPauseBtn;
}

- (NSMutableArray *)hideControlViewTasksArray {
    if (!_hideControlViewTasksArray) {
        _hideControlViewTasksArray = [NSMutableArray array];
    }
    return _hideControlViewTasksArray;
}

- (BOOL)showControlView {
    return !self.playOrPauseBtn.hidden;
}

- (void)setPlayState:(SAPlayState)playState {
    if (_playState == playState) {
        return;
    }
    _playState = playState;
    self.playOrPauseBtn.selected = playState == SAPlayStatePlaying;
}

@end
