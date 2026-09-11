//
//  UserManager.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSMutableArray *usernames;
@property (nonatomic, strong) NSMutableArray *passwords;
@property (nonatomic, copy) NSString *currentUser;
- (void)saveUserData;
- (void)loadUserData;
- (BOOL)updatePasswordForUser:(NSString *)username oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword;
@end
