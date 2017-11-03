//
//  MacroStatic.h
//  CellAdaptive(朋友圈)
//
//  Created by bhqm on 2017/11/3.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <Foundation/Foundation.h>


//宏定义

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

//自定义NSLog---作用:开发方便调试,发布应用后  不使用NSLog 也不用删除
#ifdef DEBUG
#define DLog(fmt,...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//弱引用
#define WEAK(weakSelf)  __typeof(&*self) weakSelf = self;


@interface MacroStatic : NSObject

@end
