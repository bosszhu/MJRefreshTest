//
//  UIScrollView+ZLRefresh.m
//  MJRefresh
//
//  Created by yuntong on 2017/6/15.
//  Copyright © 2017年 yuntong. All rights reserved.
//

#import "UIScrollView+ZLRefresh.h"

@implementation UIScrollView (ZLRefresh)

-(void)addHeaderWithTarget:(id)target action:(SEL)action{
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing{
    [self.mj_header beginRefreshing];
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing{
    
    [self.mj_header endRefreshing];
}

- (BOOL)isHeaderRefreshing{
    
    return [self.mj_header isRefreshing];
    
}

#pragma mark - 上拉刷新

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action{
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing{
    
    [self.mj_footer beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing{
    [self.mj_footer endRefreshing];
}

/** 是否正在刷新 */
- (BOOL)isFooterRefreshing{
    
    return [self.mj_footer isRefreshing];
}

/**
 *  提示没有更多数据了
 */
- (void)endRefreshingWithNoMoreData{
    
    [self.mj_footer endRefreshingWithNoMoreData];
}

/**
 *  重置footer 状态
 */
- (void)resetNoMoreData{
    
    [self.mj_footer resetNoMoreData];
}
@end
