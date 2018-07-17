//
//  ViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "ViewController.h"
#import "JNColor.h"
#import "UILabel+JNHelp.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_RED;

    UITextView * text = [[UITextView alloc]initWithfram:CGRectMake(100, 100, 100, 100) placeholder:@"asdf"];
    [self.view addSubview:text];

    NSLog(@"%@",[EncryptionManager readuuid]);
}

@end
