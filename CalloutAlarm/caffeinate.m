//
//  caffeinate.m
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/08.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "caffeinate.h"

// IOPMAssertionID は unsigned int 32 なので、 -1 などで不成功状態を保持できない。
// したがって成功・不成功は変数 isCaffeinateSuccess で保持する。
static IOPMAssertionID assertionID;
static BOOL isCaffeinateSuccess = NO;

BOOL doCaffeinate() {
    CFStringRef reasonForActivity= CFSTR("CalloutAlarm in action");
    IOReturn success = IOPMAssertionCreateWithName(kIOPMAssertionTypeNoIdleSleep,
                                                   kIOPMAssertionLevelOn,
                                                   reasonForActivity,
                                                   &assertionID);
    isCaffeinateSuccess = (success == kIOReturnSuccess) ? YES : NO;
    return isCaffeinateSuccess;
}

BOOL unCaffeinate() {
    if (isCaffeinateSuccess) {
        IOReturn success = IOPMAssertionRelease(assertionID);
        isCaffeinateSuccess = NO;
        return (success == kIOReturnSuccess) ? YES : NO;
    }
    return NO;
}
