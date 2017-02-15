//
//  UIWebView_JavaScriptAlert.m
//  pukka-ios
//
//  Created by lidi on 2016/12/2.
//  Copyright © 2016年 Li Inc. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"

@implementation UIWebView (JavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [customAlert show];
}
static BOOL diagStat = NO;
static NSInteger bIdx = -1;
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
    UIAlertView *confirmDiag = [[UIAlertView alloc] initWithTitle:message
                                                          message:@""
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
    
    [confirmDiag show];
    bIdx = -1;
    
    while (bIdx==-1) {
        //[NSThread sleepForTimeInterval:0.2];
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
    }
    if (bIdx == 0){//取消;
        diagStat = NO;
    }
    else if (bIdx == 1) {//确定;
        diagStat = YES;
    }
    return diagStat;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    bIdx = buttonIndex;
}

@end
