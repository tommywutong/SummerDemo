//
//  foundVC.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/9.
//

#import "FoundVC.h"

@interface FoundVC ()

@end

@implementation FoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *homeIcon = [[UIImage imageNamed:@"faxian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeIconSelected = [[UIImage imageNamed:@"faxian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                     image:homeIcon
                                             selectedImage:homeIconSelected];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
