//
//  SAKuaishouListCollectionViewCell.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/17.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAKuaishouListCollectionViewCell.h"

@interface SAKuaishouListCollectionViewCell()
/// 封面
@property (nonatomic, strong) UIImageView *corverImageView;
@end

@implementation SAKuaishouListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _corverImageView = [[UIImageView alloc] init];
    [self addSubview:_corverImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _corverImageView.frame = self.bounds;
}

- (void)setFeedModel:(SAVideoFeedModel *)feedModel {
    _feedModel = feedModel;
    
    SAVideoInfoModel *videoInfo = feedModel.videos.firstObject;
    [_corverImageView sd_setImageWithURL:[NSURL URLWithString:videoInfo.firstpic]];
}
@end
