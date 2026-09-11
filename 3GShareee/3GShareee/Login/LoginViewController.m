//
//  LoginViewController.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//


//管理员账号密码：1  1
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "ArticleViewController.h"
#import "ActivityViewController.h"
#import "MyViewController.h"
#import "UserManager.h"
#define  WIDTH [UIScreen mainScreen].bounds.size.width
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed: 43.0 / 255 green: 123.0 / 255 blue: 191.0 / 255 alpha: 1.0];
    self.loginView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"logoLogin.png"]];
    self.loginView.frame = CGRectMake(WIDTH / 2 - 64, 100, 128, 128);
    self.loginView.layer.cornerRadius = 64;
    self.loginView.layer.masksToBounds = YES;
    [self.view addSubview: self.loginView];
    self.loginLabel = [[UILabel alloc] init];
    self.loginLabel.frame = CGRectMake(WIDTH / 2 - 64, 228, 128, 64);
    self.loginLabel.text = @"SHARE";
    self.loginLabel.textColor = [UIColor whiteColor];
    self.loginLabel.font = [UIFont systemFontOfSize: 35];
    self.loginLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.loginLabel];
    
    self.userName = [[UITextField alloc] init];
    self.userName.frame = CGRectMake(WIDTH / 2 - 150, 350, 300, 40);
    self.userName.placeholder = @"请输入用户名...";
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.leftView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"user_img.png"]];
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    self.userName.clearButtonMode = UITextFieldViewModeAlways;

    self.passWord = [[UITextField alloc] init];
    self.passWord.frame = CGRectMake(WIDTH / 2 - 150, 410, 300, 40);
    self.passWord.placeholder = @"请输入密码...";
    self.passWord.borderStyle = UITextBorderStyleRoundedRect;
    self.passWord.keyboardType = UIKeyboardTypeDefault;
    self.passWord.secureTextEntry = YES;
    self.passWord.leftView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"pass_img.png"]];
    self.passWord.leftViewMode = UITextFieldViewModeAlways;
    self.passWord.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview: self.userName];
    [self.view addSubview: self.passWord];
    
    // 键盘上移事件
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillAppear:) name: UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillDisAppear:) name: UIKeyboardWillHideNotification object: nil];
    
    self.leftBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    self.leftBtn.frame = CGRectMake(86, 490, 100, 40);
    [self.leftBtn setTitle: @"登录" forState: UIControlStateNormal];
    [self.leftBtn setTintColor: [UIColor whiteColor]];
    self.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize: 20];
    [self.leftBtn setBackgroundColor: [UIColor colorWithRed: 43.0 / 255 green: 123.0 / 255 blue: 191.0 / 255 alpha: 1.0]];
    [self.leftBtn.layer setMasksToBounds:YES];
    //圆角半径
    [self.leftBtn.layer setCornerRadius:6.0];
    //边框宽度
    [self.leftBtn.layer setBorderWidth:2.0];
    self.leftBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview: self.leftBtn];
    [self.leftBtn addTarget: self action: @selector(pressLeft:) forControlEvents: UIControlEventTouchUpInside];
    
    self.rightBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    self.rightBtn.frame = CGRectMake(216, 490, 100, 40);
    [self.rightBtn setTitle: @"注册" forState: UIControlStateNormal];
    [self.rightBtn setTintColor: [UIColor whiteColor]];
    self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize: 20];
    [self.rightBtn setBackgroundColor: [UIColor colorWithRed: 43.0 / 255 green: 123.0 / 255 blue: 191.0 / 255 alpha: 1.0]];
    [self.rightBtn.layer setMasksToBounds:YES];
    [self.rightBtn.layer setCornerRadius:6.0];
    [self.rightBtn.layer setBorderWidth:2.0];
    self.rightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview: self.rightBtn];
    [self.rightBtn addTarget: self action: @selector(pressRight:) forControlEvents: UIControlEventTouchUpInside];
    
    self.autoBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    self.autoBtn.frame = CGRectMake(WIDTH / 2 - 150, 550, 16, 16);
    [self.autoBtn setImage: [UIImage imageNamed: @"autoreserved.png"] forState: UIControlStateNormal];
    [self.autoBtn setImage: [UIImage imageNamed: @"autohighlighted.png"] forState: UIControlStateSelected];
    self.autoBtn.selected = NO;
    [self.autoBtn addTarget: self action: @selector(pressAuto) forControlEvents: UIControlEventTouchUpInside];
    
    self.autoBtn1 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    self.autoBtn1.frame = CGRectMake(67, 550, 64, 16);
    [self.autoBtn1 setTitle: @"自动登录" forState: UIControlStateNormal];
    [self.autoBtn1 setTintColor: [UIColor colorWithDisplayP3Red: 14.0 / 255 green: 46.0 / 255 blue: 121.0 / 255 alpha: 1.0]];
    [self.autoBtn1 addTarget: self action: @selector(pressAuto) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: self.autoBtn];
    [self.view addSubview: self.autoBtn1];
    
    //从单例类 UserManager 中获取已经保存的用户名和密码，赋值到当前控制器的数组中
    UserManager *userManager = [UserManager sharedManager];
    self.arrayUsername = userManager.usernames;
    self.arrayPassword = userManager.passwords;
    
}

- (void)pressAuto {
    if (self.autoBtn.selected == NO) {
        self.autoBtn.selected = YES;
    } else {
        self.autoBtn.selected = NO;
    }
}

- (void)pressRight: (UIButton *)button {
    if (!self.registerView) self.registerView = [[RegisterViewController alloc] init];
    [self presentViewController: self.registerView animated: YES completion: nil];
}


-(void) pressLeft:(UIButton *) button{
    NSString *username = self.userName.text;
    NSString *password = self.passWord.text;
    if (username.length == 0 || password.length == 0) {
        [self showAlertWithMessage:@"用户名和密码不能为空"];
        return;
    }
    if (username.length > 10 || password.length > 10) {
        [self showAlertWithMessage:@"用户名和密码不能超过10个字符"];
        return;
    }
    // 正则判断是否仅包含字母、数字、下划线
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Za-z0-9_]+$" options:0 error:nil];
    if ([regex numberOfMatchesInString:username options:0 range:NSMakeRange(0, username.length)] == 0 ||
        [regex numberOfMatchesInString:password options:0 range:NSMakeRange(0, password.length)] == 0) {
        [self showAlertWithMessage:@"用户名和密码只能包含字母、数字和下划线"];
        return;
    }

    BOOL correct = NO;
    for (int i = 0; i < self.arrayUsername.count; i++) {
            if ([self.arrayUsername[i] isEqualToString: self.userName.text] &&
                [self.arrayPassword[i] isEqualToString: self.passWord.text] &&
                (self.userName.text != nil) &&
                (self.passWord.text != nil)) {
                correct = YES;
                
                // 保存
                UserManager *userManager = [UserManager sharedManager];
                userManager.currentUser = self.userName.text;
                
                break;
            }
        }
    if (!correct) {
        UIAlertController* wrongWarning  = [UIAlertController alertControllerWithTitle:@"❗️" message:@"账号密码错误！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* sure = [UIAlertAction actionWithTitle:@"O K" style:UIAlertActionStyleDefault handler:nil];
        [wrongWarning addAction:sure];
        [self presentViewController:wrongWarning animated:YES completion:nil];
    } else {
        HomeViewController* firstView = [[HomeViewController alloc] init];
        firstView.view.backgroundColor = [UIColor colorWithRed: (230.0 / 255) green: (222.0 / 255) blue: (220.0 / 255) alpha: 1];
        firstView.tabBarItem = [[UITabBarItem alloc] initWithTitle: nil image: [[UIImage imageNamed: @"FirstVC.png"]  imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] selectedImage: [[UIImage imageNamed: @"FirstVC_tapped.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] ];
        SearchViewController* secondView = [[SearchViewController alloc] init];
        secondView.view.backgroundColor = [UIColor colorWithRed: (230.0 / 255) green: (222.0 / 255) blue: (220.0 / 255) alpha: 1];
        secondView.tabBarItem = [[UITabBarItem alloc] initWithTitle: nil image: [[UIImage imageNamed: @"SecondVC.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] selectedImage: [[UIImage imageNamed: @"SecondVC_tapped.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] ];
        ArticleViewController* thirdView = [[ArticleViewController alloc] init];
        thirdView.view.backgroundColor = [UIColor colorWithRed: (230.0 / 255) green: (222.0 / 255) blue: (220.0 / 255) alpha: 1];
        thirdView.tabBarItem = [[UITabBarItem alloc] initWithTitle: nil image: [[UIImage imageNamed: @"ThirdVC.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] selectedImage: [[UIImage imageNamed: @"ThirdVC_tapped.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] ];
        ActivityViewController* fourthView = [[ActivityViewController alloc] init];
        fourthView.view.backgroundColor = [UIColor colorWithRed: (230.0 / 255) green: (222.0 / 255) blue: (220.0 / 255) alpha: 1];
        fourthView.tabBarItem = [[UITabBarItem alloc] initWithTitle: nil image: [[UIImage imageNamed: @"FourthVC.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] selectedImage: [[UIImage imageNamed: @"FourthVC_tapped.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] ];
        MyViewController* fifthView = [[MyViewController alloc] init];
        fifthView.view.backgroundColor = [UIColor colorWithRed: (230.0 / 255) green: (222.0 / 255) blue: (220.0 / 255) alpha: 1];
        fifthView.tabBarItem = [[UITabBarItem alloc] initWithTitle: nil image: [[UIImage imageNamed: @"FifthVC.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] selectedImage: [[UIImage imageNamed: @"FifthVC_tapped.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] ];
        
        //用NavigationController包起来
        UINavigationController* navigationFirst = [[UINavigationController alloc] initWithRootViewController:firstView];
        UINavigationController* navigationSecond = [[UINavigationController alloc] initWithRootViewController:secondView];
        UINavigationController* navigationThird = [[UINavigationController alloc] initWithRootViewController:thirdView];
        UINavigationController* navigationFourth = [[UINavigationController alloc] initWithRootViewController:fourthView];
        UINavigationController* navigationFifth = [[UINavigationController alloc] initWithRootViewController:fifthView];
        UINavigationBarAppearance* appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundColor = [UIColor colorWithRed: (43.0 / 255) green: (123.0 / 255) blue: (191.0 / 255) alpha: 1];
        firstView.navigationController.navigationBar.standardAppearance = appearance;
        firstView.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        firstView.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        secondView.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        thirdView.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        fourthView.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        fifthView.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        
        NSArray* arrayViewController = [NSArray arrayWithObjects: navigationFirst, navigationSecond, navigationThird, navigationFourth, navigationFifth, nil];
        UITabBarController* tabBarViewController = [[UITabBarController alloc] init];
        tabBarViewController.viewControllers = arrayViewController;
        // 在tabBar上方添加自定义覆盖视图
        UIView* overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, tabBarViewController.tabBar.bounds.size.height)];
        overlayView.backgroundColor = [UIColor blackColor];
        overlayView.tag = 1001;
        [tabBarViewController.tabBar addSubview:overlayView];
        [tabBarViewController.tabBar bringSubviewToFront:overlayView];
        tabBarViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController: tabBarViewController animated: YES completion: nil];
    }
        
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"❗️" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/*
 iOS 动画
 1, UIView动画，常用于 位置、大小、透明度、颜色、transform 等属性变化
 
 [UIView animateWithDuration:0.5 animations:^{
     self.myView.frame = CGRectMake(200, 200, 100, 100);
 }];
 0.5代表0.5秒
 
 2,transform动画可以做 缩放、旋转、平移。
 
 // 缩放 1.5 倍
 self.myView.transform = CGAffineTransformMakeScale(1.5, 1.5);

 // 旋转 90 度
 self.myView.transform = CGAffineTransformMakeRotation(M_PI_2);

 // 平移 (x:100, y:0)
 self.myView.transform = CGAffineTransformMakeTranslation(100, 0);
 
 */

- (void)keyboardWillAppear:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    [UIView animateWithDuration:0.3 animations:^{//有过度的过渡
        self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.view.frame.size.height + 20);
    }];
}

- (void)keyboardWillDisAppear:(NSNotification *)notification{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

// 使用单例后不再需要传值

//- (void) pushUser: (NSMutableArray *)arrayUserName andPassword: (NSMutableArray *)arrayPassWord {
//
//    self.arrayUsername = [NSMutableArray arrayWithArray: arrayUserName];
//    self.arrayPassword = [NSMutableArray arrayWithArray: arrayPassWord];
//}

@end
