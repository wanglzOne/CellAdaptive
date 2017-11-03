//
//  AdaptiveCell.m
//  CellAdaptive(朋友圈)
//
//  Created by bhqm on 2017/11/3.
//  Copyright © 2017年 wanglz. All rights reserved.
/*
 1.自定义cell时，
 若使用nib，使用 registerNib: 注册，dequeue时会调用 cell 的 -(void)awakeFromNib
 不使用nib，使用 registerClass: 注册, dequeue时会调用 cell 的 - (id)initWithStyle:withReuseableCellIdentifier:
 2.需不需要注册？
 使用dequeueReuseableCellWithIdentifier:可不注册，但是必须对获取回来的cell进行判断是否为空，若空则手动创建新的cell；
 使用dequeueReuseableCellWithIdentifier:forIndexPath:必须注册，但返回的cell可省略空值判断的步骤。
 */

#import "AdaptiveCell.h"


@interface AdaptiveCell ()
@property(nonatomic ,strong)UIImageView *iconImageView;
@property(nonatomic ,strong)YYLabel *iconName;
@property(nonatomic ,strong)YYLabel *TitleName;
@property(nonatomic ,strong)ImageView *images;

@end

static CGFloat margin = 10.f;

@implementation AdaptiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//初始化cell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //cell 纯代码布局
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    //将控件添加到cell中  注意:是cell的contentview
    [self.contentView addSubview:self.images];
    [self.contentView addSubview:self.iconName];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.TitleName];
    
    //添加约束
    [self.iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(margin);
        make.width.height.equalTo(30);
    }];
    [self.iconName makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.right.equalTo(margin);
        make.left.equalTo(self.iconImageView.mas_right).offset(margin);
    }];
    [self.TitleName makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(margin);
        make.left.equalTo(self.iconName);
        make.height.equalTo(0).priorityMedium();
    }];
    [self.images makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TitleName.mas_bottom).offset(margin);
        make.left.equalTo(self.iconImageView.mas_right).offset(margin);
        make.right.equalTo(self.contentView).offset(-margin);
        make.bottom.equalTo(self.contentView).offset(-margin).priorityMedium();
        make.height.equalTo(0).priorityMedium();
    }];
    

}
#pragma mark ---- setup Data
-(void)setCell_model:(AdaptiveModel *)cell_model{
    _cell_model = cell_model;
    WEAK(ws);
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:cell_model.iconImage] placeholder:[UIImage imageNamed:@"123"] options:YYWebImageOptionSetImageWithFadeAnimation manager:[YYWebImageManager sharedManager] progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        
        return [image imageByRoundCornerRadius:100];
        
    }  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        UIImage *newimage = [image imageByRoundCornerRadius:100];
        
        ws.iconImageView.image = newimage;
    }];
    
    if (cell_model.images.count == 0) {
        [self.images updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0).priorityMedium();
            make.bottom.equalTo(self.contentView).priorityMedium();
        }];
    }
    
    self.images.imagesArray = [NSMutableArray arrayWithArray:cell_model.images];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 60, CGFLOAT_MAX)];
    
    NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:cell_model.iconName];
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attributeString];
    
    self.iconName.textLayout = layout;
    
    YYTextContainer *container2 = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 60, CGFLOAT_MAX)];
    
    NSAttributedString *attributeString2 = [[NSAttributedString alloc]initWithString:cell_model.TitleName];
    
    YYTextLayout *layout2 = [YYTextLayout layoutWithContainer:container2 text:attributeString2];
    
    self.TitleName.textLayout = layout2;
    
    [self.TitleName mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(layout2.textBoundingSize.height);
    }];
    
    self.iconName.text = cell_model.iconName;
    
    self.TitleName.text = cell_model.TitleName;
}


#pragma mark ---- Getter
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}
-(ImageView *)images
{
    if (!_images) {
        _images = [[ImageView alloc] init];
    }
    return _images;
}

-(YYLabel *)iconName{
    if (!_iconName) {
        _iconName = [YYLabel new];
        _iconName.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _iconName.displaysAsynchronously = YES;
        _iconName.ignoreCommonProperties = YES;
        _iconName.fadeOnHighlight = NO;
        _iconName.fadeOnAsynchronouslyDisplay = NO;
        _iconName.font = [UIFont systemFontOfSize:16];
        _iconName.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            
        };
    }
    return _iconName;
}

-(YYLabel *)TitleName{
    if (!_TitleName) {
        _TitleName = [YYLabel new];
        _TitleName.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _TitleName.displaysAsynchronously = YES;
        _TitleName.ignoreCommonProperties = YES;
        _TitleName.fadeOnHighlight = NO;
        _TitleName.fadeOnAsynchronouslyDisplay = NO;
        _TitleName.font = [UIFont systemFontOfSize:14];
        _TitleName.preferredMaxLayoutWidth = kScreenWidth -50;
        _TitleName.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            
        };

    }
    return _TitleName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

@end





@interface ImageView ()
#define ButtonW   (kScreenWidth - 60-1/2*margin)/3.f

@property(nonatomic ,strong)NSMutableArray *ButtonArray;

@end

@implementation ImageView

#pragma mark - Getter
- (NSMutableArray *)ButtonArray
{
    if(!_ButtonArray){
        _ButtonArray = [[NSMutableArray alloc] init];
    }
    return _ButtonArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        //初始化 ImageView
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    for (int i = 0; i < 9; i++) {
        NSInteger row = i / 3;
        NSInteger line = i % 3;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((margin/2 + ButtonW)*line, (margin/2 + ButtonW)*row, ButtonW, ButtonW);
        btn.hidden = YES;
        [self.ButtonArray addObject:btn];
        [self addSubview:btn];
    }
}

-(void)setImagesArray:(NSMutableArray *)imagesArray
{
    _imagesArray = imagesArray;
    NSInteger count = (imagesArray.count -1)/3  +1;
    DLog(@"%ld,%f" ,imagesArray.count,(margin/2 + ButtonW)*count);
    [self.ButtonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<self.imagesArray.count) {
            [button setImageWithURL:[NSURL URLWithString:self.imagesArray[idx]] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"123"] options:YYWebImageOptionShowNetworkActivity completion:nil];
            button.hidden = NO;
        }else{
            button.hidden = YES;
        }
    }];
    
    if (imagesArray.count == 0) {
        [self updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0).priorityMedium();
        }];
    }else{
        [self updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo((margin/2 + ButtonW)*count).priorityMedium();
        }];
    }
    
}

@end

