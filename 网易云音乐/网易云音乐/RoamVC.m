//
//  roamVC.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/9.
//

#import "RoamVC.h"

@interface RoamVC ()

@end

@implementation RoamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *homeIcon = [[UIImage imageNamed:@"a-bofangqi2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeIconSelected = [[UIImage imageNamed:@"a-bofangqi2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"漫游"
                                                     image:homeIcon
                                             selectedImage:homeIconSelected];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(151,
                                                                          332,
                                                                          100,
                                                                          100)];
    imageView.image = [UIImage imageNamed:@"jingqingqidai.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                              502,
                                                              402,
                                                              30)];
    label.text = @"敬请期待";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
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
