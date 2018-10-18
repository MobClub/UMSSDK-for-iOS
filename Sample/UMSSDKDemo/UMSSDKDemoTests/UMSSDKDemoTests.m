//
//  UMSSDKDemoTests.m
//  UMSSDKDemoTests
//
//  Created by Brilance on 2018/9/20.
//  Copyright © 2018年 com.mob. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import <UMSSDK/UMSSDK.h>
#import <UMSSDK/UMSSDK+Relationship.h>
#import <UMSSDK/UMSUserCustomFields.h>
#import <UMSSDK/UMSSDK+VipCenter.h>

@interface UMSSDKDemoTests : XCTestCase

@end

@implementation UMSSDKDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}



/**
 使用正确的区号和号码下，获取注册短信验证码
 */
- (void)testGetRegisterVerificationCode
{
    [self expectationForNotification:@"getRegisterVerificationCodeWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    //如果未注册，成功获取短信验证码
    [UMSSDK getRegisterVerificationCodeWithPhone:@"15801801900"
                                        areaCode:@"86"
                                          result:^(NSError *error) {
                                              
                                              XCTAssertNil(error, @"Fail to send register verification code.");
                                              
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"getRegisterVerificationCodeWithPhone"
                                                                                                  object:nil
                                                                                                userInfo:nil];
                                          }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {}];
}

/**
 使用无效的区号和号码下，获取注册短信验证码
 */
- (void)testGetRegisterVerificationCodeWithException
{
    [self expectationForNotification:@"getRegisterVerificationCodeWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    //如果未注册，成功获取短信验证码
    [UMSSDK getRegisterVerificationCodeWithPhone:@"1501199118"
                                        areaCode:@"86"
                                          result:^(NSError *error) {
                                              
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"getRegisterVerificationCodeWithPhone"
                                                                                                  object:nil
                                                                                                userInfo:nil];
                                          }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {}];
}

///**
// 并发队列下，获取注册短信验证码
// */
//- (void)testGetRegisterVerificationCodeWithAsyncThread
//{
//    [self expectationForNotification:@"getRegisterVerificationCodeWithPhone"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 return YES;
//                             }];
//
//    for (int i = 0; i < 5; i++)
//    {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            //如果未注册，成功获取短信验证码
//            [UMSSDK getRegisterVerificationCodeWithPhone:@"15011991124"
//                                                areaCode:@"86"
//                                                  result:^(NSError *error) {
//
//                                                      XCTAssertNil(error, @"Fail to send register verification code.");
//
//                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"getRegisterVerificationCodeWithPhone"
//                                                                                                          object:nil
//                                                                                                        userInfo:nil];
//                                                  }];
//        });
//    }
//
//    [self waitForExpectationsWithTimeout:10
//                                 handler:^(NSError * _Nullable error) {}];
//}

/**
 区号和号码为nil下调用下，获取注册短信验证码
 */
- (void)testGetRegisterVerificationCodeWithArgumentIsNil
{
    [self expectationForNotification:@"getRegisterVerificationCodeWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    //如果未注册，成功获取短信验证码
    [UMSSDK getRegisterVerificationCodeWithPhone:nil
                                        areaCode:nil
                                          result:^(NSError *error) {
                                              
                                              XCTAssertNotNil(error, @"It should be failure to get the code.");
                                              
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"getRegisterVerificationCodeWithPhone"
                                                                                                  object:nil
                                                                                                userInfo:nil];
                                          }];
    
    [self waitForExpectationsWithTimeout:30
                                 handler:^(NSError * _Nullable error) {}];
}

- (void)testGetRegisterVerificationCodeWithArgumentIsInvalid
{
    [self expectationForNotification:@"getRegisterVerificationCodeWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 
                                 return YES;
                             }];
    
    //如果未注册，成功获取短信验证码
    [UMSSDK getRegisterVerificationCodeWithPhone:@(15011991178)
                                        areaCode:@(5566)
                                          result:^(NSError *error) {
                                              
                                              XCTAssertNotNil(error, @"It should be failure to get the code.");
                                              
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"getRegisterVerificationCodeWithPhone"
                                                                                                  object:nil
                                                                                                userInfo:nil];
                                          }];
    
    [self waitForExpectationsWithTimeout:30
                                 handler:^(NSError * _Nullable error) {}];
}


///**
// 使用正确的区号、号码、密码、短信验证码注册
// */
//- (void)testRegisterWithPhone
//{
//    [self expectationForNotification:@"registerWithPhone"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 return YES;
//                             }];
//
//    [UMSSDK registerWithPhone:@"15011991178"
//                     areaCode:@"86"
//                     password:@"123456"
//                      smsCode:@"4215"
//                       result:^(UMSUser *user, NSError *error) {
//
//                           XCTAssertNil(error, "Failed to register.");
//
//                           [[NSNotificationCenter defaultCenter] postNotificationName:@"registerWithPhone"
//                                                                               object:nil
//                                                                             userInfo:nil];
//
//                       }];
//
//    [self waitForExpectationsWithTimeout:30
//                                 handler:^(NSError * _Nullable error) {}];
//}


/**
 使用无效的区号、号码、密码、短信验证码，注册
 */
- (void)testRegisterWithPhoneWithException
{
    //
    [self expectationForNotification:@"registerWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification){
                                 
                                 return YES;
                             }];
    
    [UMSSDK registerWithPhone:@"1501199118"
                     areaCode:@"86"
                     password:@"123456"
                      smsCode:@"1178"
                       result:^(UMSUser *user, NSError *error) {
                           
                           XCTAssertNotNil(error, @"It should be failed to register with the wrong phone number.");
                           
                           [[NSNotificationCenter defaultCenter] postNotificationName:@"registerWithPhone"
                                                                               object:nil
                                                                             userInfo:nil];
                           
                       }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 并行队列下，调用注册接口
 */
//- (void)testRegisterWithPhoneWithAsyncThread
//{
//    [self expectationForNotification:@"registerWithPhone"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 return YES;
//                             }];
//
//    for (int i = 0; i < 5; i++)
//    {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            //如果未注册，成功获取短信验证码
//            [UMSSDK registerWithPhone:@"15011991178"
//                             areaCode:@"86"
//                             password:@"123456"
//                              smsCode:@"1178"
//                               result:^(UMSUser *user, NSError *error) {
//
//                                   XCTAssertNil(error, "Failed to register.");
//
//                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"registerWithPhone"
//                                                                                       object:nil
//                                                                                     userInfo:nil];
//                               }];
//        });
//    }
//
//    [self waitForExpectationsWithTimeout:10
//                                 handler:^(NSError * _Nullable error) {}];
//}

/**
 手机号、区号、密码、短信验证码为nil下调用注册接口
 */
- (void)testRegisterWithPhoneWithArgumentIsNil
{
    [self expectationForNotification:@"registerWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK registerWithPhone:nil
                     areaCode:nil
                     password:nil
                      smsCode:nil
                       result:^(UMSUser *user, NSError *error) {
                           
                           XCTAssertNotNil(error, @"It should be failure to get the code.");
                           
                           [[NSNotificationCenter defaultCenter] postNotificationName:@"registerWithPhone"
                                                                               object:nil
                                                                             userInfo:nil];
                           
                       }];
    
    [self waitForExpectationsWithTimeout:20
                                 handler:^(NSError * _Nullable error) {}];
}

- (void)testRegisterWithPhoneWithArgumentIsInvalid
{
    [self expectationForNotification:@"registerWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
    
                                 return YES;
                             }];
    
    [UMSSDK registerWithPhone:@(15011991178)
                     areaCode:@(86)
                     password:@123456
                      smsCode:@1122
                       result:^(UMSUser *user, NSError *error) {
                           
                           XCTAssertNotNil(error, @"It should be failure to get the code.");
                           
                           [[NSNotificationCenter defaultCenter] postNotificationName:@"registerWithPhone"
                                                                               object:nil
                                                                             userInfo:nil];
                           
                       }];
    
    [self waitForExpectationsWithTimeout:20
                                 handler:^(NSError * _Nullable error) {}];
}


/**
 使用正确的区号、号码、密码调用
 */
- (void)testLoginWithPhone
{
    [self expectationForNotification:@"LoginWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification)
     {
         return YES;
     }];
    
    [UMSSDK loginWithPhone:@"18516339329"
                  areaCode:@"86"
                  password:@"123456"
                    result:^(UMSUser *user, NSError *error)
     {
         
         XCTAssertNotNil(user, "The return user is nil");
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginWithPhone"
                                                             object:nil
                                                           userInfo:nil];
         
     }];
    
    [self waitForExpectationsWithTimeout:30
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 手机号、区号、密码为nil下调用
 */
- (void)testLoginWithPhoneWithArgumentIsNil
{
    [self expectationForNotification:@"LoginWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification)
     {
         return YES;
     }];
    
    [UMSSDK loginWithPhone:nil
                  areaCode:nil
                  password:nil
                    result:^(UMSUser *user, NSError *error)
     {
         
         XCTAssertNil(user, "The return user should be nil");
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginWithPhone"
                                                             object:nil
                                                           userInfo:nil];
         
     }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testLoginWithPhoneWithArgumentIsInvalid
{
    [self expectationForNotification:@"LoginWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification)
     {
         return YES;
     }];
    
    [UMSSDK loginWithPhone:@15011991178
                  areaCode:@86
                  password:@(123456)
                    result:^(UMSUser *user, NSError *error)
     {
         
         XCTAssertNil(user, "The return user should be nil");
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginWithPhone"
                                                             object:nil
                                                           userInfo:nil];
         
     }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 使用并行队列调用
 */
- (void)testLoginWithPhoneWithAsyncThread
{
    [self expectationForNotification:@"registerWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 100; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK loginWithPhone:@"18516339329"
                          areaCode:@"86"
                          password:@"123456"
                            result:^(UMSUser *user, NSError *error)
             {
                 XCTAssertNil(error, "Failed to register.");
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"registerWithPhone"
                                                                     object:nil
                                                                   userInfo:nil];
             }];
        });
    }
    
    [self waitForExpectationsWithTimeout:1000
                                 handler:^(NSError * _Nullable error) {}];
}

/**
 第三方登录
 */
- (void)testLoginWithPlatformType
{
    [self expectationForNotification:@"LoginWithPlatformType"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to login with platform because the current user is nil");
                                 
                                 return YES;
                             }];
    
    [UMSSDK loginWithPlatformType:UMSPlatformTypeWechat
                           result:^(UMSUser *user, NSError *error)
     {
         
         XCTAssertNotNil(user, "user is nil");
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginWithPlatformType"
                                                             object:nil
                                                           userInfo:nil];
     }];
    
    [self waitForExpectationsWithTimeout:90
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

//- (void)testLoginWithPlatformTypeWithWrongAccount
//{
//    //
//    [self expectationForNotification:@"LoginWithPlatformType"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 XCTAssertNil([UMSSDK currentUser], "the current user should be nil");
//
//                                 return YES;
//                             }];
//
//    [UMSSDK loginWithPlatformType:UMSPlatformTypeWechat
//                           result:^(UMSUser *user, NSError *error)
//     {
//
//         XCTAssertNil(user, "the user should be nil.");
//
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginWithPlatformType"
//                                                             object:nil
//                                                           userInfo:nil];
//     }];
//
//    [self waitForExpectationsWithTimeout:90
//                                 handler:^(NSError * _Nullable error) {
//
//                                 }];
//}


/**
 退出登录
 */
- (void)testLogout
{
    [self expectationForNotification:@"Logout"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNil([UMSSDK currentUser], "Failed to logout");
                                 
                                 return YES;
                             }];
    
    [UMSSDK logoutWithResult:^(NSError *error) {
        
        XCTAssertNil(error, "Failed to logout.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Logout"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 使用并发队列，退出登录
 */
//- (void)testLogoutWithAsyncThread
//{
//    [self expectationForNotification:@"Logout"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 XCTAssertNil([UMSSDK currentUser], "Failed to logout");
//
//                                 return YES;
//                             }];
//
//    for (int i = 0; i < 100; i++)
//    {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            [UMSSDK logoutWithResult:^(NSError *error) {
//
//                XCTAssertNotNil(error, "It should be Failed to logout.");
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"Logout"
//                                                                    object:nil
//                                                                  userInfo:nil];
//            }];
//        });
//    }
//
//    [self waitForExpectationsWithTimeout:30
//                                 handler:^(NSError * _Nullable error) {
//
//                                 }];
//}

/**
 绑定手机
 */
//- (void)testAccountBindingWithPhone
//{
//    [self expectationForNotification:@"AccountBindingWithPhone"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 return YES;
//                             }];
//
//    [UMSSDK accountBindingWithPhone:@"15011991178"
//                           areaCode:@"86"
//                            smsCode:@"1178"
//                           password:@"123456"
//                             result:^(UMSBindingData *bindingData, NSError *error) {
//
//                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"AccountBindingWithPhone"
//                                                                                     object:nil
//                                                                                   userInfo:nil];
//
//                                 XCTAssertNil(error, "Failed to binding with phone");
//                             }];
//
//    [self waitForExpectationsWithTimeout:10
//                                 handler:^(NSError * _Nullable error) {
//
//                                 }];
//}


/**
 参数为nil，绑定手机
 */
- (void)testAccountBindingWithPhoneWithArgumentIsNil
{
    [self expectationForNotification:@"AccountBindingWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK accountBindingWithPhone:nil
                           areaCode:nil
                            smsCode:nil
                           password:nil
                             result:^(UMSBindingData *bindingData, NSError *error) {
                                 
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"AccountBindingWithPhone"
                                                                                     object:nil
                                                                                   userInfo:nil];
                                 
                                 XCTAssertNotNil(error, "It should be failure to binding with phone");
                                 
                             }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testAccountBindingWithPhoneWithArgumentIsInvalid
{
    [self expectationForNotification:@"AccountBindingWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK accountBindingWithPhone:@15011991178
                           areaCode:@86
                            smsCode:@(1234)
                           password:@123456
                             result:^(UMSBindingData *bindingData, NSError *error) {
                                 
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"AccountBindingWithPhone"
                                                                                     object:nil
                                                                                   userInfo:nil];
                                 
                                 XCTAssertNotNil(error, "It should be failure to binding with phone");
                                 
                             }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 平台帐号绑定
 */
//- (void)testAccountBindingWithPlatformType
//{
//    [self expectationForNotification:@"AccountBindingWithPlatformType"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 return YES;
//                             }];
//
//    [UMSSDK accountBindingWithPlatformType:UMSPlatformTypeQQ
//                                    result:^(UMSBindingData *bindingData, NSError *error) {
//
//                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"AccountBindingWithPlatformType"
//                                                                                            object:nil
//                                                                                          userInfo:nil];
//
//                                        XCTAssertNil(error, "Failed to binding with phone");
//                                    }];
//
//    [self waitForExpectationsWithTimeout:150
//                                 handler:^(NSError * _Nullable error) {
//
//                                 }];
//}

/**
 获取用户信息
 */
- (void)testGetUserInfoWithResult
{
    [self expectationForNotification:@"GetUserInfoWithResult"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to get User information because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    [UMSSDK getUserInfoWithResult:^(UMSUser *user, NSError *error) {
        
        XCTAssertNil(error, "Failed to get user information.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetUserInfoWithResult"
                                                            object:nil
                                                          userInfo:nil];
        
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 并发队列下，获取用户信息
 */
- (void)testGetUserInfoWithResultWithAsyncThread
{
    [self expectationForNotification:@"GetUserInfoWithResult"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to get User information because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 100; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getUserInfoWithResult:^(UMSUser *user, NSError *error) {
                
                XCTAssertNil(error, "Failed to get user information.");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GetUserInfoWithResult"
                                                                    object:nil
                                                                  userInfo:nil];
            }];
        });
    }
    
    [self waitForExpectationsWithTimeout:1000
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 获取绑定数据
 */
- (void)testGetBindingDataWithResult
{
    [self expectationForNotification:@"GetBindingDataWithResult"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getBindingDataWithResult:^(NSArray<UMSBindingData *> *list, NSError *error) {
        
        XCTAssertNil(error, "Failed to get binding data.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetBindingDataWithResult"
                                                            object:nil
                                                          userInfo:nil];
        
    }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 并发队列下，获取绑定数据
 */
- (void)testGetBindingDataWithResultWithAsyncThread
{
    [self expectationForNotification:@"GetBindingDataWithResult"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 100; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getBindingDataWithResult:^(NSArray<UMSBindingData *> *list, NSError *error) {
                
                XCTAssertNil(error, "Failed to get binding data.");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GetBindingDataWithResult"
                                                                    object:nil
                                                                  userInfo:nil];
                
            }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 更新用户资料
 */
- (void)testUpdateUserInfo
{
    //
    [self expectationForNotification:@"UpdateUserInfo"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification)
     {
         XCTAssertNotNil([UMSSDK currentUser], "Failed to login with phone because the current user is nil");
         return YES;
     }];
    
    UMSUser *user = [UMSSDK currentUser];
    user.nickname = @"liujh";
    UMSUserCustomFields *fields = [[UMSUserCustomFields alloc] init];
    [fields setString:@"StringFieldValue" fieldName:@"StringField"];
    
    [UMSSDK updateUserInfoWithUser:user
                            result:^(UMSUser *user, NSError *error) {
                                
                                XCTAssertNil(error, "Failed to update the user information.");
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUserInfo"
                                                                                    object:nil
                                                                                  userInfo:nil];
                                
                            }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 参数为nil下，更新用户信息
 */
- (void)testUpdateUserInfoWithArgumentIsNil
{
    [self expectationForNotification:@"UpdateUserInfo"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification)
     {
         XCTAssertNotNil([UMSSDK currentUser], "Failed to login with phone because the current user is nil");
         return YES;
     }];
    
    [UMSSDK updateUserInfoWithUser:nil
                            result:^(UMSUser *user, NSError *error) {
                                
                                XCTAssertNotNil(error, "It should be Failed to update the user information.");
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUserInfo"
                                                                                    object:nil
                                                                                  userInfo:nil];
                                
                            }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testUpdateUserInfoWithArgumentIsInvalid
{
    [self expectationForNotification:@"UpdateUserInfo"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification)
     {
         XCTAssertNotNil([UMSSDK currentUser], "Failed to login with phone because the current user is nil");
         return YES;
     }];
    
    [UMSSDK updateUserInfoWithUser:@"155"
                            result:^(UMSUser *user, NSError *error) {
                                
                                XCTAssertNotNil(error, "It should be Failed to update the user information.");
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUserInfo"
                                                                                    object:nil
                                                                                  userInfo:nil];
                                
                            }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

///**
// 无效参数下，更新用户资料
// */
//- (void)testUpdateUserInfoWithInvalidArgument
//{
//    //
//    [self expectationForNotification:@"UpdateUserInfo"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification)
//     {
//         XCTAssertNotNil([UMSSDK currentUser], "It should be failed to login with phone because the current user is nil");
//         return YES;
//     }];
//
//    UMSUser *user = [UMSSDK currentUser];
//    user.nickname = @"liujh";
//    UMSUserCustomFields *fields = [[UMSUserCustomFields alloc] init];
//    [fields setString:@"StringFieldValue" fieldName:@"StringField"];
//    //    [fields setBool:YES fieldName:@"BoolField"];
//    //    [fields setNumber:@(666666) fieldName:@"NumberField"];
//    //    [fields setDate:[NSDate date] fieldName:@"DateField"];
//    //    [fields setArray:@[@1,@2,@3] fieldName:@"ArrayField"];
//
//    [UMSSDK updateUserInfoWithUser:@"User"
//                            result:^(UMSUser *user, NSError *error) {
//
//                                XCTAssertNotNil(error, "Failed to update the user information.");
//
//                                [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUserInfo"
//                                                                                    object:nil
//                                                                                  userInfo:nil];
//
//                            }];
//
//    [self waitForExpectationsWithTimeout:10
//                                 handler:^(NSError * _Nullable error) {
//
//                                 }];
//}

/**
 并发队列下，更新用户资料
 */
- (void)testUpdateUserInfoWithAsyncThread
{
    //
    [self expectationForNotification:@"UpdateUserInfo"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification)
     {
         XCTAssertNotNil([UMSSDK currentUser], "It should be failed to login with phone because the current user is nil");
         return YES;
     }];
    
    for (int i = 0; i < 10; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UMSUser *user = [UMSSDK currentUser];
            user.nickname = @"liujh";
            UMSUserCustomFields *fields = [[UMSUserCustomFields alloc] init];
            [fields setString:@"StringFieldValue" fieldName:@"StringField"];
            //    [fields setBool:YES fieldName:@"BoolField"];
            //    [fields setNumber:@(666666) fieldName:@"NumberField"];
            //    [fields setDate:[NSDate date] fieldName:@"DateField"];
            //    [fields setArray:@[@1,@2,@3] fieldName:@"ArrayField"];
            
            [UMSSDK updateUserInfoWithUser:user
                                    result:^(UMSUser *user, NSError *error) {
                                        
                                        XCTAssertNil(error, "Failed to update the user information.");
                                        
                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUserInfo"
                                                                                            object:nil
                                                                                          userInfo:nil];
                                        
                                    }];
        });
    }
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 获取重置密码的短信验证码
 */
- (void)testGetResetPasswordVerificationCodeWithPhone
{
    [self expectationForNotification:@"GetResetPasswordVerificationCodeWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getResetPasswordVerificationCodeWithPhone:@"15801801908"
                                             areaCode:@"86"
                                               result:^(NSError *error) {
                                                   
                                                   XCTAssertNil(error, "Failed to get reset password verification code.");
                                                   
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"GetResetPasswordVerificationCodeWithPhone"
                                                                                                       object:nil
                                                                                                     userInfo:nil];
                                               }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 参数为nil下，获取重置密码的短信验证码
 */
-(void)testGetResetPasswordVerificationCodeWithPhoneWithArgumentIsNil
{
    [self expectationForNotification:@"getResetPasswordVerificationCodeWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getResetPasswordVerificationCodeWithPhone:nil
                                             areaCode:nil
                                               result:^(NSError *error) {
                                                   
                                                   XCTAssertNotNil(error, "It should be Failed to get reset password verification code.");
                                                   
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"getResetPasswordVerificationCodeWithPhone"
                                                                                                       object:nil
                                                                                                     userInfo:nil];
                                               }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetResetPasswordVerificationCodeWithPhoneWithArgumentIsInvalid
{
    [self expectationForNotification:@"getResetPasswordVerificationCodeWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getResetPasswordVerificationCodeWithPhone:@(15011991178)
                                             areaCode:@86
                                               result:^(NSError *error) {
                                                   
                                                   XCTAssertNotNil(error, "It should be Failed to get reset password verification code.");
                                                   
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"getResetPasswordVerificationCodeWithPhone"
                                                                                                       object:nil
                                                                                                     userInfo:nil];
                                               }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 并发队列下，获取重置密码的短信验证码
 */
//- (void)testGetResetPasswordVerificationCodeWithPhoneWithAsyncThread
//{
//    [self expectationForNotification:@"getResetPasswordVerificationCodeWithPhone"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 return YES;
//                             }];
//
//    for (int i = 0; i < 5; i++)
//    {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            [UMSSDK getResetPasswordVerificationCodeWithPhone:@"15011991178"
//                                                     areaCode:@"86"
//                                                       result:^(NSError *error) {
//
//                                                           XCTAssertNotNil(error, "It should be Failed to get reset password verification code.");
//
//                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"getResetPasswordVerificationCodeWithPhone"
//                                                                                                               object:nil
//                                                                                                             userInfo:nil];
//                                                       }];
//        });
//    }
//
//    [self waitForExpectationsWithTimeout:10
//                                 handler:^(NSError * _Nullable error) {
//
//                                 }];
//
//
//}

/**
 重置密码
 */
//-(void)testResetPasswordWithPhone
//{
//    [self expectationForNotification:@"resetPasswordWithPhone"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 return YES;
//                             }];
//
//    [UMSSDK resetPasswordWithPhone:@"15011991178"
//                          areaCode:@"86"
//                       newPassword:@"1234567"
//                           smsCode:@"2222"
//                            result:^(NSError *error) {
//
//                                XCTAssertNil(error, "Failed to reset password.");
//
//                                [[NSNotificationCenter defaultCenter] postNotificationName:@"resetPasswordWithPhone"
//                                                                                    object:nil
//                                                                                  userInfo:nil];
//
//                            }];
//
//    [self waitForExpectationsWithTimeout:10
//                                 handler:^(NSError * _Nullable error) {
//
//                                 }];
//
//
//}

/**
 手机号、区号、密码、短信验证码为nil下，重置密码
 */
-(void)testResetPasswordWithPhoneIsNil
{
    [self expectationForNotification:@"resetPasswordWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK resetPasswordWithPhone:nil
                          areaCode:nil
                       newPassword:nil
                           smsCode:nil
                            result:^(NSError *error) {
                                
                                XCTAssertNotNil(error, "It should be Failed to reset password.");
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"resetPasswordWithPhone"
                                                                                    object:nil
                                                                                  userInfo:nil];
                                
                            }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testResetPasswordWithPhoneIsInvalid
{
    [self expectationForNotification:@"resetPasswordWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK resetPasswordWithPhone:@(15011991178)
                          areaCode:@86
                       newPassword:@123456
                           smsCode:@5566
                            result:^(NSError *error) {
                                
                                XCTAssertNotNil(error, "It should be Failed to reset password.");
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"resetPasswordWithPhone"
                                                                                    object:nil
                                                                                  userInfo:nil];
                                
                            }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 修改密码
 */
- (void)testRestModifyPasswordWithPhone
{
    [self expectationForNotification:@"ModifyPasswordWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK modifyPasswordWithPhone:@"15011991178"
                        newPassword:@"1234567"
                        oldPassword:@"123456"
                             result:^(NSError *error) {
                                 
                                 XCTAssertNil(error, "Failed to modify password.");
                                 
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"ModifyPasswordWithPhone"
                                                                                     object:nil
                                                                                   userInfo:nil];
                             }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 参数为nil下，修改密码
 */
- (void)testModifyPasswordWithPhoneWithArgumentIsNil
{
    [self expectationForNotification:@"modifyPasswordWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK modifyPasswordWithPhone:nil
                        newPassword:nil
                        oldPassword:nil
                             result:^(NSError *error) {
                                 
                                 XCTAssertNotNil(error, "It should be Failed to modify password.");
                                 
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"modifyPasswordWithPhone"
                                                                                     object:nil
                                                                                   userInfo:nil];
                             }];
    
    [self waitForExpectationsWithTimeout:30
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testModifyPasswordWithPhoneWithArgumentIsInvalid
{
    [self expectationForNotification:@"modifyPasswordWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK modifyPasswordWithPhone:@15011991178
                        newPassword:@(1234567)
                        oldPassword:@(123456)
                             result:^(NSError *error) {
                                 
                                 XCTAssertNotNil(error, "It should be Failed to modify password.");
                                 
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"modifyPasswordWithPhone"
                                                                                     object:nil
                                                                                   userInfo:nil];
                             }];
    
    [self waitForExpectationsWithTimeout:30
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 并发队列下，修改密码
 */
- (void)testModifyPasswordWithPhoneWithAsyncThread
{
    [self expectationForNotification:@"modifyPasswordWithPhone"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 5; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK modifyPasswordWithPhone:@"15011991178"
                                newPassword:@"123456"
                                oldPassword:@"1234567"
                                     result:^(NSError *error) {
                                         
                                         XCTAssertNotNil(error, "It should be Failed to reset password.");
                                         
                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"modifyPasswordWithPhone"
                                                                                             object:nil
                                                                                           userInfo:nil];
                                     }];
        });
    }
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 支持第三方登录的平台
 */
- (void)testSupportedLoginWithPlatforms
{
    [self expectationForNotification:@"SupportedLoginWithPlatforms"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK supportedLoginPlatforms:^(NSArray *supportedPlatforms) {
        
        XCTAssertNotNil(supportedPlatforms, "Failed to get supported information because the current user is nil.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SupportedLoginWithPlatforms"
                                                            object:nil
                                                          userInfo:nil];
        
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 并发队列下，支持第三方登录的平台
 */
- (void)testSupportedLoginWithPlatformsWithAsyncThread
{
    [self expectationForNotification:@"supportedLoginPlatforms"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 100; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK supportedLoginPlatforms:^(NSArray *supportedPlatforms) {
                
                XCTAssertNotNil(supportedPlatforms, "Failed to get supported information because the current user is nil.");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"supportedLoginPlatforms"
                                                                    object:nil
                                                                  userInfo:nil];
            }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 上传头像
 */
- (void)testUploadUserAvatarWithImage
{
    [self expectationForNotification:@"UploadUserAvatarWithImage"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    UIImage *image = [UIImage imageNamed:@"Pic.png"];
    
    [UMSSDK uploadUserAvatarWithImage:image
                         platformType:UMSPlatformTypePhone
                               result:^(UMSAvatar *avatar, NSError *error) {
                                   
                                   XCTAssertNil(error, "Failed to upload user avatar.");
                                   
                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"UploadUserAvatarWithImage"
                                                                                       object:nil
                                                                                     userInfo:nil];
                                   
                               }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 参数为nil下，上传头像
 */
- (void)testUploadUserAvatarWithImageWithArgumentIsNil
{
    [self expectationForNotification:@"UploadUserAvatarWithImage"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK uploadUserAvatarWithImage:nil
                         platformType:UMSPlatformTypePhone
                               result:^(UMSAvatar *avatar, NSError *error) {
                                   
                                   XCTAssertNotNil(error, "It should be Failed to upload user avatar.");
                                   
                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"UploadUserAvatarWithImage"
                                                                                       object:nil
                                                                                     userInfo:nil];
                                   
                               }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testUploadUserAvatarWithImageWithArgumentIsInvalid
{
    [self expectationForNotification:@"UploadUserAvatarWithImage"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK uploadUserAvatarWithImage:@"1155"
                         platformType:UMSPlatformTypePhone
                               result:^(UMSAvatar *avatar, NSError *error) {
                                   
                                   XCTAssertNotNil(error, "It should be Failed to upload user avatar.");
                                   
                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"UploadUserAvatarWithImage"
                                                                                       object:nil
                                                                                     userInfo:nil];
                                   
                               }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 并发队列下，上传头像
 */
- (void)testUploadUserAvatarWithImageWithAsyncThread
{
    [self expectationForNotification:@"UploadUserAvatarWithImage"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 10; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIImage *image = [UIImage imageNamed:@"Pic.png"];
            [UMSSDK uploadUserAvatarWithImage:image
                                 platformType:UMSPlatformTypePhone
                                       result:^(UMSAvatar *avatar, NSError *error) {
                                           
                                           XCTAssertNil(error, "Failed to upload user avatar.");
                                           
                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"UploadUserAvatarWithImage"
                                                                                               object:nil
                                                                                             userInfo:nil];
                                           
                                       }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


#pragma mark - Relationship

-(void)testGetRecentLoginUserList
{
    [self expectationForNotification:@"testGetRecentLoginUserList"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:5
                                       result:^(NSArray<UMSUser *> *friendList, NSError *error) {
                                           
                                           XCTAssertNotNil(friendList, "user is nil");
                                           
                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetRecentLoginUserList"
                                                                                               object:nil
                                                                                             userInfo:@{@"object":friendList[0]}];
                                           
                                       }];
    
    [self waitForExpectationsWithTimeout:15
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testGetRecentLoginUserListWithAsyn
{
    [self expectationForNotification:@"testGetRecentLoginUserList"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 50; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getRecentLoginUserListWithPageNum:0
                                             pageSize:5
                                               result:^(NSArray<UMSUser *> *friendList, NSError *error) {
                                                   
                                                   XCTAssertNotNil(friendList, "user is nil");
                                                   
                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetRecentLoginUserList"
                                                                                                       object:nil
                                                                                                     userInfo:@{@"object":friendList[0]}];
                                                   
                                               }];
        });
    }
    
    
    
    [self waitForExpectationsWithTimeout:50
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testDeleteFriendWithUser
{
    [self expectationForNotification:@"testDeleteFriendWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:5
                                       result:^(NSArray<UMSUser *> *friendList, NSError *error) {
                                           
                                           XCTAssertNotNil(friendList, "user is nil");
                                           
                                           [UMSSDK deleteFriendWithUser:friendList[3] result:^(NSError *error) {
                                               
                                               XCTAssertNotNil(error,@"Error should be not nil.");
                                               
                                               [[NSNotificationCenter defaultCenter] postNotificationName:@"testDeleteFriendWithUser"
                                                                                                   object:nil
                                                                                                 userInfo:@{@"object":friendList[0]}];
                                               
                                           }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
    
}

- (void)testDeleteFriendWithUserWithAsyncThread
{
    [self expectationForNotification:@"testDeleteFriendWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 5; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getRecentLoginUserListWithPageNum:0
                                             pageSize:5
                                               result:^(NSArray<UMSUser *> *friendList, NSError *error) {
                                                   
                                                   XCTAssertNotNil(friendList, "user is nil");
                                                   
                                                   [UMSSDK deleteFriendWithUser:friendList[3] result:^(NSError *error) {
                                                       
                                                       XCTAssertNotNil(error,@"Error should be not nil.");
                                                       
                                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"testDeleteFriendWithUser"
                                                                                                           object:nil
                                                                                                         userInfo:@{@"object":friendList[0]}];
                                                       
                                                   }];
                                               }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testDeleteFriendWithUserWithWrongParameter
{
    [self expectationForNotification:@"testDeleteFriendWithUserWithWrongParameter"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:5
                                       result:^(NSArray<UMSUser *> *friendList, NSError *error) {
                                           
                                           XCTAssertNotNil(friendList, "user is nil");
                                           
                                           [UMSSDK deleteFriendWithUser:@"0083313dba946000" result:^(NSError *error) {
                                               
                                               XCTAssertNotNil(error,@"Error should be not nil.");
                                               
                                               [[NSNotificationCenter defaultCenter] postNotificationName:@"testDeleteFriendWithUserWithWrongParameter"
                                                                                                   object:nil
                                                                                                 userInfo:@{@"object":friendList[0]}];
                                               
                                           }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetInvitedFriendListWithUser
{
    [self expectationForNotification:@"testDeleteFriendWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:5
                                       result:^(NSArray<UMSUser *> *friendList, NSError *error) {
                                           
                                           XCTAssertNotNil(friendList, "user is nil");
                                           
                                           [UMSSDK getInvitedFriendListWithUser:friendList[0]
                                                                         status:UMSDealWithRequestStatusAll
                                                                        pageNum:0
                                                                       pageSize:20
                                                                         result:^(NSArray<UMSApplyAddFriendData *> *list, NSError *error) {
                                                                             
                                                                         }];
                                           
                                           [UMSSDK deleteFriendWithUser:friendList[3] result:^(NSError *error) {
                                               
                                               XCTAssertNotNil(error,@"Error should be not nil.");
                                               
                                               [[NSNotificationCenter defaultCenter] postNotificationName:@"testDeleteFriendWithUser"
                                                                                                   object:nil
                                                                                                 userInfo:@{@"object":friendList[0]}];
                                               
                                           }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetInvitedFriendListWithUserAgain
{
    [self expectationForNotification:@"testGetInvitedFriendListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getInvitedFriendListWithUser:[UMSSDK currentUser] status:UMSDealWithRequestStatusAll
                                 pageNum:0
                                pageSize:20
                                  result:^(NSArray<UMSApplyAddFriendData *> *list, NSError *error) {
                                      
                                      XCTAssertNotNil(list, "list is nil");
                                      
                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetInvitedFriendListWithUser"
                                                                                          object:nil
                                                                                        userInfo:nil];
                                      
                                  }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetInvitedFriendListWithUserAgainWithInvalidParameter
{
    [self expectationForNotification:@"testGetInvitedFriendListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getInvitedFriendListWithUser:@"0083313dba946000" status:UMSDealWithRequestStatusAll
                                 pageNum:0
                                pageSize:20
                                  result:^(NSArray<UMSApplyAddFriendData *> *list, NSError *error) {
                                      
                                      XCTAssertNotNil(error, "error should not be nil");
                                      
                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetInvitedFriendListWithUser"
                                                                                          object:nil
                                                                                        userInfo:nil];
                                      
                                  }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetInvitedFriendListWithUserAgainWithAsyncThread
{
    [self expectationForNotification:@"testGetInvitedFriendListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 5; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getInvitedFriendListWithUser:[UMSSDK currentUser] status:UMSDealWithRequestStatusAll
                                         pageNum:0
                                        pageSize:20
                                          result:^(NSArray<UMSApplyAddFriendData *> *list, NSError *error) {
                                              
                                              XCTAssertNotNil(list, "list is nil");
                                              
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetInvitedFriendListWithUser"
                                                                                                  object:nil
                                                                                                userInfo:nil];
                                              
                                          }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testAddFriendRequestWithUser
{
    [self expectationForNotification:@"testAddFriendRequestWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:5
                                       result:^(NSArray<UMSUser *> *friendList, NSError *error) {
                                           
                                           XCTAssertNotNil(friendList, "user is nil");
                                           
                                           [UMSSDK addFriendRequestWithUser:friendList[2]
                                                                    message:@"申请加好友"
                                                                     result:^(NSError *error) {
                                                                         
                                                                         XCTAssertNil(error,@"Error should be nil.");
                                                                         
                                                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"testAddFriendRequestWithUser"
                                                                                                                             object:nil
                                                                                                                           userInfo:nil];
                                                                         
                                                                     }];
                                           
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


- (void)testAddFriendRequestWithUserWithAsyncThread
{
    [self expectationForNotification:@"testAddFriendRequestWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:5
                                       result:^(NSArray<UMSUser *> *friendList, NSError *error) {
                                           
                                           XCTAssertNotNil(friendList, "user is nil");
                                           
                                           for (int i = 0; i < 5; i++)
                                           {
                                               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                   
                                                   [UMSSDK addFriendRequestWithUser:friendList[2]
                                                                            message:@"申请加好友"
                                                                             result:^(NSError *error) {
                                                                                 
                                                                                 XCTAssertNil(error,@"Error should be nil.");
                                                                                 
                                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"testAddFriendRequestWithUser"
                                                                                                                                     object:nil
                                                                                                                                   userInfo:nil];
                                                                             }];
                                               });
                                           }
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testAddFriendRequestWithUserWithWrongParameter
{
    [self expectationForNotification:@"testAddFriendRequestWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK addFriendRequestWithUser:@"0083313dba946000"
                             message:@"申请加好友"
                              result:^(NSError *error) {
                                  
                                  XCTAssertNotNil(error,@"Error should not be nil.");
                                  
                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"testAddFriendRequestWithUser"
                                                                                      object:nil
                                                                                    userInfo:nil];
                              }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

//- (void)testDealWithFriendRequestWithUser
//{
//    XCTestExpectation *exp = [self expectationWithDescription:@"testDealWithFriendRequestWithUser"];
//
//    UMSUser *user = [UMSSDK currentUser];
//
//    [UMSSDK getInvitedFriendListWithUser:user
//                                  status:UMSDealWithRequestStatusPending
//                                 pageNum:0
//                                pageSize:20
//                                  result:^(NSArray<UMSApplyAddFriendData *> *list, NSError *error) {
//
//
//                                      XCTAssertNil(error,@"Error should be nil.");
//
//
//                                      [exp fulfill];
//
//                                      UMSApplyAddFriendData *data = list[0];
//                                      UMSUser *user = data.user;
//
//                                      [UMSSDK dealWithFriendRequestWithUser:user
//                                                                      reply:UMSDealWithRequestStatusAgree
//                                                                     result:^(NSError *error) {
//
//                                                                         XCTAssertNil(error,@"Error should be nil.");
//
//
//                                                                         [exp fulfill];
//                                                                     }];
//
//                                  }];
//
//    [self waitForExpectationsWithTimeout:100 handler:^(NSError * _Nullable error) {
//
//    }];
//}


//- (void)testDealWithFriendRequestWithUserWithAsyncThread
//{
//    [self expectationForNotification:@"testDealWithFriendRequestWithUserWithAsyncThread"
//                              object:nil
//                             handler:^BOOL(NSNotification * _Nonnull notification) {
//
//                                 return YES;
//                             }];
//
//    UMSUser *user = [UMSSDK currentUser];
//
//    [UMSSDK getInvitedFriendListWithUser:user
//                                  status:UMSDealWithRequestStatusAgree
//                                 pageNum:0
//                                pageSize:20
//                                  result:^(NSArray<UMSApplyAddFriendData *> *list, NSError *error) {
//
//                                      XCTAssertNotNil(list, "list is nil");
//
//                                      UMSApplyAddFriendData *data = list[0];
//                                      UMSUser *user = data.user;
//
//                                      for (int i = 0; i < 5; i++)
//                                      {
//                                          dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//                                              [UMSSDK dealWithFriendRequestWithUser:user
//                                                                              reply:UMSDealWithRequestStatusAgree
//                                                                             result:^(NSError *error) {
//
//                                                                                 XCTAssertNotNil(error,@"Error should not be nil.");
//
//                                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"testDealWithFriendRequestWithUserWithAsyncThread"
//                                                                                                                                     object:nil
//                                                                                                                                   userInfo:nil];
//
//                                                                             }];
//                                          });
//                                      }
//                                  }];
//
//    [self waitForExpectationsWithTimeout:100
//                                 handler:^(NSError * _Nullable error) {
//
//                                 }];
//}

- (void)testDealWithFriendRequestWithUserWithWrongParameter
{
    [self expectationForNotification:@"testDealWithFriendRequestWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    UMSUser *user = [UMSSDK currentUser];
    [UMSSDK dealWithFriendRequestWithUser:@"0083313dba946000"
                                    reply:UMSDealWithRequestStatusAgree
                                   result:^(NSError *error)
     {
         XCTAssertNotNil(error,@"Error should not be nil.");
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"testDealWithFriendRequestWithUser"
                                                             object:nil
                                                           userInfo:nil];
         
     }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


-(void)testGetFriendListWithUser
{
    [self expectationForNotification:@"testGetFriendListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[0];
                                           [UMSSDK getFriendListWithUser:user
                                                                 pageNum:0
                                                                pageSize:20
                                                                  result:^(NSArray<UMSUser *> *userList, NSError *error)
                                            {
                                                XCTAssertNil(error,@"Error should be nil.");
                                                
                                                [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetFriendListWithUser"
                                                                                                    object:nil
                                                                                                  userInfo:nil];
                                            }];
                                           
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testGetFriendListWithUserWithWrongParameter
{
    [self expectationForNotification:@"testGetFriendListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[0];
                                           [UMSSDK getFriendListWithUser:user.uid
                                                                 pageNum:0
                                                                pageSize:20
                                                                  result:^(NSArray<UMSUser *> *userList, NSError *error)
                                            {
                                                XCTAssertNotNil(error,@"Error should not be nil.");
                                                
                                                [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetFriendListWithUser"
                                                                                                    object:nil
                                                                                                  userInfo:nil];
                                            }];
                                           
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testGetFriendListWithUserWithAsyncThread
{
    [self expectationForNotification:@"testGetFriendListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[0];
                                           
                                           for (int i = 0; i < 5; i++)
                                           {
                                               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                   
                                                   [UMSSDK getFriendListWithUser:user
                                                                         pageNum:0
                                                                        pageSize:20
                                                                          result:^(NSArray<UMSUser *> *userList, NSError *error)
                                                    {
                                                        XCTAssertNil(error,@"Error should be nil.");
                                                        
                                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetFriendListWithUser"
                                                                                                            object:nil
                                                                                                          userInfo:nil];
                                                    }];
                                               });
                                           }
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testGetUserInfoWithUserID
{
    [self expectationForNotification:@"testGetUserInfoWithUserID"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getUserInfoWithUserID:@"0083313dba946000"
                           result:^(UMSUser *user, NSError *error) {
                               
                               XCTAssertNil(error,@"Error should be nil.");
                               
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetUserInfoWithUserID"
                                                                                   object:nil
                                                                                 userInfo:nil];
                               
                           }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testGetUserInfoWithUserIDWithWrongParameter
{
    [self expectationForNotification:@"testGetUserInfoWithUserID"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getUserInfoWithUserID:@(5566)
                           result:^(UMSUser *user, NSError *error) {
                               
                               XCTAssertNotNil(error,@"Error should not be nil.");
                               
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetUserInfoWithUserID"
                                                                                   object:nil
                                                                                 userInfo:nil];
                               
                           }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetUserInfoWithUserIDWithAsyncThread
{
    [self expectationForNotification:@"testGetUserInfoWithUserID"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 5; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getUserInfoWithUserID:@"0083313dba946000"
                                   result:^(UMSUser *user, NSError *error) {
                                       
                                       XCTAssertNil(error,@"Error should be nil.");
                                       
                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetUserInfoWithUserID"
                                                                                           object:nil
                                                                                         userInfo:nil];
                                   }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetBindingDataWithUser
{
    [self expectationForNotification:@"testGetBindingDataWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[0];
                                           [UMSSDK getBindingDataWithUser:user
                                                                   result:^(NSArray<UMSBindingData *> *list, NSError *error) {
                                                                       
                                                                       XCTAssertNil(error,@"Error should be nil.");
                                                                       
                                                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetBindingDataWithUser"
                                                                                                                           object:nil
                                                                                                                         userInfo:nil];
                                                                   }];
                                           
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetBindingDataWithUserWithWrongParameter
{
    [self expectationForNotification:@"testGetBindingDataWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[0];
                                           [UMSSDK getBindingDataWithUser:user.uid
                                                                   result:^(NSArray<UMSBindingData *> *list, NSError *error) {
                                                                       
                                                                       XCTAssertNotNil(error,@"Error should not be nil.");
                                                                       
                                                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetBindingDataWithUser"
                                                                                                                           object:nil
                                                                                                                         userInfo:nil];
                                                                   }];
                                           
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetBindingDataWithUserWithAsyncThread
{
    [self expectationForNotification:@"testGetBindingDataWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[0];
                                           
                                           for (int i = 0; i < 5; i++)
                                           {
                                               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                   
                                                   [UMSSDK getBindingDataWithUser:user
                                                                           result:^(NSArray<UMSBindingData *> *list, NSError *error) {
                                                                               
                                                                               XCTAssertNil(error,@"Error should be nil.");
                                                                               
                                                                               [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetBindingDataWithUser"
                                                                                                                                   object:nil
                                                                                                                                 userInfo:nil];
                                                                           }];
                                               });
                                           }
                                           
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testBlockUser
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[1];
                                           [UMSSDK blockUser:user
                                                      result:^(NSError *error) {
                                                          
                                                          XCTAssertNil(error,@"Error should be nil.");
                                                          
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                                              object:nil
                                                                                                            userInfo:nil];
                                                          
                                                      }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testBlockUserHadBlocked
{
    [self expectationForNotification:@"testBlockUserHadBlocked"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[1];
                                           
                                           [UMSSDK blockUser:user
                                                      result:^(NSError *error) {
                                                          
                                                          XCTAssertNotNil(error,@"User already in blocked list");
                                                          
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUserHadBlocked"
                                                                                                              object:nil
                                                                                                            userInfo:nil];
                                                          
                                                      }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testBlockUserWithAsyncThread
{
    [self expectationForNotification:@"testBlockUserHadBlocked"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[1];
                                           
                                           for (int i = 0; i < 5; i++)
                                           {
                                               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                   
                                                   [UMSSDK blockUser:user
                                                              result:^(NSError *error) {
                                                                  
                                                                  XCTAssertNotNil(error,@"Error should not be nil.");
                                                                  
                                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUserHadBlocked"
                                                                                                                      object:nil
                                                                                                                    userInfo:nil];
                                                                  
                                                              }];
                                               });
                                           }
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testBlockUserWithWrongParameter
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           [UMSSDK blockUser:user.uid
                                                      result:^(NSError *error) {
                                                          
                                                          XCTAssertNotNil(error,@"Error should not be nil.");
                                                          
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                                              object:nil
                                                                                                            userInfo:nil];
                                                          
                                                      }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetBlockedUserList
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           [UMSSDK getBlockedUserListWithUser:user
                                                                      pageNum:0
                                                                     pageSize:20
                                                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                                                           
                                                                           XCTAssertNil(error,@"Error should be nil.");
                                                                           
                                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                                                               object:nil
                                                                                                                             userInfo:nil];
                                                                           
                                                                       }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetBlockedUserListWithWrongParameter
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           [UMSSDK getBlockedUserListWithUser:user.uid
                                                                      pageNum:0
                                                                     pageSize:20
                                                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                                                           
                                                                           XCTAssertNotNil(error,@"Error should not be nil.");
                                                                           
                                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                                                               object:nil
                                                                                                                             userInfo:nil];
                                                                           
                                                                       }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testGetBlockedUserListWithAsyncThread
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           
                                           for (int i = 0; i < 5; i++)
                                           {
                                               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                   
                                                   [UMSSDK getBlockedUserListWithUser:user
                                                                              pageNum:0
                                                                             pageSize:20
                                                                               result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                                                                   
                                                                                   XCTAssertNil(error,@"Error should be nil.");
                                                                                   
                                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                                                                       object:nil
                                                                                                                                     userInfo:nil];
                                                                                   
                                                                               }];
                                               });
                                           }
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testRemoveFromBlockedUserList
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    UMSUser *current = [UMSSDK currentUser];
    
    [UMSSDK getBlockedUserListWithUser:current
                               pageNum:0
                              pageSize:20
                                result:^(NSArray<UMSUser *> *userList, NSError *error)
     {
         XCTAssertNotNil(userList, "userList is nil");
         
         UMSUser *user = userList[0];
         
         [UMSSDK removeFromBlockedUserListWithUser:user
                                            result:^(NSError *error) {
                                                
                                                XCTAssertNil(error,@"Error should be nil.");
                                                
                                                [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                                    object:nil
                                                                                                  userInfo:nil];
                                            }];
     }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testRemoveFromBlockedUserListWithUserHadnotBlocked
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           [UMSSDK removeFromBlockedUserListWithUser:user
                                                                              result:^(NSError *error) {
                                                                                  
                                                                                  XCTAssertNotNil(error,@"Error should not be nil.");
                                                                                  
                                                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                                                                      object:nil
                                                                                                                                    userInfo:nil];
                                                                              }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testRemoveFromBlockedUserListWithAsyncThread
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           
                                           for (int i = 0; i < 5; i++)
                                           {
                                               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                   
                                                   [UMSSDK removeFromBlockedUserListWithUser:user
                                                                                      result:^(NSError *error) {
                                                                                          
                                                                                          XCTAssertNotNil(error,@"Error should not be nil.");
                                                                                          
                                                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                                                                              object:nil
                                                                                                                                            userInfo:nil];
                                                                                      }];
                                               });
                                           }
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testRemoveFromBlockedUserListWithWrongParameter
{
    [self expectationForNotification:@"testBlockUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    UMSUser *user = [UMSSDK currentUser];
    [UMSSDK removeFromBlockedUserListWithUser:user.uid
                                       result:^(NSError *error) {
                                           
                                           XCTAssertNotNil(error,@"Error should not be nil.");
                                           
                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"testBlockUser"
                                                                                               object:nil
                                                                                             userInfo:nil];
                                       }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testFollowWithUser
{
    [self expectationForNotification:@"testFollowWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[10];
                                           
                                           [UMSSDK followWithUser:user
                                                           result:^(NSError *error)
                                            {
                                                XCTAssertNil(error,@"Error should be nil.");
                                                
                                                [[NSNotificationCenter defaultCenter] postNotificationName:@"testFollowWithUser"
                                                                                                    object:nil
                                                                                                  userInfo:nil];
                                            }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testFollowWithUserAgain
{
    [self expectationForNotification:@"testFollowWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           
                                           [UMSSDK followWithUser:user
                                                           result:^(NSError *error)
                                            {
                                                XCTAssertNotNil(error,@"Error should not be nil.");
                                                
                                                [[NSNotificationCenter defaultCenter] postNotificationName:@"testFollowWithUser"
                                                                                                    object:nil
                                                                                                  userInfo:nil];
                                            }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testFollowWithUserWithAsyncThread
{
    [self expectationForNotification:@"testFollowWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           
                                           for (int i = 0; i < 5; i++)
                                           {
                                               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                   
                                                   [UMSSDK followWithUser:user
                                                                   result:^(NSError *error)
                                                    {
                                                        XCTAssertNotNil(error,@"Error should not be nil.");
                                                        
                                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"testFollowWithUser"
                                                                                                            object:nil
                                                                                                          userInfo:nil];
                                                    }];
                                               });
                                           }
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testFollowWithUserWithWrongParameter
{
    [self expectationForNotification:@"testFollowWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           
                                           [UMSSDK followWithUser:user.uid
                                                           result:^(NSError *error)
                                            {
                                                XCTAssertNotNil(error,@"Error should not be nil.");
                                                
                                                [[NSNotificationCenter defaultCenter] postNotificationName:@"testFollowWithUser"
                                                                                                    object:nil
                                                                                                  userInfo:nil];
                                            }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testUnfollowUserWithUser
{
    [self expectationForNotification:@"testUnfollowUserWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[10];
                                           
                                           [UMSSDK unfollowUserWithUser:user
                                                                 result:^(NSError *error) {
                                                                     
                                                                     XCTAssertNil(error, "error should be nil");
                                                                     
                                                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"testUnfollowUserWithUser"
                                                                                                                         object:nil
                                                                                                                       userInfo:nil];
                                                                 }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testUnfollowUserWithUserWithAsyn
{
    [self expectationForNotification:@"testUnfollowUserWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           
                                           for (int i = 0; i < 5; i++)
                                           {
                                               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                                   
                                                   [UMSSDK unfollowUserWithUser:user
                                                                         result:^(NSError *error) {
                                                                             
                                                                             XCTAssertNotNil(error, "error should be not nil");
                                                                             
                                                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"testUnfollowUserWithUser"
                                                                                                                                 object:nil
                                                                                                                               userInfo:nil];
                                                                         }];
                                               });
                                           }
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testUnfollowUserWithUserWithWrongParameter
{
    [self expectationForNotification:@"testUnfollowUserWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK getRecentLoginUserListWithPageNum:0
                                     pageSize:20
                                       result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                           
                                           XCTAssertNotNil(userList, "userList is nil");
                                           
                                           UMSUser *user = userList[6];
                                           
                                           [UMSSDK unfollowUserWithUser:user.uid
                                                                 result:^(NSError *error) {
                                                                     
                                                                     XCTAssertNotNil(error, "error should not be nil");
                                                                     
                                                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"testUnfollowUserWithUser"
                                                                                                                         object:nil
                                                                                                                       userInfo:nil];
                                                                 }];
                                       }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testGetFansListWithUser
{
    [self expectationForNotification:@"testGetFansListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    UMSUser *current = [UMSSDK currentUser];
    [UMSSDK getFansListWithUser:current
                   relationship:UMSRelationshipFans
                        pageNum:0
                       pageSize:20
                         result:^(NSArray<UMSUser *> *userList, NSError *error) {
                             
                             XCTAssertNotNil(userList, "userList should be not nil");
                             
                             [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetFansListWithUser"
                                                                                 object:nil
                                                                               userInfo:nil];
                             
                         }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testGetFansListWithUserWithWrongParameter
{
    [self expectationForNotification:@"testGetFansListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    UMSUser *current = [UMSSDK currentUser];
    [UMSSDK getFansListWithUser:current.uid
                   relationship:UMSRelationshipFans
                        pageNum:0
                       pageSize:20
                         result:^(NSArray<UMSUser *> *userList, NSError *error) {
                             
                             XCTAssertNotNil(error, "error should be not nil");
                             
                             [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetFansListWithUser"
                                                                                 object:nil
                                                                               userInfo:nil];
                             
                         }];
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testGetFansListWithUserWithAsyn
{
    [self expectationForNotification:@"testGetFansListWithUser"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    UMSUser *current = [UMSSDK currentUser];
    
    for (int i = 0; i < 5; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getFansListWithUser:current
                           relationship:UMSRelationshipFans
                                pageNum:0
                               pageSize:20
                                 result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                     
                                     XCTAssertNotNil(userList, "userList should be not nil");
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"testGetFansListWithUser"
                                                                                         object:nil
                                                                                       userInfo:nil];
                                     
                                 }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testSearchForUserWithKey
{
    [self expectationForNotification:@"testSearchForUserWithKey"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK searchForUserWithKey:@"yuyu123"
                         pageNum:0
                        pageSize:20
                          result:^(NSArray<UMSUser *> *userList, NSError *error) {
                              
                              XCTAssertNil(error, "error should be nil");
                              
                              [[NSNotificationCenter defaultCenter] postNotificationName:@"testSearchForUserWithKey"
                                                                                  object:nil
                                                                                userInfo:nil];
                              
                          }];
    
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

-(void)testSearchForUserWithKeyWithWrongParameter
{
    [self expectationForNotification:@"testSearchForUserWithKey"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    [UMSSDK searchForUserWithKey:@123
                         pageNum:0
                        pageSize:20
                          result:^(NSArray<UMSUser *> *userList, NSError *error) {
                              
                              XCTAssertNotNil(error, "error should not be nil");
                              
                              [[NSNotificationCenter defaultCenter] postNotificationName:@"testSearchForUserWithKey"
                                                                                  object:nil
                                                                                userInfo:nil];
                              
                          }];
    
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

- (void)testSearchForUserWithKeyWithAsyn
{
    [self expectationForNotification:@"testSearchForUserWithKey"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 return YES;
                             }];
    
    for (int i = 0; i < 50; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK searchForUserWithKey:@"yuyu123"
                                 pageNum:0
                                pageSize:20
                                  result:^(NSArray<UMSUser *> *userList, NSError *error) {
                                      
                                      XCTAssertNil(error, "error should be nil");
                                      
                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"testSearchForUserWithKey"
                                                                                          object:nil
                                                                                        userInfo:nil];
                                      
                                  }];
        });
    }
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


#pragma mark - VipCenter

/**
 获取用户订购过的会员信息列表
 */
- (void)testGetVipInfoWithResult
{
    [self expectationForNotification:@"GetVipInfoWithResult"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to get vip information because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    [UMSSDK getVipInfoWithResult:^(NSArray<UMSVip *> *vipList, NSError *error) {
        XCTAssertNil(error, "Failed to get vip information.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetVipInfoWithResult"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 并发队列下，获取用户订购过的会员信息列表
 */
- (void)testGetVipInfoWithResultWithAsyncThread
{
    [self expectationForNotification:@"GetVipInfoWithResult"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to get vip information because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 100; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getVipInfoWithResult:^(NSArray<UMSVip *> *vipList, NSError *error) {
                XCTAssertNil(error, "Failed to get vip information.");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GetVipInfoWithResult"
                                                                    object:nil
                                                                  userInfo:nil];
            }];
        });
    }
    
    [self waitForExpectationsWithTimeout:1000
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 获取所有会员产品列表
 */
- (void)testGetVipProductListWithResult{
    [self expectationForNotification:@"GetVipProductListWithResult"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to get vipProductList information because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    [UMSSDK getVipProductListWithResult:^(NSMutableArray<UMSVipProduct *> *vipProductList, NSError *error) {
        XCTAssertNil(error, "Failed to get vipProductList information.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetVipProductListWithResult"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 并发队列下，获取用户订购过的会员信息列表
 */
- (void)testGetVipProductListWithAsyncThread
{
    [self expectationForNotification:@"GetVipProductListWithResult"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to get vipProductList information because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    for (int i = 0; i < 100; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [UMSSDK getVipProductListWithResult:^(NSMutableArray<UMSVipProduct *> *vipProductList, NSError *error) {
                XCTAssertNil(error, "Failed to get vipProductList information.");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GetVipProductListWithResult"
                                                                    object:nil
                                                                  userInfo:nil];
            }];
        });
    }
    
    [self waitForExpectationsWithTimeout:1000
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 创建购买会员订单
 */
- (void)testCreateOrder{
    [self expectationForNotification:@"CreateOrder"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to create order because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    [UMSSDK createOrderWithSpeciId:@"01b9493f30097000" type:2 result:^(NSString *orderId, NSError *error) {
        XCTAssertNil(error, "Failed to create order.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateOrder"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 创建购买会员订单 会员产品对应是否免费 传入错误type
 */
- (void)testCreateOrderWithErrorType{
    [self expectationForNotification:@"CreateOrder"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to create order because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    [UMSSDK createOrderWithSpeciId:@"01b9493f30097000" type:0 result:^(NSString *orderId, NSError *error) {
        XCTAssertNil(error, "Failed to create order.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateOrder"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 并发队列下 创建购买会员订单
 */
- (void)testCreateOrderWithAsyncThread{
    [self expectationForNotification:@"CreateOrder"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to create order because the current user is nil.");
                                 
                                 return YES;
                             }];
    for (int i = 0; i < 5; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [UMSSDK createOrderWithSpeciId:@"01b9493f30097000" type:2 result:^(NSString *orderId, NSError *error) {
                XCTAssertNil(error, "Failed to create order.");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateOrder"
                                                                    object:nil
                                                                  userInfo:nil];
            }];
        });
    }
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 创建购买会员订单 传入错误的参数
 */
- (void)testCreateOrderWithWrongParameter{
    [self expectationForNotification:@"CreateOrder"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to create order because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    
    [UMSSDK createOrderWithSpeciId:@"01b9493f300970009juns" type:2 result:^(NSString *orderId, NSError *error) {
        XCTAssertNotNil(error, "Failed to create order.");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateOrder"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 购买会员 提交订单并支付
 */
- (void)testSubmitOrderToPay{
    [self expectationForNotification:@"submitOrderAndToPay"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to submit order and to pay because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    [UMSSDK createOrderWithSpeciId:@"01b9493f30097000" type:2 result:^(NSString *orderId, NSError *error) {
        XCTAssertNil(error, "Failed to submit order and to pay.");
        [UMSSDK sumbitOrderToPayWithOrderId:orderId channel:50 result:^(NSUInteger channel, NSUInteger payStatus, NSError *error) {
            XCTAssertNil(error, "Failed to submit order and to pay.");
            switch (payStatus)
            {
                case 1:
                    break;
                case 2:
                    break;
                case 3:
                    
                    break;
                default:
                    break;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"submitOrderAndToPay"
                                                                object:nil
                                                              userInfo:nil];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 购买会员 提交订单并支付 错误的渠道号
 */
- (void)testSubmitOrderToPayWithWrongChannel{
    [self expectationForNotification:@"submitOrderAndToPay"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to submit order and to pay because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    [UMSSDK createOrderWithSpeciId:@"01b9493f30097000" type:2 result:^(NSString *orderId, NSError *error) {
        XCTAssertNil(error, "Failed to submit order and to pay.");
        [UMSSDK sumbitOrderToPayWithOrderId:orderId channel:12 result:^(NSUInteger channel, NSUInteger payStatus, NSError *error) {
            XCTAssertNotNil(error, "Failed to submit order and to pay.");
            switch (payStatus)
            {
                case 1:
                    break;
                case 2:
                    break;
                case 3:
                    
                    break;
                default:
                    break;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"submitOrderAndToPay"
                                                                object:nil
                                                              userInfo:nil];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 购买会员 提交订单并支付 错误的 orderId
 */
- (void)testSubmitOrderToPayWithWrongOrderId{
    [self expectationForNotification:@"submitOrderAndToPay"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssertNotNil([UMSSDK currentUser], "Failed to submit order and to pay because the current user is nil.");
                                 
                                 return YES;
                             }];
    
    [UMSSDK sumbitOrderToPayWithOrderId:@"123456789" channel:50 result:^(NSUInteger channel, NSUInteger payStatus, NSError *error) {
        XCTAssertNotNil(error, "Failed to submit order and to pay.");
        switch (payStatus)
        {
            case 1:
                break;
            case 2:
                break;
            case 3:
                
                break;
            default:
                break;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"submitOrderAndToPay"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 获取用户交易记录
 */
- (void)testGetOrderRecord{
    [self expectationForNotification:@"getOrderRecord"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getOrderRecordWithUser:[UMSSDK currentUser] pageNum:0 pageSize:20 result:^(NSArray<UMSVipOrder *> *vipOrderList, NSError *error) {
        XCTAssertNil(error, "Failed to get order record.");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderRecord"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 获取用户交易记录 传空的用户
 */
- (void)testGetOrderRecordWithUserIsNull{
    [self expectationForNotification:@"getOrderRecord"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getOrderRecordWithUser:nil pageNum:0 pageSize:20 result:^(NSArray<UMSVipOrder *> *vipOrderList, NSError *error) {
        XCTAssertNotNil(error, "Failed to get order record.");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderRecord"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}


/**
 并发队列下 获取用户交易记录
 */
- (void)testGetOrderRecordWithAsyncThread{
    [self expectationForNotification:@"getOrderRecord"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    for (int i = 0; i < 100; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [UMSSDK getOrderRecordWithUser:[UMSSDK currentUser] pageNum:0 pageSize:20 result:^(NSArray<UMSVipOrder *> *vipOrderList, NSError *error) {
                XCTAssertNil(error, "Failed to get order record.");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderRecord"
                                                                    object:nil
                                                                  userInfo:nil];
            }];
        });
    }
    [self waitForExpectationsWithTimeout:1000
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 获取订单信息
 */
- (void)testGetOrderInfo{
    [self expectationForNotification:@"getOrderInfo"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    [UMSSDK createOrderWithSpeciId:@"01b9493f30097000" type:2 result:^(NSString *orderId, NSError *error) {
        XCTAssertNil(error, "Failed to submit order and to pay.");
        [UMSSDK getOrderInfoWithUser:[UMSSDK currentUser] orderId:orderId result:^(UMSVipOrder *order, NSError *error) {
            XCTAssertNil(error, "Failed to get order info.");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderInfo"
                                                                object:nil
                                                              userInfo:nil];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 获取订单信息 传空的用户
 */
- (void)testGetOrderInfoWithUserIsNull{
    [self expectationForNotification:@"getOrderInfo"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    [UMSSDK createOrderWithSpeciId:@"01b9493f30097000" type:2 result:^(NSString *orderId, NSError *error) {
        XCTAssertNil(error, "Failed to submit order and to pay.");
        [UMSSDK getOrderInfoWithUser:nil orderId:orderId result:^(UMSVipOrder *order, NSError *error) {
            XCTAssertNotNil(error, "Failed to get order info.");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderInfo"
                                                                object:nil
                                                              userInfo:nil];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 获取订单信息 传不存在的订单号
 */
- (void)testGetOrderInfoWithWrongOrderId{
    [self expectationForNotification:@"getOrderInfo"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    
    [UMSSDK getOrderInfoWithUser:[UMSSDK currentUser] orderId:@"123456789" result:^(UMSVipOrder *order, NSError *error) {
        XCTAssertNil(error, "Failed to get order info.");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderInfo"
                                                            object:nil
                                                          userInfo:nil];
    }];
    
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}

/**
 获取订单信息 传不存在的订单号
 */
- (void)testGetOrderInfoWithAsyncThread{
    [self expectationForNotification:@"getOrderInfo"
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 return YES;
                             }];
    [UMSSDK createOrderWithSpeciId:@"01b9493f30097000" type:2 result:^(NSString *orderId, NSError *error) {
        XCTAssertNil(error, "Failed to submit order and to pay.");
        
        for (int i = 0; i < 100; i++)
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [UMSSDK getOrderInfoWithUser:[UMSSDK currentUser] orderId:orderId result:^(UMSVipOrder *order, NSError *error) {
                    XCTAssertNil(error, "Failed to get order info.");
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getOrderInfo"
                                                                        object:nil
                                                                      userInfo:nil];
                }];
            });
        }
    }];
    
    
    [self waitForExpectationsWithTimeout:100
                                 handler:^(NSError * _Nullable error) {
                                     
                                 }];
}
@end
