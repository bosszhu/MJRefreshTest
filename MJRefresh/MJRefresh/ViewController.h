//
//  ViewController.h
//  MJRefresh
//
//  Created by yuntong on 2017/6/15.
//  Copyright © 2017年 yuntong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//是否显示山下拉刷新
@property (nonatomic) BOOL showRefreshHeader;
@property (nonatomic) BOOL showRefreshFooter;
@property (nonatomic, assign) NSInteger pageNo;

@end

