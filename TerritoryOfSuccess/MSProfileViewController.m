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
#import "MSCheckBoxCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MSProfileViewController ()
{
    BOOL _downloadIsComplete;
    BOOL _isEditMode;
}

@property (nonatomic) UIDatePicker *datePicker;
@property (nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) MSAPI *api;
@property (strong, nonatomic) NSMutableArray *profileArray;
@property (strong, nonatomic) NSMutableArray *profileStandartFields;
@property (strong, nonatomic) NSMutableArray *profileCheckboxFields;
@property (strong, nonatomic) NSDictionary *profileDictionary;
@end

@implementation MSProfileViewController

@synthesize profileTableView = _profileTableView;
@synthesize datePicker = _datePicker;
@synthesize api = _api;
@synthesize profileArray = _profileArray;
@synthesize profileStandartFields = _profileStandartFields;
@synthesize profileCheckboxFields = _profileCheckboxFields;
@synthesize profileDictionary = _profileDictionary;
@synthesize pickerView = _pickerView;

- (MSAPI *)api
{
    if(!_api)
    {
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self.api getProfileData];
    _downloadIsComplete = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        if (_isEditMode)
        {
            return self.profileStandartFields.count;
        }
        else
        {
            return self.profileArray.count;
        }
    }
    else if (section == 2)
    {
        if (_isEditMode)
        {
            return self.profileCheckboxFields.count;
        }
        else
        {
            return 0;
        }
    }
    else if (section == 3)
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

    if(_downloadIsComplete == YES)
    {
        if (indexPath.section == 0)
        {
            static NSString *CellIdentifier = @"bonusProfileCell";
            MSBonusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            cell.bonusCountLabel.text = [self.profileDictionary valueForKey:@"balance"];
            
            return cell;
        }
        if (indexPath.section == 2)
        {
            static NSString *CellIdentifier = @"checkboxCell";
            MSCheckBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            cell.checkboxLabel.text = [[self.profileCheckboxFields objectAtIndex:indexPath.row] valueForKey:@"title"];
            cell.isChecked = [[[self.profileCheckboxFields objectAtIndex:indexPath.row] valueForKey:@"value"] boolValue];
            [cell setSelection];
            
            return cell;
        }
        
        if (indexPath.section == 3)
        {
            static NSString *CellIdentifier = @"saveProfileCell";
            MSProfileSaveCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            [cell.SaveButton addTarget:self action:@selector(SaveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else
        {
            static NSString *CellIdentifier = @"standardProfileCell";
            MSStandardProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            if (_isEditMode)
            {
                cell.standartTitleLabel.text = [[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"title"];
                NSString *value = [[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"value"];
                if((NSNull *)value != [NSNull null])
                {
                    value = [self checkIfNull:value];
                }
                else
                {
                    value = @"";
                }
                cell.standartTextField.text = value;
            }
            else
            {
                cell.standartTitleLabel.text = [[self.profileArray objectAtIndex:indexPath.row] valueForKey:@"key"];
                NSString *value = [[self.profileArray objectAtIndex:indexPath.row] valueForKey:@"value"];
                if((NSNull *)value != [NSNull null])
                {
                    value = [self checkIfNull:value];
                }
                else
                {
                    value = @"";
                }
                cell.standartTextField.text = value;
            }
            
            if([[[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"select"])
            {
                UIView *basePickerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 261)];
                self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, basePickerView.frame.size.width, basePickerView.frame.size.height - 44)];
                self.pickerView.delegate = self;
                self.pickerView.dataSource = self;
                UIToolbar *PickerToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, basePickerView.frame.size.width, 44)];
                PickerToolBar.barStyle = UIBarStyleBlackTranslucent;
                UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerViewDonePressed)];
                [doneButton setTintColor:[UIColor orangeColor]];
                UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerViewCancelPressed)];
                [cancelButton setTintColor:[UIColor orangeColor]];
                UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                PickerToolBar.items = [NSArray arrayWithObjects:cancelButton, spacer, doneButton, nil];
                [basePickerView addSubview:PickerToolBar];
                [basePickerView addSubview:self.datePicker];
                cell.standartTextField.inputView = basePickerView;
            }
            
//            if (indexPath.row == 3)
//            {
//                cell.standartTitleLabel.text = @"Дата Рождения";
//                UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 261)];
//                self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, myView.frame.size.width, myView.frame.size.height - 44)];
//                self.datePicker.datePickerMode = UIDatePickerModeDate;
//                UIToolbar *datePickerToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, myView.frame.size.width, 44)];
//                datePickerToolBar.barStyle = UIBarStyleBlackTranslucent;
//                UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerViewDonePressed)];
//                [doneButton setTintColor:[UIColor orangeColor]];
//                UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerViewCancelPressed)];
//                [cancelButton setTintColor:[UIColor orangeColor]];
//                UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//                datePickerToolBar.items = [NSArray arrayWithObjects:cancelButton, spacer, doneButton, nil];
//                [myView addSubview:datePickerToolBar];
//                [myView addSubview:self.datePicker];
//                cell.standartTextField.inputView = myView;
//            }
            
            cell.standartTextField.delegate = self;
            [cell.standartTextField addTarget:self action:@selector(TextFieldStartEditing:) forControlEvents:UIControlEventEditingDidBegin];
            
            return cell;
        }
    }
    else
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
}

-(NSString *)checkIfNull:(NSString *)value
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if ([[value stringByTrimmingCharactersInSet: set] length] == 0)
    {
        value = @"";
    }
    return value;
}

-(void)SaveButtonPressed
{
    if (!_isEditMode)
    {
        if(!self.profileStandartFields || !self.profileCheckboxFields)
        {
            [self.api  getProfileDataForEdit];
            _isEditMode = YES;
        }
        else
        {
            _isEditMode = YES;
            [self.profileTableView reloadData];
        }
    }
    else
    {
        _isEditMode = NO;
        [self.profileTableView reloadData];
    }
}

-(void)pickerViewDonePressed
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:3 inSection:1];
    MSStandardProfileCell *cell = (MSStandardProfileCell *)[self.profileTableView cellForRowAtIndexPath:indexPath];
    NSDate *date = [self.datePicker date];
    //format it
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-mm-dd"];
    
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

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    self.profileDictionary = dictionary;
    if(type == kProfileInfo)
    {
        if([[dictionary valueForKey:@"status"] isEqualToString:@"ok"])
        {
            _downloadIsComplete = YES;
            self.profileArray = [[dictionary valueForKey:@"fields"] mutableCopy];
            for(int i = 0; i < self.profileArray.count; i++)
            {
                if ([[[self.profileArray objectAtIndex:i] valueForKey:@"key"] isEqualToString:@"Balance"])
                {
                    [self.profileArray removeObjectAtIndex:i];
                }
            }
            [self.profileTableView reloadData];
        }
    }
    if (type == kProfileEdit)
    {
        if([[dictionary valueForKey:@"status"] isEqualToString:@"ok"])
        {
            _downloadIsComplete = YES;
            self.profileStandartFields = [[NSMutableArray alloc]init];
            self.profileCheckboxFields = [[NSMutableArray alloc]init];
            for (int i = 0; i < [[dictionary valueForKey:@"fields"] count]; i++)
            {
                if ([[[[dictionary valueForKey:@"fields"] objectAtIndex:i] valueForKey:@"type"] isEqualToString:@"checkbox"])
                {
                    [self.profileCheckboxFields addObject:[[dictionary valueForKey:@"fields"] objectAtIndex:i]];
                }
                else
                {
                    [self.profileStandartFields addObject:[[dictionary valueForKey:@"fields"] objectAtIndex:i]];
                }
            }
            [self.profileTableView reloadData];
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"lol";
}

@end
