//
//  AppInfo.h
//  ApplicationManager
//
//  Created by zhengna on 15/6/18.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppInfo : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
//there is only a getter if 'readonly' is assigned
@property (nonatomic,strong,readonly) UIImage *image;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)appInfoWithDict:(NSDictionary *)dict;


@end
