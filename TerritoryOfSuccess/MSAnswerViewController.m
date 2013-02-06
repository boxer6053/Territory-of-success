//
//  MSAnswerViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/6/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSAnswerViewController.h"

@interface MSAnswerViewController ()

@end

@implementation MSAnswerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)answerButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
