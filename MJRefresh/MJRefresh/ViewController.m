//
//  ViewController.m
//  MJRefresh
//
//  Created by yuntong on 2017/6/15.
//  Copyright © 2017年 yuntong. All rights reserved.
//

#import "ViewController.h"
//#import "MJRefresh.h"
#import "ZLDIYHeader.h"
#import "UIScrollView+ZLRefresh.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *zltableView;
@property (nonatomic, strong) NSMutableArray *dataSoureArr;
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    //在需要显示的地方显示
    self.showRefreshHeader = YES;
    self.showRefreshFooter = YES;
    _pageNo = 0;
    [self requestData];
}
- (void)requestData {
    NSLog(@"首次进来刷新数据");
    //延时设置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        [self.zltableView.mj_header endRefreshing];
        [self.zltableView.mj_footer endRefreshing];
    });

}
- (void)requestMoreData {
    NSLog(@"首次进来刷新数据");
    //延时设置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        [self.zltableView.mj_header endRefreshing];
        [self.zltableView.mj_footer endRefreshing];
//        self.showRefreshHeader = NO;
    });
    
}
- (void)loadPreMoreData {
    _pageNo = 0;
    NSLog(@"上拉刷新加载更多数据,改变page为%ld",_pageNo);
    for (int i = 0; i < 2; ++i) {
        [self.dataSoureArr addObject:@"hah"];
    }
    [self.zltableView reloadData];
    [self requestMoreData];
}
- (void)loadMoreData {
    _pageNo += 1;
    NSLog(@"下拉刷新加载更多数据,改变page为%ld",_pageNo);
    for (int i = 0; i < 3; ++i) {
        [self.dataSoureArr addObject:@"hah"];
    }
    [self.zltableView reloadData];
    [self requestMoreData];
}
//重写自己设置两个属性的showRefreshFooter,showRefreshFooter的set方法
#pragma mark - 上下拉刷新方法----
- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        if (_showRefreshHeader) {
            
//            [self.zltableView addHeaderWithTarget:self action:@selector(loadPreMoreData)];

            
            __weak ViewController *weakSelf = self;
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weakSelf.zltableView.mj_header beginRefreshing];
                [weakSelf loadPreMoreData];
            }];
            //隐藏时间
            header.lastUpdatedTimeLabel.hidden = YES;
            //设置文字和字体
            [header setTitle:@"拼命加载中啊" forState:MJRefreshStateIdle];//结束瞬间的文字
            [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];//拉起瞬间的文字
            [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];//正在刷新的文字
            // 设置字体
            header.stateLabel.font = [UIFont systemFontOfSize:15];header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
            // 设置颜色
            header.stateLabel.textColor = [UIColor redColor];header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
////            MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//                [weakSelf.zltableView.mj_header beginRefreshing];
//                [weakSelf loadPreMoreData];
//            }];
//            // 设置普通状态的动画图片
//            NSMutableArray *idleImages = [NSMutableArray array];
//            for (NSUInteger i = 1; i<=60; i++) {
//                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//                [idleImages addObject:image];
//            }
//            [header setImages:idleImages forState:MJRefreshStateIdle];
//            // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//            NSMutableArray *refreshingImages = [NSMutableArray array];
//            for (NSUInteger i = 1; i<=3; i++) {
//                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//                [refreshingImages addObject:image];
//            }
//            [header setImages:refreshingImages forState:MJRefreshStatePulling];
//            // 设置正在刷新状态的动画图片
//            [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
//            ZLDIYHeader *header = [ZLDIYHeader headerWithRefreshingBlock:^{
//                [weakSelf.zltableView.mj_header beginRefreshing];
//                [weakSelf loadPreMoreData];
//            }];
            
            self.zltableView.mj_header = header;
            
        } else{
          self.zltableView.mj_header.hidden = YES;
        }
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        if (_showRefreshFooter) {
            __weak ViewController *weakSelf = self;
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                //开始刷新
                [weakSelf.zltableView.mj_footer beginRefreshing];
                [weakSelf loadMoreData];
            }];
            self.zltableView.mj_footer = footer;
        } else {
            //移除下拉刷新
            self.zltableView.mj_footer.hidden = NO;
        }
    }
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"hehe";
    // 设置 Cell...
    
    return cell;
}

- (NSMutableArray *)dataSoureArr {
    if (_dataSoureArr == nil) {
        _dataSoureArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; ++i) {
            [_dataSoureArr addObject:@"hehe"];
        }
    }
    return _dataSoureArr;
}
@end
