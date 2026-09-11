//
//  RightViewController.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/16.
//

#import "RightViewController.h"

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"111";
    UIImage *customBackImage = [UIImage imageNamed:@"faxian-2.png"];
    UIBarButtonItem *customBackItem = [[UIBarButtonItem alloc] initWithImage:customBackImage
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(customBack)];
    self.navigationItem.leftBarButtonItem = customBackItem;
}

- (void)customBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
