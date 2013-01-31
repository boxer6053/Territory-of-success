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

@interface MSProfileViewController ()

@end

@implementation MSProfileViewController

@synthesize profileTableView = _profileTableView;

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
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
        static NSString *CellIdentifier = @"saveProfileCell";
        MSSexProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
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
            }
        }
        else if (indexPath.section == 2)
        {
            if (indexPath.row == 0)
            {
                cell.standartTitleLabel.text = @"Телефон";
            }
            if (indexPath.row == 1)
            {
                cell.standartTitleLabel.text = @"Почтовый индекс";
            }
            if (indexPath.row == 2)
            {
                cell.standartTitleLabel.text = @"e-mail";
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

@end
