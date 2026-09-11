//
//  SceneDelegate.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/9.
//

#import "SceneDelegate.h"
#import "FoundVC.h"
#import "NotesVC.h"
#import "MyVC.h"
#import "RoamVC.h"
#import "RecommendVC.h"
#import "NightModeManager.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    RecommendVC *vc1 = [[RecommendVC alloc] init];
    vc1.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                   image:[UIImage imageNamed:@"wangyiyun-2"]
                                           selectedImage:[UIImage imageNamed:@"wangyiyun-2"]];
    
    // 发现
//    foundVC *vc2 = [[foundVC alloc] init];
//    vc2.view.backgroundColor = [UIColor whiteColor];
//    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
//    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
//                                                   image:[UIImage imageNamed:@"faxian-2"]
//                                           selectedImage:[UIImage imageNamed:@"faxian-2"]];
//
    // 漫游
    RoamVC *vc3 = [[RoamVC alloc] init];
    vc3.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"漫游"
                                                   image:[UIImage imageNamed:@"tv-music"]
                                           selectedImage:[UIImage imageNamed:@"tv-music"]];
    
    // 笔记
    NotesVC *vc4 = [[NotesVC alloc] init];
    vc4.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"笔记"
                                                   image:[UIImage imageNamed:@"24gl-bubbles4"]
                                           selectedImage:[UIImage imageNamed:@"24gl-bubbles4"]];
    
    // 我的
    MyVC *vc5 = [[MyVC alloc] init];
    vc5.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    nav5.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                   image:[UIImage imageNamed:@"vip"]
                                           selectedImage:[UIImage imageNamed:@"vip"]];

    // 创建分栏控制器
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    BOOL isNightMode = [NightModeManager sharedManager].isNightMode;
    tabBarController.viewControllers = @[nav1, nav3, nav4, nav5];
    tabBarController.tabBar.translucent = YES;
    tabBarController.tabBar.backgroundColor = isNightMode ? [UIColor blackColor] : [UIColor whiteColor];
    tabBarController.tabBar.barTintColor = [UIColor clearColor];
    tabBarController.tabBar.tintColor = [UIColor systemRedColor];
    // 设置根视图控制器
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(updateTabBarAppearance)
                                                    name:@"NightModeChangedNotification"
                                                  object:nil];
    
}

- (void)updateTabBarAppearance {
    BOOL isNightMode = [NightModeManager sharedManager].isNightMode;

    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;

    if (isNightMode) {
        tabBar.barTintColor = [UIColor blackColor];
        tabBar.backgroundColor = [UIColor blackColor];
        tabBar.tintColor = [UIColor systemRedColor];
        tabBar.unselectedItemTintColor = [UIColor lightGrayColor];
    } else {
        tabBar.barTintColor = [UIColor whiteColor];
        tabBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
        tabBar.tintColor = [UIColor systemRedColor];
        tabBar.unselectedItemTintColor = [UIColor grayColor];
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
