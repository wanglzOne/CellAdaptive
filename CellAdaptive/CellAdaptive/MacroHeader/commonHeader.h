//
//  commonHeader.h
//  CellAdaptive(朋友圈)
//
//  Created by bhqm on 2017/11/3.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#ifndef commonHeader_h
#define commonHeader_h

#import "MacroStatic.h"

// YYKit+Masonry+fd 高度自动计算
#import <YYLabel.h>
#import "UITableView+FDTemplateLayoutCell.h"

#import <UIButton+YYWebImage.h>
#import <UIImageView+YYWebImage.h>
#import <UIImage+YYAdd.h>
//

// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
// 这个头文件一定要放在上面两个宏的后面
#import "Masonry.h"

#endif /* commonHeader_h */

