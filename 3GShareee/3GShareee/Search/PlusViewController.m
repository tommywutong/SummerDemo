//
//  PlusViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/17.
//

#import "PlusViewController.h"
#import "PhotoWallViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface PlusViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL isFolded;
@property (nonatomic, strong) NSMutableArray *foldCellArray;
@property (nonatomic, strong) UILabel *numbersOfPhotoLabel;
@end

@implementation PlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupChoosePhotoButton];
    [self setupLocationViews];
    [self setupFoldTableView];
    
    self.numbersOfPhoto = 0;
    self.nameTextField = [[UITextField alloc] init];
    self.nameTextField.frame = CGRectMake(5, 400, WIDTH - 10, 45);
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.font = [UIFont systemFontOfSize:20];
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.placeholder = @"作品名称";
    self.nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.nameTextField];
    self.describeTextField = [[UITextField alloc] init];
    self.describeTextField.frame = CGRectMake(5, 455, WIDTH - 10, 190);
    self.describeTextField.backgroundColor = [UIColor whiteColor];
    self.describeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.describeTextField.font = [UIFont systemFontOfSize:20];
    self.describeTextField.placeholder = @"请添加作品说明文章内容......";
    self.describeTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.describeTextField.textAlignment = NSTextAlignmentLeft;
    self.describeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.describeTextField.adjustsFontSizeToFitWidth = YES;
    self.describeTextField.minimumFontSize = 20;
    [self.view addSubview:self.describeTextField];
    
    NSArray *titles = @[@"平面设计", @"网页设计", @"UI/icon", @"插画/手绘",
                       @"虚拟设计", @"影视", @"摄影", @"其他"];
    CGFloat width = (self.view.frame.size.width - 50) / 4;
    CGFloat height = 35;
    CGFloat top = 300;
    for (int i = 0; i < 8; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        int column = i % 4;
        int row = i / 4;
        CGFloat x = 10 + column * (width + 10);
        CGFloat y = top + row * (height + 15);
        button.frame = CGRectMake(x, y, width, height);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    UIButton* submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.frame = CGRectMake(5, 650, WIDTH - 10, 40);
    submitButton.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.9 alpha:1];
    [submitButton setTitle:@"发布" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(pressPublishButton) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.cornerRadius = 8;
    submitButton.layer.masksToBounds = YES;
    [self.view addSubview:submitButton];
}

- (void)buttonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    sender.backgroundColor = sender.selected ? [UIColor systemBlueColor] : [UIColor whiteColor];
}

- (void)setupNavigationBar {
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"holidayfanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressReturn)];
    self.navigationItem.leftBarButtonItem = btn;
    btn.tintColor = [UIColor whiteColor];
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"上传";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

- (void)pressReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupChoosePhotoButton {
    self.choosePhoto = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.choosePhoto setTitle:@"选择图片" forState:UIControlStateNormal];
    [self.choosePhoto setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.choosePhoto.titleLabel.font = [UIFont systemFontOfSize:25];
    self.choosePhoto.frame = CGRectMake(27, 105, 170, 170);
    self.choosePhoto.backgroundColor = [UIColor lightGrayColor];
    
    self.numbersOfPhotoLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 30, 30)];
    self.numbersOfPhotoLabel.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.9 alpha:0.7];
    self.numbersOfPhotoLabel.textColor = [UIColor whiteColor];
    self.numbersOfPhotoLabel.textAlignment = NSTextAlignmentCenter;
    self.numbersOfPhotoLabel.font = [UIFont boldSystemFontOfSize:18];
    self.numbersOfPhotoLabel.layer.cornerRadius = 15;
    self.numbersOfPhotoLabel.layer.masksToBounds = YES;
    self.numbersOfPhotoLabel.text = @"0";
    self.numbersOfPhotoLabel.hidden = YES;
    [self.choosePhoto addSubview:self.numbersOfPhotoLabel];
    
    [self.choosePhoto addTarget:self action:@selector(pressChoosePhotoButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.choosePhoto];
}

- (void)setupLocationViews {
    UIImage *locationImage = [UIImage imageNamed:@"weizhi.png"];
    if (locationImage) {
        self.navigationIcon = [[UIImageView alloc] initWithImage:locationImage];
        self.navigationIcon.frame = CGRectMake(225, 140, 25, 25);
        [self.view addSubview:self.navigationIcon];
    }
    
    self.locationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.locationButton.frame = CGRectMake(250, 140, 110, 25);
    self.locationButton.backgroundColor = [UIColor colorWithRed:50.0/255 green:108.0/255 blue:179.0/255 alpha:1];
    [self.locationButton setTitle:@"陕西省，大荔县" forState:UIControlStateNormal];
    [self.locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.locationButton.layer.masksToBounds = YES;
    self.locationButton.layer.cornerRadius = 9;
    [self.view addSubview:self.locationButton];
}

- (void)setupFoldTableView {
    self.foldCellArray = [[NSMutableArray alloc] initWithObjects:@"原创作品", @"设计资料", @"设计教程", @"设计师观点", nil];
    self.foldTableView = [[UITableView alloc] initWithFrame:CGRectMake(225, 180, 110, 25)];
    self.foldTableView.rowHeight = 25;
    self.foldTableView.delegate = self;
    self.foldTableView.dataSource = self;
    self.foldTableView.layer.cornerRadius = 3;
    self.foldTableView.layer.masksToBounds = YES;
    self.foldTableView.scrollEnabled = NO;
    self.foldTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.foldTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"foldcell"];
    [self.view addSubview:self.foldTableView];

    self.foldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.foldButton.frame = CGRectMake(315, 168, 48, 48);
    UIImage *foldImage = [UIImage imageNamed:@"guanbi.png"];
    [self.foldButton setImage:foldImage forState:UIControlStateNormal];
    [self.foldButton setTintColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.9 alpha:1]];
    [self.foldButton addTarget:self action:@selector(pressUnfold) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.foldButton];
    self.isFolded = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isFolded ? 1 : self.foldCellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foldcell" forIndexPath:indexPath];
    
    if (indexPath.row < self.foldCellArray.count) {
        cell.textLabel.text = self.foldCellArray[indexPath.row];
    } else {
        cell.textLabel.text = @"bzda";
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)pressUnfold {
    [UIView animateWithDuration:0.3 animations:^{
        if (self.isFolded) {
            self.foldTableView.frame = CGRectMake(225, 180, 110, self.foldCellArray.count * 25);
            [self.foldButton setImage:[UIImage imageNamed:@"kaiqi.png"] forState:UIControlStateNormal];
        } else {
            self.foldTableView.frame = CGRectMake(225, 180, 110, 25);
            [self.foldButton setImage:[UIImage imageNamed:@"guanbi.png"] forState:UIControlStateNormal];
        }
    }];
    self.isFolded = !self.isFolded;
    [self.foldTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.isFolded) {
        NSString *selectedCategory = self.foldCellArray[indexPath.row];
        if (indexPath.row != 0) {
            [self.foldCellArray removeObjectAtIndex:indexPath.row];
            [self.foldCellArray insertObject:selectedCategory atIndex:0];
        }
        [self pressUnfold];
    } else {
        [self pressUnfold];
    }
}

- (void)pressBanButton:(UIButton*)button {
    button.selected = !button.selected;
}

- (void)pressPublishButton {
    if (self.numbersOfPhoto != 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已成功发布！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"请上至少上传一张图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)pressChoosePhotoButton {
    PhotoWallViewController* photoWallViewController = [[PhotoWallViewController alloc] init];
    photoWallViewController.delegate = self;
    [self.navigationController pushViewController:photoWallViewController animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameTextField resignFirstResponder];
    [self.describeTextField resignFirstResponder];
}

- (void)changedPhotoName:(NSString *)nameOfPhoto andNumber:(int)numbersOfPhoto {
    self.numbersOfPhoto = numbersOfPhoto;
    if (nameOfPhoto) {
        [self.choosePhoto setBackgroundImage:[UIImage imageNamed:nameOfPhoto] forState:UIControlStateNormal];
        [self.choosePhoto setTitle:@"" forState:UIControlStateNormal];
    }
    
    self.numbersOfPhotoLabel.text = [NSString stringWithFormat:@"%d", numbersOfPhoto];
    self.numbersOfPhotoLabel.hidden = (numbersOfPhoto == 0);
}

@end
