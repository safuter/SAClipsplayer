//
//  SAVideoInfoModel.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/17.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAVideoInfoModel : NSObject
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *videourl;
@property (nonatomic, strong) NSString *firstpic; // 封面
@property (nonatomic, assign) NSInteger width; // 视频宽
@property (nonatomic, assign) NSInteger height; // 视频高
@property (nonatomic, assign) NSInteger time; // 时长(秒)
@property (nonatomic, assign) NSInteger playtimes; // 播放次数
@property (nonatomic, strong) NSString *watermark; // 水印下载地址

@property (nonatomic, assign) CGFloat coverImgWidth;  // 视频封面宽度
@property (nonatomic, assign) CGFloat coverImgHeight; // 视频封面高度
@end

NS_ASSUME_NONNULL_END
