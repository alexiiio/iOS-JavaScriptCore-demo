//
//  UIWebView+JavaScriptAlert.h
//  pukka-ios
//
//  Created by lidi on 2016/12/2.
//  Copyright © 2016年 Li Inc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIWebView (JavaScriptAlert)
-(void) webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;
@end
