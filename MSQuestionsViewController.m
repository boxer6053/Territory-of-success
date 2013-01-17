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
    
    self.allQuestionsMode = YES;
    self.myQuestionsMode = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_image.png"]]];

    
    self.tableOfAnswers.layer.cornerRadius = 10;
    [self.tableOfAnswers.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.tableOfAnswers.layer setBorderWidth:1.0f];
    [self.tableOfAnswers.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
    
    self.tableView.layer.cornerRadius = 10;
    [self.tableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.tableView.layer setBorderWidth:1.0f];
    [self.tableView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
    
    
    [self createAllArray];
    [self createMyArray];
 
    [super viewDidLoad];
    
    // [newDictionary setObject:@"You" forKey:@"title"];
    //
    NSArray *questionTitles = [[NSArray alloc] initWithObjects:@"World", @"Name", @"You", nil];
    NSArray *questionsDetails = [[NSArray alloc] initWithObjects:@"What is the world?", @"What is your name", @"who are you?", nil];
    
    for(int i=0;i<questionsDetails.count;i++)
    {
        self.questionsDictionary = [[NSDictionary alloc] initWithObjects:questionsDetails forKeys:questionTitles];
        ////
       
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
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"AllQuestion1",@"AllQuestion2", nil];
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
     
    if(tableView ==_tableView){
    if(self.myQuestionsMode)
    {
       
        return self.questionsDictionary.count;
    }
    else{
        return myArray.count;
    }
        
    }
else{
    return 5;
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
    if(tableView == _tableView)
    {
    if(self.myQuestionsMode){
        int index = [indexPath indexAtPosition:1];
        NSString *key = [[self.questionsDictionary allKeys] objectAtIndex:index];
        
        self.questionTitle = key;
        self.questionDescription = [self.questionsDictionary objectForKey:key];
        
        self.questionDetailDescriptionLabel.text = [self.questionsDictionary objectForKey:key];
        self.questionDetailTitleLabel.text = key;
      
    }
    if(self.allQuestionsMode)
    {
        
        self.questionTitle = [allArray objectAtIndex:indexPath.row];
           
        self.questionDetailTitleLabel.text = [allArray objectAtIndex:indexPath.row];

        self.questionDetailDescriptionLabel.text = @"description of the 'all question'";
    }
    //UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        [UIView animateWithDuration:0.5 animations:^{
            self.segment.frame = CGRectMake(-340, self.segment.frame.origin.y, self.segment.frame.size.width,self.segment.frame.size.height);
            self.tableView.frame = CGRectMake(-310, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
            self.tableOfAnswers.frame = CGRectMake(22, self.tableOfAnswers.frame.origin.y, self.tableOfAnswers.frame.size.width, self.tableOfAnswers.frame.size.height);
            self.questionDetailTitleLabel.frame = CGRectMake(122, self.questionDetailTitleLabel.frame.origin.y, self.questionDetailTitleLabel.frame.size.width, self.questionDetailTitleLabel.frame.size.height);
            self.questionDetailDescriptionLabel.frame = CGRectMake(20, self.questionDetailDescriptionLabel.frame.origin.y, self.questionDetailDescriptionLabel.frame.size.width, self.questionDetailDescriptionLabel.frame.size.height);
            self.backButton.frame = CGRectMake(0, self.backButton.frame.origin.y, self.backButton.frame.size.width, self.backButton.frame.size.height);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.backButton.alpha = 1.0;
            }];
        }];
//  
//    [self performSegueWithIdentifier:@"toQuestionDetail" sender:self];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"toQuestionDetail"]){
//            MSQuestionDetailViewController *controller = (MSQuestionDetailViewController *)segue.destinationViewController;
//        if(myQuestionsMode){
//
//        controller.data = self.questionsDictionary;
//        controller.questionDescription = self.questionDescription;
//        controller.questionTitle = self.questionTitle;
//        }
//        if(allQuestionsMode)
//        {
//            controller.questionDescription = @"All question description";
//            controller.questionTitle = @" All question title";
//        }
//            
//    }
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

- (IBAction)backToQuestionTable:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.backButton.alpha = 0.0;
    } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.5 animations:^{
        self.segment.frame = CGRectMake(-6, self.segment.frame.origin.y, self.segment.frame.size.width,self.segment.frame.size.height);
        self.tableView.frame = CGRectMake(20, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
        self.tableOfAnswers.frame = CGRectMake(22+320, self.tableOfAnswers.frame.origin.y, self.tableOfAnswers.frame.size.width, self.tableOfAnswers.frame.size.height);
        self.questionDetailTitleLabel.frame = CGRectMake(122+320, self.questionDetailTitleLabel.frame.origin.y, self.questionDetailTitleLabel.frame.size.width, self.questionDetailTitleLabel.frame.size.height);
        self.questionDetailDescriptionLabel.frame = CGRectMake(20+320, self.questionDetailDescriptionLabel.frame.origin.y, self.questionDetailDescriptionLabel.frame.size.width, self.questionDetailDescriptionLabel.frame.size.height);
        self.backButton.frame = CGRectMake(0+320, self.backButton.frame.origin.y, self.backButton.frame.size.width, self.backButton.frame.size.height);
    }];
  }];
}
@end
