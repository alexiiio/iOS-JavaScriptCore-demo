//
//  Person.h
//  JSTest
//
//  Created by lidi on 2019/1/8.
//  Copyright © 2019 Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol PersonJSExport <JSExport>

- (void)sayHi;

@end


@interface Person : NSObject<PersonJSExport>

@end


