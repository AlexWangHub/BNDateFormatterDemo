//
//  ViewController.m
//  BNDateFormatterDemo
//
//  Created by binbinwang on 2021/11/20.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger count = 1000;
    CFTimeInterval begin;
    CFTimeInterval end;
    NSDateFormatter *formatter;
    NSString *string;
    NSDate *date = [NSDate date];
    
    NSString *aaa = @"aaa";
    NSString *bbb = @"bbb";
    NSString *ccc = @"ccc";
    
    // 1. 测试每次都重建 NSDateFormatter 去解析 NSDate 是否耗时
    {
        // 1.1 每次解析时间都创建一个Formatter
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            formatter  = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            string = [formatter stringFromDate:date];
        }
        end = CACurrentMediaTime();
        printf("NSDateFormatter:               %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        // 1.2 只用一个Formatter去解析时间
        begin = CACurrentMediaTime();
        formatter  = [[NSDateFormatter alloc] init];
        for (int i = 0; i < count; i++) {
            [formatter setDateFormat:@"yyyy-MM-dd"];
            string = [formatter stringFromDate:date];
        }
        end = CACurrentMediaTime();
        printf("NSDateFormatter once:         %8.2f ms\n", (end - begin) * 1000);
    }
    
    // 2. 检测是哪个环节耗时
    CFTimeInterval a;
    CFTimeInterval b;
    CFTimeInterval c;
    {
        for (int i = 0; i < count; i++) {
            begin = CACurrentMediaTime();
            // 创建 Formatter
            formatter  = [[NSDateFormatter alloc] init];
            end = CACurrentMediaTime();
            a += (end-begin);
            
            begin = CACurrentMediaTime();
            // 给 Formatter 标识解析格式
            [formatter setDateFormat:@"yyyy-MM-dd"];
            end = CACurrentMediaTime();
            b += (end-begin);
            
            begin = CACurrentMediaTime();
            // Formatter 解析 Date
            string = [formatter stringFromDate:date];
            end = CACurrentMediaTime();
            c += (end-begin);
        }
        
        printf("NSDateFormatter:alloc               %8.2f ms\n", a * 1000);
        printf("NSDateFormatter:setFormat           %8.2f ms\n", b * 1000);
        printf("NSDateFormatter:stringFromDate      %8.2f ms\n", c * 1000);
    }
}


@end
