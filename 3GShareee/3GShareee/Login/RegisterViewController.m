//
//  RegisterVC.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import "RegisterViewController.h"
#import "UserManager.h"
#define  WIDTH [UIScreen mainScreen].bounds.size.width

@interface RegisterViewController ()

@end
 
@implementation RegisterViewController

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
    
    self.emailTextField = [[UITextField alloc] init];
    self.emailTextField.frame = CGRectMake(WIDTH / 2 - 150, 340, 300, 40);
    self.emailTextField.placeholder = @"请输入邮箱...";
    self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailTextField.leftView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"email_img.png"]];
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.emailTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.emailTextField];
    
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.frame = CGRectMake(WIDTH / 2 - 150, 400, 300, 40);
    self.usernameTextField.placeholder = @"请输入用户名...";
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameTextField.leftView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"user_img.png"]];
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.frame = CGRectMake(WIDTH / 2 - 150, 460, 300, 40);
    self.passwordTextField.placeholder = @"请输入密码...";
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.keyboardType = UIKeyboardTypeDefault;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.leftView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"pass_img.png"]];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview: self.usernameTextField];
    [self.view addSubview: self.passwordTextField];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillAppear:) name: UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillDisAppear:) name: UIKeyboardWillHideNotification object: nil];
    
    
    self.confirmBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.confirmBtn setTintColor: [UIColor whiteColor]];
    self.confirmBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.confirmBtn.frame = CGRectMake(110, 560, 200, 50);
    [self.confirmBtn setTitle: @"确认注册" forState: UIControlStateNormal];
    [self.confirmBtn setTintColor: [UIColor whiteColor]];
    self.confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize: 20];
    [self.confirmBtn.layer setMasksToBounds:YES];
    [self.confirmBtn.layer setCornerRadius:6.0];
    [self.confirmBtn.layer setBorderWidth:3.0];
    [self.view addSubview: self.confirmBtn];
    [self.confirmBtn addTarget: self action: @selector(pressConfirm) forControlEvents: UIControlEventTouchUpInside];
    
    
}

- (void)keyboardWillDisAppear:(NSNotification *)notification{
    [UIView animateWithDuration: 0.3 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, 0);}];
}

- (void)keyboardWillAppear:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    [UIView animateWithDuration: 0.3 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.view.frame.size.height + 19);}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.emailTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];//点击空白收起键盘
}

-(void) pressConfirm {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    UserManager *userManager = [UserManager sharedManager];
    

    if (username.length == 0 || password.length == 0) {
        UIAlertController* warning = [UIAlertController alertControllerWithTitle:@"提示"
                                                                         message:@"账号或密码不能为空"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* warn = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
        
        [warning addAction:warn];
        [self presentViewController:warning animated:YES completion:nil];
        return;
    }
    if (password.length < 6) {
        UIAlertController* warning = [UIAlertController alertControllerWithTitle:@"提示"
                                                                         message:@"密码长度必须大于6位"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* warn = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
        
        [warning addAction:warn];
        [self presentViewController:warning animated:YES completion:nil];
        return;
    }
    if (username.length > 20 || password.length > 20) {
        UIAlertController* warning = [UIAlertController alertControllerWithTitle:@"提示"
                                                                         message:@"用户名和密码不能超过20个字符"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* warn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [warning addAction:warn];
        [self presentViewController:warning animated:YES completion:nil];
        return;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Za-z0-9_]+$" options:0 error:nil];
    if ([regex numberOfMatchesInString:username options:0 range:NSMakeRange(0, username.length)] == 0 ||
        [regex numberOfMatchesInString:password options:0 range:NSMakeRange(0, password.length)] == 0) {
        UIAlertController* warning = [UIAlertController alertControllerWithTitle:@"提示"
                                                                         message:@"用户名和密码只能包含字母、数字和下划线"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* warn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [warning addAction:warn];
        [self presentViewController:warning animated:YES completion:nil];
        return;
    }
    if ([userManager.usernames containsObject:username]) {
        UIAlertController* warning = [UIAlertController alertControllerWithTitle:@"提示"
                                                                         message:@"该用户名已被注册"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* warn = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
        [warning addAction:warn];
        [self presentViewController:warning animated:YES completion:nil];
        return;
    }
    [userManager.usernames addObject:username];
    [userManager.passwords addObject:password];
    [userManager saveUserData];
    UIAlertController* successAlert = [UIAlertController alertControllerWithTitle:@"注册成功"
                                                                         message:@"您已成功注册"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [successAlert addAction:okAction];
    [self presentViewController:successAlert animated:YES completion:nil];
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    self.emailTextField.text = @"";
}

@end
