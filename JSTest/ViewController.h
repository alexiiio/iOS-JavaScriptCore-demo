//
//  ViewController.h
//  JSTest
//
//  Created by lidi on 2016/11/29.
//  Copyright © 2016年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@interface ViewController : UIViewController
@property (strong, nonatomic)  UIWebView *webView;
@property (strong, nonatomic) JSContext *context;

@end

