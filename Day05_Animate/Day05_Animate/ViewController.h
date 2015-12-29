//
//  ViewController.h
//  Day05_Animate
//
//  Created by tarena on 15/12/3.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//默认不写 atomic : 线程安全: 有锁
@property(nonatomic,strong) NSString *oneStr;

@end







