#import "MSAddingCommentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSAddingCommentViewController ()

@end

@implementation MSAddingCommentViewController

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
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, nil]];
    
    self.containView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
    self.containView.layer.borderWidth = 3.0f;
    
    self.inputText.returnKeyType = UIReturnKeyDone;
    self.inputText.delegate = self;
    self.inputText.layer.cornerRadius = 10;
    self.inputText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputText.layer.borderWidth = 1.0f;
    
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
