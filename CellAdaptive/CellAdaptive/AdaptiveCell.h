//
//  AdaptiveCell.h
//  CellAdaptive(朋友圈)
//
//  Created by bhqm on 2017/11/3.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdaptiveModel.h"

@interface AdaptiveCell : UITableViewCell
@property (nonatomic, strong) AdaptiveModel *cell_model;

@end

@interface ImageView : UIView
@property(nonatomic ,strong)NSMutableArray *imagesArray;

@end
