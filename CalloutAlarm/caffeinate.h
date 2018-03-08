//
//  caffeinate.h
//  CalloutAlarm
//
//  Created by Shigeru Hagiwara on 2018/03/08.
//  Copyright © 2018年 Shigeru Hagiwara. All rights reserved.
//
// references:
//   https://developer.apple.com/library/content/qa/qa1340/_index.html
//   https://qiita.com/asus4/items/02b5096a937bbd419f3e

#ifndef caffeinate_h
#define caffeinate_h

#import <Foundation/Foundation.h>
#import <IOKit/pwr_mgt/IOPMLib.h>

BOOL doCaffeinate(void);
BOOL unCaffeinate(void);

#endif /* caffeinate_h */
