//
//  NightModeManager.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/14.
//

#import "NightModeManager.h"

@implementation NightModeManager

+ (instancetype)sharedManager {
    static NightModeManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NightModeManager alloc] init];
        instance.isNightMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightModeEnabled"];
    });
    return instance;
}

- (void)toggleNightMode:(BOOL)enabled {
    _isNightMode = enabled;
    [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"NightModeEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NightModeChangedNotification" object:nil];
}

@end
