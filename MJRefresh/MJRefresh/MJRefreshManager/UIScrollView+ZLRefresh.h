//
//  UIScrollView+ZLRefresh.h
//  MJRefresh
//
//  Created by yuntong on 2017/6/15.
//  Copyright © 2017年 yuntong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UIScrollView (ZLRefresh)
#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action;

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing;

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing;

/** 是否正在刷新 */
- (BOOL)isHeaderRefreshing;

#pragma mark - 上拉刷新

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action;

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing;

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing;

/** 是否正在刷新 */
- (BOOL)isFooterRefreshing;

/**
 *  提示没有更多数据了
 */
- (void)endRefreshingWithNoMoreData;

/**
 *  重置footer 状态
 */
- (void)resetNoMoreData;
@end
