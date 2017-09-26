//
//  ViewController.m
//  UMSSDKDemo
//
//  Created by 刘靖煌 on 17/5/22.
//  Copyright © 2017年 com.mob. All rights reserved.
//

#import "ViewController.h"
#import <UMSSDKUI/UMSProfileModuleViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 80, self.view.frame.size.width, 50);
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)login:(id)sender
{
    UMSProfileModuleViewController *profile = [[UMSProfileModuleViewController alloc] init];
    [self presentViewController:profile animated:YES completion:nil];
}

@end
