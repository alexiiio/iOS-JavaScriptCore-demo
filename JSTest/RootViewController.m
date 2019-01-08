//
//  RootViewController.m
//  JSTest
//
//  Created by lidi on 2019/1/8.
//  Copyright © 2019 Li. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(170, 300, 130, 50);
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"UIWebView" forState:0];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(pushToWebView) forControlEvents:UIControlEventTouchUpInside];
}
- (void)pushToWebView {
    [self.navigationController pushViewController:[[ViewController alloc]init] animated:YES];
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
