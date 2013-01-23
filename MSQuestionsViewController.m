#import "MSQuestionsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSQuestionsViewController ()

@end

@implementation MSQuestionsViewController

@synthesize tableView = _tableView;
@synthesize myQuestionsMode;
@synthesize allQuestionsMode;
@synthesize segment;



@synthesize testDictionary = _testDictionary;
@synthesize questionsDictionary = _questionsDictionary;
@synthesize questionTitle = _questionTitle;
@synthesize questionDescription = _questionDescription;



- (void)viewDidLoad
{
 

    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
    }
    [self.segment setTintColor:[UIColor blackColor]];
    self.allQuestionsMode = YES;
    self.myQuestionsMode = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.cornerRadius = 10;
    [self.tableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.tableView.layer setBorderWidth:1.0f];
    [self.tableView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
    
    
    [self createAllArray];
    [self createMyArray];
    
    [super viewDidLoad];
       NSArray *questionTitles = [[NSArray alloc] initWithObjects:@"Вопрос 1", @"Вопрос 2", @"Вопрос 3", nil];
    NSArray *questionsDetails = [[NSArray alloc] initWithObjects:@"Описание вопроса 1", @"Описание вопроса 2", @"Описание вопроса 3", nil];
    
    
    for(int i=0;i<questionsDetails.count;i++)
    {
        self.questionsDictionary = [[NSDictionary alloc] initWithObjects:questionsDetails forKeys:questionTitles];
              [self.testDictionary setObject:[questionTitles objectAtIndex:i] forKey:@"Titles"];
        [self.testDictionary setObject:[questionsDetails objectAtIndex:i] forKey:@"Description"];
          }    for (id key in [self.questionsDictionary allKeys])
    {
        
        NSArray *array = [[NSMutableArray alloc] init];
        array = [self.questionsDictionary allKeys];
        
        
        
        
        
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    if(allQuestionsMode){
        UIColor *selectedColor=[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0.0/255.0 alpha:1.0];
        [[self.segment.subviews objectAtIndex:1] setTintColor:selectedColor];
        [[self.segment.subviews objectAtIndex:0] setTintColor:[UIColor blackColor]];
    }
    if(myQuestionsMode)
    {
        UIColor *selectedColor=[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0.0/255.0 alpha:1.0];
        [[self.segment.subviews objectAtIndex:0] setTintColor:selectedColor];
        [[self.segment.subviews objectAtIndex:1] setTintColor:[UIColor blackColor]];
        }
    
    
}

-(void)createMyArray
{
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"MyQuestion1",@"MyQuestion2", nil];
    myArray = dataArray;
}

-(void)createAllArray
{
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"Обший вопрос 1",@"Общий вопрос 2", nil];
    allArray = dataArray;
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _tableView){
        return 1;
    }
    else{
        return 5;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if(self.myQuestionsMode)
    {
        
        return self.questionsDictionary.count;
    }
    else{
        return myArray.count;
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == _tableView)
    {
        static NSString* cellIdentifier = @"cellID";
        cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
    
        if(self.myQuestionsMode)
        {
            int index = [indexPath indexAtPosition:1];
            NSString *key = [[self.questionsDictionary allKeys] objectAtIndex:index];
            cell.textLabel.text =key;
            cell.detailTextLabel.text = @"Оценка";
        }
        if(self.allQuestionsMode)
        {
            cell.textLabel.text = [allArray objectAtIndex:indexPath.row]  ;
            cell.detailTextLabel.text = @"Оценка";
        }
        
        
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tableView)
    {
        if(self.myQuestionsMode){
            int index = [indexPath indexAtPosition:1];
            NSString *key = [[self.questionsDictionary allKeys] objectAtIndex:index];
            
            self.questionTitle = key;
            self.questionDescription = [self.questionsDictionary objectForKey:key];
            
        }
        if(self.allQuestionsMode)
        {
            
            self.questionTitle = [allArray objectAtIndex:indexPath.row];
            
            
        }
        [self performSegueWithIdentifier:@"toQuestionDetail" sender:self];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toQuestionDetail"]){
        MSQuestionDetailViewController *controller = (MSQuestionDetailViewController *)segue.destinationViewController;
        if(myQuestionsMode){
            
            controller.data = self.questionsDictionary;
            controller.questionDescription = self.questionDescription;
            controller.questionTitle = self.questionTitle;
        }
        if(allQuestionsMode)
        {
            controller.questionDescription = @"Описание общего вопроса";
            //controller.questionTitle = @"Общий вопрос";
            controller.questionTitle = self.questionTitle;
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)questionDoubleButton:(id)sender {
    
    NSInteger selectedSegment = self.segment.selectedSegmentIndex;
    
    for (int i=0; i<[self.segment.subviews count]; i++)
    {
        if ([[self.segment.subviews objectAtIndex:i]isSelected] )
        {
            UIColor *tintcolor=[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0.0/255.0 alpha:1.0];
            [[self.segment.subviews objectAtIndex:i] setTintColor:tintcolor];
        }
        else {
            UIColor *tintcolor=[UIColor blackColor]; // default color
            [[self.segment.subviews objectAtIndex:i] setTintColor:tintcolor];
        }
    }
    
    
    if(selectedSegment ==0)
    {
        self.allQuestionsMode = YES;
        self.myQuestionsMode = NO;
        [self.tableView reloadData];
        
        
    }
    if(selectedSegment ==1)
    {
        self.myQuestionsMode = YES;
        self.allQuestionsMode = NO;
        [self.tableView reloadData];
        
    }
}

@end
