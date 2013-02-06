//
//  MSProfileViewController.m
//  TerritoryOfSuccess
//
//  Created by Alex on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSProfileViewController.h"
#import "MSBonusCell.h"
#import "MSSexProfileCell.h"
#import "MSStandardProfileCell.h"
#import "MSReceiveProfileCell.h"
#import "MSProfileSaveCell.h"

@interface MSProfileViewController ()

@property (nonatomic) UIDatePicker *datePicker;

@end

@implementation MSProfileViewController

@synthesize profileTableView = _profileTableView;
@synthesize datePicker = _datePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4)
    {
        return 95;
    }
    else
    {
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 5;
    }
    else if (section == 2)
    {
        return 3;
    }
    else if (section == 3)
    {
        return 4;
    }
    else if (section == 4)
    {
        return 1;
    }
    else if (section == 5)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *CellIdentifier = @"bonusProfileCell";
        MSBonusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section == 1 && indexPath.row == 4)
    {
        static NSString *CellIdentifier = @"sexProfileCell";
        MSSexProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.maleSelected = YES;
        return cell;
    }
    if (indexPath.section == 4)
    {
        static NSString *CellIdentifier = @"receiveProfileCell";
        MSReceiveProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section == 5)
    {
        static NSString *CellIdentifier = @"saveProfileCell";
        MSProfileSaveCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"standardProfileCell";
        MSStandardProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                cell.standartTitleLabel.text = @"Имя";
            }
            if (indexPath.row == 1)
            {
                cell.standartTitleLabel.text = @"Фамилия";
            }
            if (indexPath.row == 2)
            {
                cell.standartTitleLabel.text = @"Отчество";
            }
            if (indexPath.row == 3)
            {
                cell.standartTitleLabel.text = @"Дата Рождения";
                UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 261)];
                self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, myView.frame.size.width, myView.frame.size.height - 44)];
                self.datePicker.datePickerMode = UIDatePickerModeDate;
                UIToolbar *datePickerToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, myView.frame.size.width, 44)];
                datePickerToolBar.barStyle = UIBarStyleBlackTranslucent;
                UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerViewDonePressed)];
                [doneButton setTintColor:[UIColor orangeColor]];
                UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerViewCancelPressed)];
                [cancelButton setTintColor:[UIColor orangeColor]];
                UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                datePickerToolBar.items = [NSArray arrayWithObjects:cancelButton, spacer, doneButton, nil];
                [myView addSubview:datePickerToolBar];
                [myView addSubview:self.datePicker];
                cell.standartTextField.inputView = myView;
            }
        }
        else if (indexPath.section == 2)
        {
            if (indexPath.row == 0)
            {
                cell.standartTitleLabel.text = @"Телефон";
                cell.standartTextField.keyboardType = UIKeyboardTypePhonePad;
            }
            if (indexPath.row == 1)
            {
                cell.standartTitleLabel.text = @"Почтовый индекс";
            }
            if (indexPath.row == 2)
            {
                cell.standartTitleLabel.text = @"e-mail";
                cell.standartTextField.keyboardType = UIKeyboardTypeEmailAddress;
            }

        }
        else if (indexPath.section == 3)
        {
            if (indexPath.row == 0)
            {
                cell.standartTitleLabel.text = @"Населенный пункт";
            }
            if (indexPath.row == 1)
            {
                cell.standartTitleLabel.text = @"Улица";
            }
            if (indexPath.row == 2)
            {
                cell.standartTitleLabel.text = @"Дом";
            }
            if (indexPath.row == 3)
            {
                cell.standartTitleLabel.text = @"Квартира";
            }
        }
        
        cell.standartTextField.delegate = self;
        [cell.standartTextField addTarget:self action:@selector(TextFieldStartEditing:) forControlEvents:UIControlEventEditingDidBegin];
        
        return cell;
    }
}

-(void)pickerViewDonePressed
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:3 inSection:1];
    MSStandardProfileCell *cell = (MSStandardProfileCell *)[self.profileTableView cellForRowAtIndexPath:indexPath];
    NSDate *date = [self.datePicker date];
    //format it
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    cell.standartTextField.text = dateString;
    [cell.standartTextField resignFirstResponder];
}

-(void)pickerViewCancelPressed
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:3 inSection:1];
    MSStandardProfileCell *cell = (MSStandardProfileCell *)[self.profileTableView cellForRowAtIndexPath:indexPath];
    [cell.standartTextField resignFirstResponder];
}

-(void)TextFieldStartEditing:(id)sender
{
    UITableViewCell *cell = (UITableViewCell*) [[sender superview] superview];
    [self.profileTableView scrollToRowAtIndexPath:[self.profileTableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)logoutButtonPressed:(id)sender
{
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    [userDefults setObject:nil forKey:@"authorization_Token"];
    [userDefults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
