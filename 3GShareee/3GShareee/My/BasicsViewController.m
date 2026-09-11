//
//  basicsViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import "BasicsViewController.h"

@interface BasicsViewController ()

@property (nonatomic, assign) BOOL isMaleSelected;
@property (nonatomic, strong) UIImage *selectedIcon;
@property (nonatomic, strong) UIImage *unselectedIcon;

@end

@implementation BasicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"我的推荐";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    self.navigationItem.titleView = titleLabel;
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"holidayfanhui.png"] style: UIBarButtonItemStylePlain target: self action: @selector(pressReturn)];
    self.navigationItem.leftBarButtonItem = btn;
    btn.tintColor = [UIColor whiteColor];
    _selectedIcon = [UIImage imageNamed:@"selected_button"];
    _unselectedIcon = [UIImage imageNamed:@"unselected_button"];
    
    self.title = @"基本资料";
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [self setupUI];
    [self loadUserData];
    
}

- (void)pressReturn {
    [self.navigationController popViewControllerAnimated: YES];
}


- (void)setupUI {
    UILabel *avatarTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 20)];
    avatarTitle.text = @"头像";
    avatarTitle.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:avatarTitle];
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 105, 70, 70)];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImageView.clipsToBounds = YES;
    [self.view addSubview:_avatarImageView];
    UILabel *nicknameTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 100, 20)];
    nicknameTitle.text = @"昵称";
    nicknameTitle.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:nicknameTitle];
    _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 220, 180, 180, 20)];
    _nicknameLabel.textAlignment = NSTextAlignmentRight;
    _nicknameLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_nicknameLabel];
    UILabel *signatureTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 100, 20)];
    signatureTitle.text = @"签名";
    signatureTitle.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:signatureTitle];
    _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 220, 230, 180, 40)];
    _signatureLabel.textAlignment = NSTextAlignmentRight;
    _signatureLabel.font = [UIFont systemFontOfSize:16];
    _signatureLabel.numberOfLines = 0;
    [self.view addSubview:_signatureLabel];
    UILabel *genderTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 290, 100, 20)];
    genderTitle.text = @"性别";
    genderTitle.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:genderTitle];
    _maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _maleButton.frame = CGRectMake(self.view.bounds.size.width - 160, 285, 60, 30);
    [_maleButton setTitle:@"男" forState:UIControlStateNormal];
    [_maleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_maleButton setImage:_selectedIcon forState:UIControlStateNormal];
    _maleButton.tintColor = [UIColor grayColor];
    _maleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _maleButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [_maleButton addTarget:self action:@selector(selectMale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_maleButton];
    
    _femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _femaleButton.frame = CGRectMake(self.view.bounds.size.width - 80, 285, 60, 30);
    [_femaleButton setTitle:@"女" forState:UIControlStateNormal];
    [_femaleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_femaleButton setImage:_unselectedIcon forState:UIControlStateNormal];
    _femaleButton.tintColor = [UIColor grayColor];
    _femaleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _femaleButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [_femaleButton addTarget:self action:@selector(selectFemale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_femaleButton];

    UILabel *emailTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 340, 100, 20)];
    emailTitle.text = @"邮箱";
    emailTitle.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:emailTitle];
    
    _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 220, 340, 180, 20)];
    _emailLabel.textAlignment = NSTextAlignmentRight;
    _emailLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_emailLabel];
}

- (void)loadUserData {
    _avatarImageView.image = [UIImage imageNamed:@"sixin_img1"];
    _nicknameLabel.text = @"share小白";
    _signatureLabel.text = @"开心了就笑，不开心了就待会儿再笑";
    _emailLabel.text = @"186****3@qq.com";
}


- (void)selectMale {
    _isMaleSelected = YES;
    [self updateGenderSelection];
}
- (void)selectFemale {
    _isMaleSelected = NO;
    [self updateGenderSelection];
}

- (void)updateGenderSelection {
    if (_isMaleSelected) {
        [_maleButton setImage:_selectedIcon forState:UIControlStateNormal];
        [_maleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _maleButton.tintColor = [UIColor blueColor];
        
        [_femaleButton setImage:_unselectedIcon forState:UIControlStateNormal];
        [_femaleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _femaleButton.tintColor = [UIColor grayColor];
    } else {
        [_femaleButton setImage:_selectedIcon forState:UIControlStateNormal];
        [_femaleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _femaleButton.tintColor = [UIColor blueColor];
        
        [_maleButton setImage:_unselectedIcon forState:UIControlStateNormal];
        [_maleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _maleButton.tintColor = [UIColor grayColor];
    }
}
@end
