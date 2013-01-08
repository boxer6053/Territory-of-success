//
//  MSFirstViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/8/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSFirstViewController.h"
#import "Tesseract.h"

@interface MSFirstViewController ()

@end

@implementation MSFirstViewController

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

- (IBAction)recognize:(id)sender {
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract setImage:[UIImage imageNamed:@"numbers.png"]];
    [tesseract recognize];
    
    NSLog(@"%@", [tesseract recognizedText]);
}
@end
