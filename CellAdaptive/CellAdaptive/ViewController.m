//
//  ViewController.m
//  CellAdaptive
//
//  Created by bhqm on 2017/11/3.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "ViewController.h"
#import "AdaptiveCell.h"
#import "AdaptiveModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tab;
@property (nonatomic, strong) AdaptiveModel *model;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

#pragma mark ---- Getter
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(UITableView *)tab{
    if (!_tab) {
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tab.delegate = self;
        _tab.dataSource = self;
        [_tab registerClass:[AdaptiveCell class] forCellReuseIdentifier:@"adaptiveCell"];
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tab];
    
    [self loadData];
    [self loadUI];
}
-(void)loadData{
    NSArray *imageArray = @[@"https://img.chuizhicai.com/product/20170525/dfa33deb-a228-4a96-bc14-879079497995.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/product/20170421/e91186ef-2e9a-4118-8fb9-ddc887a6c6fc.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/ad/20170927/d16b8eb5-f0a2-419d-bde7-8afedc14fa73.jpg",@"https://img.chuizhicai.com/product/20170616/6f989f6e-15bc-4a5f-9c0d-548f265e24bc.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/product/20170704/93a18f6c-bef0-45e7-a22d-7fbe4605e07a.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400"];
    
    for (int i = 0; i <60; i++) {
        AdaptiveModel *model = [[AdaptiveModel alloc]init];
        model.iconImage = @"http://q.qlogo.cn/qqapp/1106276139/D1A908A09FE81C02D31FD0EA242397F5/100";
        model.iconName = @"Cell自适应";
        
        int number = arc4random_uniform(9);
        if (number == 0) {
            break;
        }
        NSMutableArray *imagesArray = [NSMutableArray array];
        NSString *string = [NSString string];
        
        for (int i = 0; i < number; i++) {
            int pictureCount = (int)imageArray.count;
            int picture = arc4random_uniform(pictureCount);
            NSString * string2  = @"测试cell自适应高度";
            string = [string stringByAppendingString:string2];
            [imagesArray addObject:imageArray[picture]];
        }
        
        model.TitleName = string;
        model.images = imagesArray;
        [self.dataSource addObject:model];
        DLog(@"%lu",(unsigned long)self.dataSource.count);
    }
    [self.tab reloadData];
}
-(void)loadUI{
    
}


#pragma mark ---- UITableViewDataSource AND Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AdaptiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adaptiveCell" forIndexPath:indexPath];
    
    cell.cell_model = self.dataSource[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = [tableView fd_heightForCellWithIdentifier:@"adaptiveCell" cacheByIndexPath:indexPath configuration:^(AdaptiveCell *cell) {
        cell.cell_model = self.dataSource[indexPath.row];
    }];
    return rowHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


