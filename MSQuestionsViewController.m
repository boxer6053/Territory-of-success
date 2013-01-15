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
    NSLog(@"objects%@", myArray);
    [super viewDidLoad];
    
    // [newDictionary setObject:@"You" forKey:@"title"];
    //
    NSArray *questionTitles = [[NSArray alloc] initWithObjects:@"World", @"Name", @"You", nil];
    NSArray *questionsDetails = [[NSArray alloc] initWithObjects:@"What is the world?", @"What is your name", @"who are you?", nil];
    
    for(int i=0;i<questionsDetails.count;i++)
    {
        self.questionsDictionary = [[NSDictionary alloc] initWithObjects:questionsDetails forKeys:questionTitles];
        ////
        NSLog(@"titles %@", [questionTitles objectAtIndex:i]);
        NSLog(@"objects %@", [questionsDetails objectAtIndex:i]);
        //
        [self.testDictionary setObject:[questionTitles objectAtIndex:i] forKey:@"Titles"];
        [self.testDictionary setObject:[questionsDetails objectAtIndex:i] forKey:@"Description"];
        
        //
        //      //  [newDictionary setObject:@"World" forKey:@"Titles"];
        //      //  NSLog(@"newDictionary titles %@", [self.questionsDictionary objectForKey:@"Titles"]);
    }
    //     self.questionsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"FirstObject111",@"first",@"SecondObject222",@"second",@"ThirdObject333",@"third", nil];
    
    //    self.testDictionary = [NSDictionary dictionaryWithObject:questionsDetails forKey:questionTitles];
    for (id key in [self.questionsDictionary allKeys])
    {
        NSLog(@"Key : %@ => value : %@", key, [self.questionsDictionary objectForKey:key]);
        NSLog(@"Number %u", self.questionsDictionary.count);
        NSArray *array = [[NSMutableArray alloc] init];
        array = [self.questionsDictionary allKeys];
        NSLog(@"ArrYA %@", array);
        
        
        
        
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    UIColor *selectedColor=[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0.0/255.0 alpha:1.0];
    [[self.segment.subviews objectAtIndex:1] setTintColor:selectedColor];
    [[self.segment.subviews objectAtIndex:0] setTintColor:[UIColor blackColor]];
    
    
}

-(void)createMyArray
{
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"MyQuestion1",@"MyQuestion2", nil];
    myArray = dataArray;
}

-(void)createAllArray
{
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"AllQuestion1",@"AllQuestion2", nil];
    allArray = dataArray;
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
        //cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
//        cell.textLabel.text = @"Название категории";
//        cell.detailTextLabel.text = @"Описание";

//    
//    static NSString *CellIdentifier = @"QuestionCellIdentifier";
//    MSQuestionCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    //    if (cell1 == nil) {
//    //        cell1 = [[MSQuestionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    //    }
//    if(!cell1)
//    {
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MSQuestionCell" owner:nil options:nil];
//        for(id currentObject in topLevelObjects)
//        {
//            if([currentObject isKindOfClass:[MSQuestionCell class]])
//            {
//                cell1 = (MSQuestionCell *)currentObject;
//                break;
//            }
//        }
//    }
//    
//    //
//    //         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    //         if (cell == nil) {
//    //             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    //         }
    if(self.myQuestionsMode)
    {
        int index = [indexPath indexAtPosition:1];
        NSString *key = [[self.questionsDictionary allKeys] objectAtIndex:index];
       // NSString *value = [self.questionsDictionary objectForKey:key];
        cell.textLabel.text =key;
        cell.detailTextLabel.text = @"grade";
        //        for(int i=0;i<self.questionsDictionary.count;i++)
        //        {
        //    cell.textLabel.text = [myArray objectAtIndex:indexPath.row]  ;
        //        }
    }
    if(self.allQuestionsMode)
    {
        cell.textLabel.text = [allArray objectAtIndex:indexPath.row]  ;
        cell.detailTextLabel.text = @"grade";
    }
    
   
    
    }
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.myQuestionsMode){
        int index = [indexPath indexAtPosition:1];
        NSString *key = [[self.questionsDictionary allKeys] objectAtIndex:index];
        NSString *value = [self.questionsDictionary objectForKey:key];
        self.questionTitle = key;
        self.questionDescription = [self.questionsDictionary objectForKey:key];
        NSLog(@"Pressed value %@", value);
        NSLog(@"Pressed index %d", index);
        NSLog(@"Pressed key %@", key);
    }
    if(self.allQuestionsMode)
    {
        
        self.questionTitle = [allArray objectAtIndex:indexPath.row];
        NSLog(@"You just pressed %@",[allArray objectAtIndex:indexPath.row] );
    }
    
    [self performSegueWithIdentifier:@"toQuestionDetail" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toQuestionDetail"]){
        MSQuestionDetailViewController *controller = (MSQuestionDetailViewController *)segue.destinationViewController;
        controller.data = self.questionsDictionary;
        controller.questionDescription = self.questionDescription;
        controller.questionTitle = self.questionTitle;
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
        
        NSLog(@"All MODE");
    }
    if(selectedSegment ==1)
    {
        self.myQuestionsMode = YES;
        self.allQuestionsMode = NO;
        [self.tableView reloadData];
        NSInteger inte =    [self.questionsDictionary count];
        NSLog(@"zz %d", inte);
        NSLog(@"My Mode");
    }
}

@end
