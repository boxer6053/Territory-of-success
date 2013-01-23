#import "MSAddingCommentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSAddingCommentViewController ()

@end

@implementation MSAddingCommentViewController
@synthesize delegate, sentArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
        self.inputText.frame = CGRectMake(self.inputText.frame.origin.x, self.inputText.frame.origin.y - 20, self.inputText.frame.size.width, self.inputText.frame.size.width);
        self.containView.frame = CGRectMake(self.containView.frame.origin.x, self.containView.frame.origin.y, self.containView.frame.size.width, self.containView.frame.size.height - 88);
        self.starView.frame = CGRectMake(self.starView.frame.origin.x, self.stepper.frame.origin.y, self.starView.frame.size.width, self.starView.frame.size.height);
        self.pleaseLabel.frame = CGRectMake(self.pleaseLabel.frame.origin.x, self.stepper.frame.origin.y - 30, self.pleaseLabel.frame.size.width, self.pleaseLabel.frame.size.height);
    }
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, nil]];
    
    self.containView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
    self.containView.layer.borderWidth = 3.0f;
    self.containView.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
    
    self.inputText.returnKeyType = UIReturnKeyDone;
    self.inputText.delegate = self;
    self.inputText.layer.cornerRadius = 10;
    self.inputText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputText.layer.borderWidth = 1.0f;
    self.inputText.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
    
    self.starView.layer.cornerRadius = 10;
    [self.starView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    [self.view addGestureRecognizer:self.tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)save:(id)sender {
    sentArray = [[NSMutableArray alloc]init];
    NSString *name = @"Egor";
    NSString *comment = self.inputText.text;
    NSNumber *starsNumber = [NSNumber numberWithInt:(int)self.stepper.value];
    [sentArray addObject:name];
    [sentArray addObject:comment];
    [sentArray addObject:starsNumber];
    
    [self.delegate addNewComment:sentArray];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)starStepper:(id)sender {
    switch ((int)self.stepper.value) {
        case 1:
            self.starImage.image = [UIImage imageNamed:@"1star.png"];
            break;
        case 2:
            self.starImage.image = [UIImage imageNamed:@"2star.png"];
            break;
        case 3:
            self.starImage.image = [UIImage imageNamed:@"3star.png"];
            break;
        case 4:
            self.starImage.image = [UIImage imageNamed:@"4star.png"];
            break;
        case 5:
            self.starImage.image = [UIImage imageNamed:@"5star.png"];
            break;
    }
}

#pragma mark Text View
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if([self.inputText.text isEqualToString:@"Напишите, что Вы думаете об этом товаре..."])
    self.inputText.text = @"";
    
    self.inputText.textColor = [UIColor blackColor];
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.inputText.text isEqualToString:@""]){
        self.inputText.text = @"Напишите, что Вы думаете об этом товаре...";
        self.inputText.textColor = [UIColor lightGrayColor];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)tapPressed:(UITapGestureRecognizer *)recognizer{
    [self.inputText resignFirstResponder];
}

@end
