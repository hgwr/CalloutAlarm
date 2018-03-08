//
//  caffeinate.m
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/08.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//
// references:
//   https://developer.apple.com/library/content/qa/qa1340/_index.html
//   https://qiita.com/asus4/items/02b5096a937bbd419f3e

#import <Foundation/Foundation.h>
#import "caffeinate.h"

// IOPMAssertionID は unsigned int 32 なので、 -1 などで不成功状態を保持できない。
// したがって成功・不成功は変数 isCaffeinateSuccess で保持する。
static IOPMAssertionID assertionID;
static BOOL isCaffeinateSuccess = NO;

BOOL doCaffeinate() {
    NSLog(@"doCaffeinate start");
    CFStringRef reasonForActivity= CFSTR("CalloutAlarm in action");
    IOReturn success = IOPMAssertionCreateWithName(kIOPMAssertionTypeNoDisplaySleep,
                                                   kIOPMAssertionLevelOn,
                                                   reasonForActivity,
                                                   &assertionID);
    isCaffeinateSuccess = (success == kIOReturnSuccess) ? YES : NO;
    NSLog(@"doCaffeinate: isCaffeinateSuccess = %s, assertionID = %d",
          isCaffeinateSuccess ? "YES" : "NO",
          assertionID);
    return isCaffeinateSuccess;
}

BOOL unCaffeinate() {
    NSLog(@"unCaffeinate start");
    if (isCaffeinateSuccess) {
        IOReturn success = IOPMAssertionRelease(assertionID);
        isCaffeinateSuccess = NO;
        NSLog(@"unCaffeinate: IOPMAssertionRelease: assertionID = %d", assertionID);
        return (success == kIOReturnSuccess) ? YES : NO;
    }
    NSLog(@"unCaffeinate: not IOPMAssertionRelease: assertionID = %d", assertionID);
    return NO;
}
