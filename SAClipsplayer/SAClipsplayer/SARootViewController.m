//
//  SARootViewController.m
//  SAClipsplayer
//
//  Created by zheng on 2019/10/17.
//  Copyright © 2019 kpIng. All rights reserved.
//

#import "SARootViewController.h"
#import "SAKuaiShouListViewController.h"

@interface SARootViewController ()

@end

@implementation SARootViewController

NSString *strFromSelector(SEL sel) {
    return NSStringFromSelector(sel);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"快手样式", @"抖音样式", @"头条样式"];
    
    NSArray *actions = @[
                          strFromSelector(@selector(kuaishouStyle)),
                          strFromSelector(@selector(douyinStyle)),
                          strFromSelector(@selector(toutiaoStyle)),
                        ];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateSelected];
        
        [btn addTarget:self action:NSSelectorFromString(actions[i])  forControlEvents:UIControlEventTouchUpInside];
        
        btn.frame = CGRectMake(40, 140 + 70 * i, 100, 35);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.borderWidth = 0.5;
        [self.view addSubview:btn];
    }
}

#pragma mark - Actions
- (void)kuaishouStyle {
    SAKuaiShouListViewController *kuaishouListVC = [[SAKuaiShouListViewController alloc] init];
    [self.navigationController pushViewController:kuaishouListVC animated:YES];
}

- (void)douyinStyle {
    
}

- (void)toutiaoStyle {
    
}


@end
