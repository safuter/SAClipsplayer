//
//  DefineHeader.h
//  SAClipsplayer
//
//  Created by zheng on 2019/10/17.
//  Copyright © 2019 kpIng. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h

//屏幕的高度
#define ScreenHeight [UIScreen mainScreen ].bounds.size.height
//屏幕的宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define IPhoneX   ([UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f)
#define Top_Space  (IPhoneX ? 24.0f : 0.0f)
#define Navbar_Height (64.0f + Top_Space)
#define Bottom_Space (IPhoneX ? 34.0f : 0.0f)
#define KPTabBar_Height  (49.0f + Bottom_Space)

#endif /* DefineHeader_h */
