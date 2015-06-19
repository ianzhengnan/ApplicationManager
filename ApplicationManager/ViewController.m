//
//  ViewController.m
//  ApplicationManager
//
//  Created by zhengna on 15/6/18.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppView.h"

#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kAppViewH [AppView appView].bounds.size.height
#define kAppViewW [AppView appView].bounds.size.width
#define kTotalCol 3

@interface ViewController () <AppViewDelegate>

@property (nonatomic, strong) NSArray *appViews;


@end

@implementation ViewController

//Using lazy-load to create array
//override the getter of appViews
- (NSArray *)appViews{
    if (!_appViews) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *dict in array) {
            //create model instance
            AppInfo *appInfo = [AppInfo appInfoWithDict:dict];
            //create own view
            AppView *appView = [AppView appView];
            appView.appInfo = appInfo;
            appView.delegate = self;
            
            //add own view to mutable array
            [arrayM addObject:appView];
        }
        _appViews = [arrayM copy];
    }
    return _appViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat margin = (kScreenW - kTotalCol * kAppViewW)/(kTotalCol + 1);
    
    for (int i=0; i < self.appViews.count; i++) {
        AppView *appView = self.appViews[i];
        
        //calcute the row and column number
        int col = i % kTotalCol;
        int row = i / kTotalCol;
        //calcute the center point of every views
        CGFloat centerX = (margin + kAppViewW * 0.5) + (margin + kAppViewW) * col;
        CGFloat centerY = (margin + kAppViewH * 0.5) + (margin + kAppViewH) * row;
        
        appView.center = CGPointMake(centerX, centerY);
        [self.view addSubview:appView];
        
    }
    
}

#pragma mark - AppViewDelegate

- (void)downloadClickWithBtn:(UIButton *)btn{
    
    //get the name of app
    //Force convert
    AppView *appView = (AppView *)btn.superview;
    NSString *appName = appView.appInfo.name;
    
    //generate the busy indicator
    UIActivityIndicatorView *busy = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    busy.frame = self.view.bounds;
    
    //busy.hidesWhenStopped = YES; //by default, it is YES
    //busy.backgroundColor = [UIColor greenColor];
    
    [busy startAnimating];
    [self.view addSubview:busy];
    
    // generate a lable for downloading above on the busy indicator
    UILabel *downloadLable = [[UILabel alloc] init];
    downloadLable.frame = CGRectMake(0, kScreenH * 0.5 + 10, kScreenW, 20);
    downloadLable.textColor = [UIColor whiteColor];
    downloadLable.textAlignment = NSTextAlignmentCenter;
    downloadLable.text = [NSString stringWithFormat:@"%@正在下载。。。", appName];
    downloadLable.font = [UIFont systemFontOfSize:15.0];
    downloadLable.backgroundColor = [UIColor blackColor];
    downloadLable.alpha = 0.5;
    
    [busy addSubview:downloadLable];
    
    //using GCD to
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [busy stopAnimating];
        
        //the alert when download is done
        UILabel *noteLable = [[UILabel alloc] init];
        noteLable.frame = CGRectMake(0, kScreenH * 0.5 + 20, kScreenW, 30);
        noteLable.textColor = [UIColor whiteColor];
        noteLable.textAlignment = NSTextAlignmentCenter;
        noteLable.text = [NSString stringWithFormat:@"%@下载完成", appName];
        noteLable.font = [UIFont systemFontOfSize:15.0];
        noteLable.backgroundColor = [UIColor blackColor];
        noteLable.alpha = 1;
        
        [self.view addSubview:noteLable];
        
        //animation by block
        [UIView animateWithDuration:2.0 animations:^{
            //do the animation
            noteLable.alpha = 0;
        } completion:^(BOOL finished) {
            //what we should do after the animation
            btn.enabled = NO;
            
            [btn setTitle:@"已下载" forState:UIControlStateDisabled];
            
            [noteLable removeFromSuperview];
        }];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
