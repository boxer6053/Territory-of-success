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
#import "MSPickerView.h"
#import "MSEditButtonsCell.h"
#import "MSBonusCatalogViewController.h"
#import "PrettyKit.h"
#import <QuartzCore/QuartzCore.h>

@interface MSProfileViewController ()
{
    BOOL _downloadIsComplete;
    BOOL _isEditMode;
}

@property (nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) MSAPI *api;
@property (strong, nonatomic) NSMutableArray *profileArray;
@property (strong, nonatomic) NSMutableArray *profileStandartFields;
@property (strong, nonatomic) NSMutableArray *profileCheckboxFields;
@property (strong, nonatomic) NSDictionary *profileDictionary;

@property (strong, nonatomic) NSArray *catalogList;

@end

@implementation MSProfileViewController

@synthesize profileTableView = _profileTableView;
@synthesize datePicker = _datePicker;
@synthesize api = _api;
@synthesize profileArray = _profileArray;
@synthesize profileStandartFields = _profileStandartFields;
@synthesize profileCheckboxFields = _profileCheckboxFields;
@synthesize profileDictionary = _profileDictionary;
@synthesize catalogList = _catalogList;

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
        if (_downloadIsComplete)
        {
            return 1;
        }
        else
        {
            return 0;
        }
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
        if (_downloadIsComplete)
        {
            return 1;
        }
        else
        {
            return 0;
        }
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
            NSString *CellIdentifier = @"bonusProfileCell";
            MSBonusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            [cell.bonusButton addTarget:self action:@selector(bonusButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            cell.bonusCountLabel.text = [self.profileDictionary valueForKey:@"balance"];
            
            return cell;
        }
        if (indexPath.section == 2)
        {
            NSString *CellIdentifier = @"checkboxCell";
            MSCheckBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            cell.checkboxLabel.text = [[self.profileCheckboxFields objectAtIndex:indexPath.row] valueForKey:@"title"];
            cell.isChecked = [[[self.profileCheckboxFields objectAtIndex:indexPath.row] valueForKey:@"value"] boolValue];
            [cell setSelection];
            [cell.checkboxButton addTarget:self action:@selector(checkboxPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
        
        if (indexPath.section == 3)
        {
            if(!_isEditMode)
            {
                NSString *CellIdentifier = @"saveProfileCell";
                MSProfileSaveCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                [cell.SaveButton addTarget:self action:@selector(SaveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            else
            {
                NSString *CellIdentifier = @"editButtonsCell";
                MSEditButtonsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                [cell.cancelButton addTarget:self action:@selector(dismissChanges) forControlEvents:UIControlEventTouchUpInside];
                [cell.saveButton addTarget:self action:@selector(saveChanges) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
        }
        else
        {
            NSString *CellIdentifier = @"standardProfileCell";
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
                
                if([[[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"select"])
                {
                    MSPickerView *picker = [[MSPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 261)];
                    picker.delegate = self;
                    picker.target = cell.standartTextField;
                    picker.dataSource = [[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"values"];
                    cell.standartTextField.inputView = picker;
                }
                
                if([[[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:@"birthday"])
                {
                    MSDatePickerView *picker = [[MSDatePickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 261)];
                    picker.delegate = self;
                    picker.target = cell.standartTextField;
                    cell.standartTextField.inputView = picker;
                }
                cell.standartTextField.enabled = YES;
            }
            else
            {
                cell.standartTitleLabel.text = [[self.profileArray objectAtIndex:indexPath.row] valueForKey:@"title"];
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
                cell.standartTextField.enabled = NO;
            }
            
            cell.standartTextField.delegate = self;
            [cell.standartTextField addTarget:self action:@selector(TextFieldStartEditing:) forControlEvents:UIControlEventEditingDidBegin];
            
            return cell;
        }
    }
    else
    {
        NSString *CellIdentifier = @"Cell";
        
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
#pragma mark - selectors
-(void)SaveButtonPressed
{
    if (!_isEditMode)
    {
        [self.api  getProfileDataForEdit];
        _downloadIsComplete = NO;
        _isEditMode = YES;
        [self.profileTableView reloadData];
    }
    else
    {
        _isEditMode = NO;
        [self.profileTableView reloadData];
    }
}

-(void)saveChanges
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.profileStandartFields];
    [array addObjectsFromArray:self.profileCheckboxFields];
    NSMutableString *profileSaveString = [[NSMutableString alloc] init];
    for (int i = 0; i < array.count; i++)
    {
        [profileSaveString appendFormat:@"&%@=%@", [[array objectAtIndex:i] valueForKey:@"key"], [[array objectAtIndex:i] valueForKey:@"value"]];
    }
    [self.api sendProfileChanges:profileSaveString];
}

-(void)dismissChanges
{
    [self.api getProfileData];
    _isEditMode = NO;
}

-(void)checkboxPressed:(id)sender
{
    MSCheckBoxCell *cell = (MSCheckBoxCell *) [[sender superview] superview];
    NSIndexPath *indexPath = [[NSIndexPath alloc]init];
    indexPath = [self.profileTableView indexPathForCell:cell];
    [self changeValueAtIndexPath:indexPath with:cell.isChecked ? @"1" : @"0"];
}

-(void)bonusButtonPressed
{
    [self.api getBonusCategories];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toBonusCatalog"])
    {
        [segue.destinationViewController setCategoriesList:self.catalogList];
    }
}

#pragma mark - UITextField Delegate
-(void)TextFieldStartEditing:(id)sender
{
    UITableViewCell *cell = (UITableViewCell*) [[sender superview] superview];
    [self.profileTableView scrollToRowAtIndexPath:[self.profileTableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    MSStandardProfileCell *cell = (MSStandardProfileCell *)textField.superview.superview;
    NSIndexPath *indexPath = [[NSIndexPath alloc]init];
    indexPath = [self.profileTableView indexPathForCell:cell];
    if([[[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"select"])
    {
        for(id obj in [[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"values"])
        {
            if ([[obj valueForKey:@"value"] isEqualToString:textField.text])
            {
                [self changeValueAtIndexPath:indexPath with:[obj valueForKey:@"key"]];
            }
        }
    }
    else
    {
        [self changeValueAtIndexPath:indexPath with:textField.text];
    }
}

-(void)changeValueAtIndexPath:(NSIndexPath *)indexPath with:(NSString*)value
{
    NSArray *objArray;
    NSArray *keyArray;
    if(indexPath.section == 1)
    {
        if([[[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"select"])
        {
            objArray = [[NSArray alloc]initWithObjects:[[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"key"], value, [[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"title"], [[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"type"],[[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"values"],nil];
            keyArray = [[NSArray alloc]initWithObjects:@"key", @"value", @"title", @"type",@"values",nil];
        }
        else
        {
            objArray = [[NSArray alloc]initWithObjects:[[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"key"], value, [[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"title"], [[self.profileStandartFields objectAtIndex:indexPath.row] valueForKey:@"type"],nil];
            keyArray = [[NSArray alloc]initWithObjects:@"key", @"value", @"title", @"type",nil];
        }
        NSDictionary *resultDict = [[NSDictionary alloc]initWithObjects:objArray forKeys:keyArray];
        [self.profileStandartFields replaceObjectAtIndex:indexPath.row withObject:resultDict];
    }
    else if (indexPath.section == 2)
    {
        objArray = [[NSArray alloc]initWithObjects:[[self.profileCheckboxFields objectAtIndex:indexPath.row] valueForKey:@"key"], value, [[self.profileCheckboxFields objectAtIndex:indexPath.row] valueForKey:@"title"], [[self.profileCheckboxFields objectAtIndex:indexPath.row] valueForKey:@"type"],nil];
        keyArray = [[NSArray alloc]initWithObjects:@"key", @"value", @"title", @"type",nil];
        NSDictionary *resultDict = [[NSDictionary alloc]initWithObjects:objArray forKeys:keyArray];
        [self.profileCheckboxFields replaceObjectAtIndex:indexPath.row withObject:resultDict];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)logoutButtonPressed:(id)sender
{
    [self logout];
}

-(void)logout
{
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    [userDefults setObject:nil forKey:@"authorization_Token"];
    [userDefults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    self.profileDictionary = dictionary;
    if([[dictionary valueForKey:@"status"] isEqualToString:@"failed"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[dictionary valueForKey:@"message"] valueForKey:@"title"] message:[[dictionary valueForKey:@"message"] valueForKey:@"text"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = 1;
         [alert show];
    }
    if(type == kProfileInfo)
    {
        if([[dictionary valueForKey:@"status"] isEqualToString:@"ok"])
        {
            _downloadIsComplete = YES;
            self.profileArray = [[dictionary valueForKey:@"fields"] mutableCopy];
            for(int i = 0; i < self.profileArray.count; i++)
            {
                if ([[[self.profileArray objectAtIndex:i] valueForKey:@"key"] isEqualToString:@"balance"])
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
    if (type == kProfileChange)
    {
        if([[dictionary valueForKey:@"status"] isEqualToString:@"ok"])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[dictionary valueForKey:@"message"] valueForKey:@"title" ] message:[[dictionary valueForKey:@"message"] valueForKey:@"text"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    if (type == kBonusCategories)
    {
        if([[dictionary valueForKey:@"status"] isEqualToString:@"ok"])
        {
            self.catalogList = [dictionary valueForKey:@"list"];
            [self performSegueWithIdentifier:@"toBonusCatalog" sender:self];
        }
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0 && alertView.tag == 1)
        [self logout];
}

#pragma mark - MSPickerViewDelegate
-(void)msPickerViewDoneButtonPressed:(MSPickerView *)pickerView
{
    pickerView.target.text = [pickerView.selectedItem valueForKey:@"value"];
    [pickerView.target resignFirstResponder];
}

-(void)msPickerViewCancelButtonPressed:(MSPickerView *)pickerView
{
    [pickerView.target resignFirstResponder];
}

#pragma mark - MSDatePickeViewDelegate
-(void)msDatePickerViewCancelButtonPressed:(MSDatePickerView *)pickerView
{
    [pickerView.target resignFirstResponder];
}

-(void)msDatePickerViewDoneButtonPressed:(MSDatePickerView *)pickerView
{
    pickerView.target.text = pickerView.selectedDate;
    [pickerView.target resignFirstResponder];
}

@end
