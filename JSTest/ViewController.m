//
//  ViewController.m
//  JSTest
//
//  Created by lidi on 2016/11/29.
//  Copyright © 2016年 Li. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController
- (void)dealloc
{
    NSLog(@"ViewController dealloc");
}
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
    button.frame = CGRectMake(170, 300, 130, 50);
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
    /*
     通过 UIWebView 来获取 JSContext ，通过获取到的 context 来执⾏ JS 代码。
     会导致控制器无法释放。
     */
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 自己创建的context不能响应JS的方法。只有用该context调用的方法才执行。
//    self.context = [[JSContext alloc]initWithVirtualMachine:[[JSVirtualMachine alloc]init]];
//    self.context.name = @"Alex";
    /*
     这一步是把self对象传到JS环境，用来调用self的方法。
     使用block添加方法到JS环境时，不需要传self对象。
     使用JSExport协议添加的方法，需要传self对象。
     不要使用该方法把webView传给JS环境。
     把方法写到其他类里，把实现类实例对象传给JS环境。
     */
//    self.context[@"Alex"] = self;
    Person *person = [[Person alloc]init];
    self.context[@"Person"] = person;
    
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
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 500, 100, 100)];
            view.backgroundColor = [UIColor orangeColor];
            [weakSelf.view addSubview: view];
        });
    };

    // 如果OC和JS都实现了同一个方法，在调用JS方法时，JS方法会被OC方法覆盖。
//    self.context[@"changeColor"] = ^{
//        NSLog(@"oc changecolor method");
//    };
    
    // OC调用JS方法
    NSString *fs=@"showLog('OC调用JS方法showLog')";
    [self.context evaluateScript:fs];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.context = nil;
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    _webView.delegate = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
