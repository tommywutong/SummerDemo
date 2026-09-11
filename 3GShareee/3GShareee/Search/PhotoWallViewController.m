//
//  PhotoWallViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/17.
//

#import "PhotoWallViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface PhotoWallViewController ()

@end

@implementation PhotoWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(230.0/255) green:(222.0/255) blue:(220.0/255) alpha:1];
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"holidayfanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressReturn)];
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"选择图片" menu:nil];
    self.navigationItem.leftBarButtonItems = @[btn1, btn2];
    btn1.tintColor = [UIColor whiteColor];
    btn2.tintColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonItemPress)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    for (int i = 0; i < 12; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"photo%d.jpg", i + 1]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"xvanzhong.png"] forState:UIControlStateSelected];
        btn.frame = CGRectMake(4 + WIDTH / 4 * (i % 4), 100 + WIDTH / 4 * (i / 4), WIDTH / 4 - 8, WIDTH / 4 - 8);
        btn.tag = 101 + i;
        [btn addTarget:self action:@selector(pressPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }

    self.imageNameArray = [NSMutableArray array];
    self.numbersOfPhoto = 0;
}

- (void)pressPhoto: (UIButton*)button {
    if (button.selected == NO) {
        int selectNumber = (int)(button.tag - 100);
        self.numbersOfPhoto++;
        [self.imageNameArray addObject: [NSString stringWithFormat: @"photo%d.jpg", selectNumber]];
        button.selected = YES;
    } else {
        int selectNumber = (int)(button.tag - 100);
        self.numbersOfPhoto--;
        [self.imageNameArray removeObject: [NSString stringWithFormat: @"photo%d.jpg", selectNumber]];
        button.selected = NO;
    }
}

- (void)rightButtonItemPress {
    if (self.numbersOfPhoto == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"请选择至少 1 张图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (self.numbersOfPhoto > 9) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"最多只能选择 9 张图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    } else {
        NSString *message = [NSString stringWithFormat:@"成功上传 %d 张图片!", self.numbersOfPhoto];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ([self.delegate respondsToSelector:@selector(changedPhotoName:andNumber:)]) {
                /*
                 respondToSelector是为了防止没有实现这个方法而崩溃，属于一种安全保护措施
                 我的代码应该不加也没问题，但是还是加上比较好
                 */
                [self.delegate changedPhotoName:self.imageNameArray.firstObject andNumber:self.numbersOfPhoto];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)pressReturn {
    [self.navigationController popViewControllerAnimated: YES];
}

@end
