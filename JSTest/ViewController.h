//
//  ViewController.h
//  JSTest
//
//  Created by lidi on 2016/11/29.
//  Copyright © 2016年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol TestJSExport <JSExport>
// getUserInfo、testArgumentTypes被转化为方法名
//JSExportAs(getUserInfo,
//           -(NSString *)getUser_info:(NSString *)saw
//           );
//JSExportAs(testArgumentTypes,
//           - (NSString *)testArgumentTypesWithInt:(int)i double:(double)d
//           boolean:(BOOL)b string:(NSString *)s number:(NSNumber *)n
//           array:(NSArray *)a dictionary:(NSDictionary *)o
//           );

-(NSString *)getUserInfo;
@end

@interface ViewController : UIViewController<TestJSExport>
@property (strong, nonatomic)  UIWebView *webView;
@property (strong, nonatomic) JSContext *context;

@end

