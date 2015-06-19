//
//  AppView.h
//  ApplicationManager
//
//  Created by zhengna on 15/6/18.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppInfo;

//the communication methods of classes are delegate, message and block; now we use delegate
@protocol AppViewDelegate <NSObject>

@optional
- (void)downloadClickWithBtn:(UIButton *)btn;


@end


@interface AppView : UIView

@property (nonatomic, strong) AppInfo *appInfo;

+ (instancetype)appView;

//no start symbol cause its type is 'id'
@property (nonatomic, weak) id<AppViewDelegate> delegate;

@end
