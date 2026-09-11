//
//  changeKeyViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import "ChangeKeyViewController.h"
#import "UserManager.h"
@interface ChangeKeyViewController ()

@end

@implementation ChangeKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed: (230.0 / 255) green: (222.0 / 255) blue: (220.0 / 255) alpha: 1];
    UIBarButtonItem* btn1 = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"holidayfanhui.png"] style: UIBarButtonItemStylePlain target: self action: @selector(pressReturn)];
    UIBarButtonItem* btn2 = [[UIBarButtonItem alloc] initWithTitle: @"修改密码" menu: nil];
    [self.navigationItem setLeftBarButtonItems: [NSArray arrayWithObjects: btn1, btn2, nil]];
    btn1.tintColor = [UIColor whiteColor];
    btn2.tintColor = [UIColor whiteColor];
    
    self.firstTextField = [[UITextField alloc] init];
    self.firstTextField.frame = CGRectMake(90, 120, 290, 50);
    self.firstTextField.backgroundColor = [UIColor whiteColor];
    self.firstTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.firstTextField.placeholder = @"6-20英文或数字组合";
    [self.view addSubview:self.firstTextField];
    
    self.secondTextField = [[UITextField alloc] init];
    self.secondTextField.frame = CGRectMake(90, 190, 290, 50);
    self.secondTextField.backgroundColor = [UIColor whiteColor];
    self.secondTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.secondTextField.placeholder = @"6-20英文或数字组合";
    [self.view addSubview: self.secondTextField];
    
    self.thirdTextField = [[UITextField alloc] init];
    self.thirdTextField.frame = CGRectMake(90, 260, 290, 50);
    self.thirdTextField.backgroundColor = [UIColor whiteColor];
    self.thirdTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.thirdTextField.placeholder = @"请再次确认输入密码";
    [self.view addSubview: self.thirdTextField];
    
    UILabel* firstLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 100, 100, 90)];
    firstLabel.text = @"旧密码";
    [self.view addSubview: firstLabel];
    UILabel* secondLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 170, 100, 90)];
    secondLabel.text = @"新密码";
    [self.view addSubview: secondLabel];
    UILabel* thirdLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 240, 100, 90)];
    thirdLabel.text = @"确认密码";
    [self.view addSubview: thirdLabel];
    UIButton* button = [[UIButton alloc] initWithFrame: CGRectMake(150, 370, 140, 50)];
    [button setTitle: @"提交" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.layer.cornerRadius = 9;
    button.layer.masksToBounds = YES;
    [self.view addSubview: button];
    
    [button addTarget: self action: @selector(pressButton) forControlEvents: UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;

    [self.view addGestureRecognizer:tapGesture];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)pressButton {
    NSString *oldPassword = self.firstTextField.text;
    NSString *newPassword = self.secondTextField.text;
    NSString *confirmPassword = self.thirdTextField.text;
    
    UserManager *userManager = [UserManager sharedManager];
    NSString *currentUser = userManager.currentUser;
    
    if (currentUser.length == 0) {
        self.alertController = [UIAlertController alertControllerWithTitle:@"错误"
                                                                   message:@"无法获取当前登录用户信息"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    } else if (newPassword.length < 6 || newPassword.length > 20) {
        self.alertController = [UIAlertController alertControllerWithTitle:@"通知"
                                                                   message:@"密码需为6-20位英文或数字组合"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    } else if (![newPassword isEqualToString:confirmPassword]) {
        self.alertController = [UIAlertController alertControllerWithTitle:@"通知"
                                                                   message:@"两次新密码输入不同"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    } else if ([oldPassword isEqualToString:newPassword]) {
        self.alertController = [UIAlertController alertControllerWithTitle:@"通知"
                                                                   message:@"新密码不能与旧密码相同"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    } else {
        if ([userManager updatePasswordForUser:currentUser oldPassword:oldPassword newPassword:newPassword]) {
            self.alertController = [UIAlertController alertControllerWithTitle:@"成功"
                                                                       message:@"密码修改成功"
                                                                preferredStyle:UIAlertControllerStyleAlert];
            self.firstTextField.text = @"";
            self.secondTextField.text = @"";
            self.thirdTextField.text = @"";
        } else {
            self.alertController = [UIAlertController alertControllerWithTitle:@"错误"
                                                                       message:@"旧密码不正确"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        }
    }
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [self.alertController addAction:sure];
    [self presentViewController:self.alertController animated:YES completion:nil];
}
- (void)pressReturn {
    [self.navigationController popViewControllerAnimated: YES];
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
