//
//  AppInfo.m
//  ApplicationManager
//
//  Created by zhengna on 15/6/18.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo
{
    UIImage *_image;
}


- (instancetype)initWithDict:(NSDictionary *)dict{

    if(self = [super init]){
        // input data using kvc
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appInfoWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (UIImage *)image{
    if(!_image){
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

@end
