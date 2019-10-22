//
//  SAKuaiShouListViewController.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/17.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SAKuaiShouListViewController.h"
#import "SAKuaishouListCollectionViewCell.h"

#import "SAClipPlayerController.h"

NSString * const KuaiShouCollectionListCellID = @"KuaiShouCollectionListCellID";

@interface SAKuaiShouListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

// 数据源
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SAKuaiShouListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self requestList];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
}

// 模仿网络请求
- (void)requestList {
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list.json" ofType:nil]];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    self.dataList = [SAVideoFeedModel mj_objectArrayWithKeyValuesArray:[jsonDict objectForKey:@"data"]];
    [self.collectionView reloadData];
    NSLog(@"%@",self.dataList);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SAVideoFeedModel *model = [self.dataList objectAtIndex:indexPath.row];
    
    SAClipPlayerController *playerVC = [[SAClipPlayerController alloc] initWithPlayUrlStr:model.video.videourl corverUrlStr:model.video.firstpic];
    [self presentViewController:playerVC animated:YES completion:^{
        
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SAKuaishouListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KuaiShouCollectionListCellID forIndexPath:indexPath];
    SAVideoFeedModel *model = [self.dataList objectAtIndex:indexPath.row];
    cell.feedModel = model;
    return cell;
}

#pragma mark - Getter
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Navbar_Height, ScreenWidth, ScreenHeight - Navbar_Height) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = colorFromHex(@"#dedede");
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[SAKuaishouListCollectionViewCell class] forCellWithReuseIdentifier:KuaiShouCollectionListCellID];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        CGFloat itemSpace = 3; // item间距
        CGFloat itemW = (ScreenWidth - itemSpace) * 0.5;
        CGFloat itemH = itemW * 16 / 9.0f;
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = itemSpace;
        _flowLayout.minimumLineSpacing = itemSpace;
        _flowLayout.itemSize = CGSizeMake(itemW, itemH);
    }
    return _flowLayout;
}

@end
