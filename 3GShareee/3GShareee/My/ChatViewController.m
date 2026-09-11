//
//  chatViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/19.
//  

#import "ChatViewController.h"
#import "MessageTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic, strong) NSMutableArray *rowHeightArray;
@property (nonatomic, strong) NSNumber *rowHeight;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, assign) BOOL isNextOutgoing;
@property (nonatomic, strong) UIView *inputContainerView;

@end

@implementation ChatViewController
/*
隐藏tabBar
*/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.title = @"私信";
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"share小白";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"holidayfanhui.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(pressReturn)];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backButton;
    [self setupInputArea];
    [self setupTableView];
    [self setupMessages];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(handleKeyboardWillChangeFrame:)
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
    /*
     添加这个监听，这个通知会在键盘即将弹出、收起或高度改变时发送
     */
    self.isNextOutgoing = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}


- (void)setupInputArea {
    _inputContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 60, WIDTH, 60)];
    _inputContainerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [self.view addSubview:_inputContainerView];

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 8, WIDTH - 100, 44)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"输入消息...";
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeySend;
    [self.inputContainerView addSubview:self.textField];
    self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sendButton.frame = CGRectMake(WIDTH - 80, 8, 70, 44);
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.backgroundColor = [UIColor colorWithRed:0.0 green:0.48 blue:1.0 alpha:1.0];
    self.sendButton.layer.cornerRadius = 8;
    [self.sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.inputContainerView addSubview:self.sendButton];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 60) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"MessageCell"];
    [self.view addSubview:_tableView];
}

- (void)setupMessages {
    _messageArray = [NSMutableArray array];
    _rowHeightArray = [NSMutableArray array];
    
    [self addMessage:@"1" isOutgoing:NO];
    [self addMessage:@"2" isOutgoing:YES];
    [self addMessage:@"3" isOutgoing:NO];
    [self addMessage:@"4" isOutgoing:YES];
    [self addMessage:@"5" isOutgoing:NO];
    [self addMessage:@"6" isOutgoing:YES];
    [self addMessage:@"7" isOutgoing:YES];
    [self scrollToBottom];
}

- (void)addMessage:(NSString *)message isOutgoing:(BOOL)isOutgoing {
    NSDictionary *messageDict = @{
        @"text": message,
        @"outgoing": @(isOutgoing)
    };
    [_messageArray addObject:messageDict];
    
    NSDictionary *attri = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    /*
     boundingRectWithSize:... 是 NSString 的一个方法
     你告诉他最大容纳的尺寸 会帮你计算出这段字符串在这些限制下需要多大的空间
    */
    CGSize size = [message boundingRectWithSize:CGSizeMake(WIDTH * 0.6, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attri
                                       context:nil].size;
    CGFloat height = MAX(60, size.height + 40);
    [_rowHeightArray addObject:@(height)];
}

- (void)sendMessage {
    if (self.textField.text.length == 0) return;

    [self addMessage:self.textField.text isOutgoing:self.isNextOutgoing];
    self.isNextOutgoing = !self.isNextOutgoing; //实现交替发送
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    /*
     直接到底部
     */
    [self scrollToBottom];
    self.textField.text = @"";
}

- (void)scrollToBottom {
    if (self.messageArray.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        /*
         取出最后一条消息然后直接滚动到该条消息处
         */
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    NSDictionary *message = self.messageArray[indexPath.row];
    [cell configureWithText:message[@"text"] isOutgoing:[message[@"outgoing"] boolValue]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.rowHeightArray[indexPath.row] floatValue];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendMessage];
    return YES;
}
/*
 在监听到通知后，调整聊天页面自动上移
 同时画到最低
 */
- (void)handleKeyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.inputContainerView.frame = CGRectMake(0,
                                               endFrame.origin.y - 60,
                                               WIDTH,
                                               60);
    self.tableView.frame = CGRectMake(0,
                                      0,
                                      WIDTH,
                                      endFrame.origin.y - 60);
    [self scrollToBottom];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)pressReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
