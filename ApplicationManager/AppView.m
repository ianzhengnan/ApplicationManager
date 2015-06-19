//
//  AppView.m
//  ApplicationManager
//
//  Created by zhengna on 15/6/18.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import "AppView.h"
#import "AppInfo.h"

@interface AppView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@end

@implementation AppView
- (IBAction)downloadBtnOnClick:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(downloadClickWithBtn:)]){
        [self.delegate downloadClickWithBtn:sender];
    }
}

+ (instancetype)appView{
    //because there is only one view in 'AppView', so we can use lastObject or firstObject
    return [[[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
}

- (void)setAppInfo:(AppInfo *)appInfo{
    _appInfo = appInfo;
    
    self.iconView.image = appInfo.image;
    self.nameLable.text = appInfo.name;
    
}

@end
