//
//  InfoViewController.m
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/4/22.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(10,10,250,45);
    UILabel *lblInfo = [[UILabel alloc] initWithFrame:frame];
    lblInfo.backgroundColor = [UIColor darkGrayColor];
    lblInfo.textColor = [UIColor whiteColor];
    lblInfo.text = @"Developed by Roger";
 
    [self.view addSubview:lblInfo];
}

@end
