//
//  ViewController.m
//  Day05_Animate
//
//  Created by tarena on 15/12/3.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) UIImageView *imageView;
@end
@implementation ViewController

- (UIImageView *)imageView {
    if(_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
//为图片做一个标志,表示需要更新位置
        [_imageView setNeedsLayout];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
//layoutIfNeeded 会立刻把需要更新位置的控件,进行更新
//        [self.view layoutIfNeeded];
        [_imageView layoutIfNeeded];
    }
    return _imageView;
}

@synthesize oneStr = _oneStr;
//atomic是有锁, 加锁和解锁过程是耗时操作,影响效率. 因为这种线程安全的情况很少需要, 所以普遍使用nonatomic, 非线程安全,即不加锁, 提高了效率.
/** 如果是atomic,即默认情况, set方法有锁*/
- (void)setOneStr:(NSString *)oneStr{
    @synchronized(self) {
       _oneStr = oneStr;
    }
}
/** 如果是atomic,即默认情况, get方法有锁*/
- (NSString *)oneStr{
    @synchronized(self) {
        return _oneStr;
    }
}
//更新约束,把图片移动屏幕左侧
//mas_updateConstraints更新约束
/*
 [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(0);
 }];
 */
//重新加约束mas_remakeConstraints和mas_make 没区别
/*
 [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(0);
 make.left.mas_equalTo(0);
 make.size.mas_equalTo(CGSizeMake(100, 100));
 [self.view layoutIfNeeded];
 }];
 */

//使用NSTimer 定时器, 每隔一段时间 改变X轴位置,即可实现移动
/*
 参数1:动画时长
 参数2:动画结束后的状态
 */

// Do any additional setup after loading the view, typically from a nib.
//制作一个动画形式的UIImage
/* 下方方法会自动寻找 参数一后面加0~无限大 的图片 */
//参数2 动画时间间隔
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage animatedImageNamed:@"loading_" duration:0.4];
    self.imageView.image = image;
//    [self moveToRightTop];
    [self reverseAnimate];
}

//从原始位置 跑到右下角, 跑到右下角以后,再跑回来,如此反复
- (void)reverseAnimate{
//delay:延迟操作
//options:是枚举类型,表示动画的展现方式
//例如Repeat重复动画,  Autoreverse反向动画 Linear线性
    [UIView animateWithDuration:4 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveLinear animations:^{
//设置透明度变化 alpha 0~1  透明~不透明
        self.imageView.alpha = 0;
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@".......");
    }];
}


//原始位置 移动到 右上角, 并且变小. 动画结束以后打印
- (void)moveToRightTop{
    [UIView animateWithDuration:6 animations:^{
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
//  如果有需要,要更新位置
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@"动画结束后,自动执行这里的方法");
    }];
}

//左边移动到右边---最简单
- (void)runToRight{
    [UIView animateWithDuration:10 animations:^{
        //如果是frame模式,直接在这里填frame即可
        //self.imageView.center = CGPointMake(300, 100);
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        //如果有需要,让self.view根据约束更新内部空间位置
        [self.view layoutIfNeeded];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
