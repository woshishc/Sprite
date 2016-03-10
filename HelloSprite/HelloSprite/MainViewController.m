//
//  MainViewController.m
//  HelloSprite
//
//  Created by suhc on 15/12/18.
//  Copyright © 2015年 kongjianjia. All rights reserved.
//

#import "MainViewController.h"
#import "HelloScene.h"

@interface MainViewController ()
{
    SKView *spriteView;
}

@end

@implementation MainViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    spriteView = (SKView *)self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    HelloScene *hello = [[HelloScene alloc] initWithSize:spriteView.bounds.size];
    [spriteView presentScene:hello];
}

#pragma mark - Other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
