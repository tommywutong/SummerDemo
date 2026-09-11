//
//  UserManager.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import "UserManager.h"

@implementation UserManager

//单例
+ (instancetype)sharedManager {
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserManager alloc] init];
        [manager loadUserData];
    });
    return manager;
}

- (id)init {
    self = [super init];
    if (self) {
        _usernames = [NSMutableArray array];
        _passwords = [NSMutableArray array];
        [_usernames addObject:@"1"];
        [_passwords addObject:@"1"];
    }
    return self;
}


//保存到本地
- (void)saveUserData {
    [[NSUserDefaults standardUserDefaults] setObject:self.usernames forKey:@"savedUsernames"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwords forKey:@"savedPasswords"];
    [[NSUserDefaults standardUserDefaults] synchronize];    //不懂，好像是保存
}

- (void)loadUserData {
    NSArray *savedUsernames = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedUsernames"];
    NSArray *savedPasswords = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedPasswords"];
    NSDictionary *savedGenders = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedUserGenders"];
    
    if (savedUsernames) {
        self.usernames = [savedUsernames mutableCopy];
    }
    if (savedPasswords) {
        self.passwords = [savedPasswords mutableCopy];
    }
    
    if (![self.usernames containsObject:@"1"]) {
        [self.usernames addObject:@"1"];
        [self.passwords addObject:@"1"];
    }
}


- (BOOL)updatePasswordForUser:(NSString *)username oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword {
    NSUInteger index = [self.usernames indexOfObject:username];
    
    if (index == NSNotFound) {  //NSNotFound 是 Objective-C 中的一个常量，表示“没有找到”的情况，常用于查找操作的结果。
        return NO;
    }
    if (![oldPassword isEqualToString:self.passwords[index]]) {
        return NO;
    }
    self.passwords[index] = newPassword;
    [self saveUserData];
    
    return YES;
}

@end
