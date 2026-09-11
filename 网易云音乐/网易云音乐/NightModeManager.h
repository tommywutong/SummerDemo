//
//  NightModeManager.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/14.
//

#import <Foundation/Foundation.h>

@interface NightModeManager : NSObject

@property (nonatomic, assign) BOOL isNightMode;

+ (instancetype)sharedManager;
- (void)toggleNightMode:(BOOL)enabled;

@end
