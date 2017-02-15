//
//  ViewController.m
//  JSTest
//
//  Created by lidi on 2016/11/29.
//  Copyright © 2016年 Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(150, 300, 130, 50);
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"OC调用JS方法" forState:0];
    [self.webView addSubview:button];
    [button addTarget:self action:@selector(callJS_ChangeColor) forControlEvents:UIControlEventTouchUpInside];
}
// OC调用JS方法
-(void)callJS_ChangeColor{
    JSValue *function = [self.context objectForKeyedSubscript:@"changeColor"];
    JSValue *color = [function callWithArguments:nil];
    NSLog(@"背景色：%@",color);
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    self.context[@"Alex"] = self;
    
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    // JS调用OC方法
    self.context[@"showLog"] = ^(){
        NSArray *args = [JSContext currentArguments]; // 获取参数
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
        }
    };
    
    __block typeof(self) weakSelf = self;
    self.context[@"addSubView"] = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 350, 100, 100)];
            view.backgroundColor = [UIColor orangeColor];
            [weakSelf.view addSubview: view];
        });
    };
    
    // OC调用JS方法
    NSString *fs=@"showLog('OC调用JS方法showLog')";
    [self.context evaluateScript:fs];
}
-(NSString *)getUser_info:(NSString *)saw{
    return @"3dsy63";
}

-(NSString *)getUserInfo{
    return @"dsy621fa3";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
