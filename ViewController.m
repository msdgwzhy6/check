//
//  ViewController.m
//  Check
//
//  Created by wuxueying on 8/13/15.
//  Copyright (c) 2015 xueying wu. All rights reserved.
//

#import "ViewController.h"
#import "CheckboxControl.h"

@interface ViewController () {
    BOOL show;
}
@property (weak, nonatomic) IBOutlet CheckboxControl *checkBox;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)click:(id)sender {
    show = !show;
    if (show) {
        [_checkBox show];
    } else {
        [_checkBox hide];
    }
}

@end
