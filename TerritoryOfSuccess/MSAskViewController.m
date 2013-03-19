//
//  MSAskViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSAskViewController.h"
#import "SVProgressHUD.h"
#import "MSQuestionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import "PrettyKit.h"
#import "MSAnimationView.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



@interface MSAskViewController ()
@property (strong, nonatomic) NSArray *questionsArray;
@property CGRect addingViewFrame;

@property int questionsCount;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;
@property BOOL thisIsProducts;
@property UIButton *headerButton;


@end

@implementation MSAskViewController
@synthesize addingViewFrame = _addingViewFrame;
@synthesize addingView = _addingView;
@synthesize headerButton = _headerButton;
@synthesize tableOfCategories = _tableOfCategories;
@synthesize questionsArray = _questionsArray;
@synthesize questionsCount = _questionsCount;
@synthesize receivedData = _receivedData;
@synthesize api = _api;
@synthesize defaultID = _defaultID;
@synthesize finalID = _finalID;
@synthesize translatingValue;
@synthesize upButtonShows;
@synthesize upButton = _upButton;
@synthesize sendingTitle = _sendingTitle;
@synthesize translatingUrl = _translatingUrl;
@synthesize upperID = _upperID;
@synthesize requestItemsString = _requestItemsString;
@synthesize isAuthorized = _isAuthorized;
@synthesize delegate = _delegate;
@synthesize backButton = _backButton;
@synthesize backIds = _backIds;
@synthesize upperTitle = _upperTitle;
@synthesize backTitles = _backTitles;
@synthesize gottedFromPrevious = _gottedFromPrevious;
@synthesize thisIsProducts = _thisIsProducts;
@synthesize navigationBar = _navigationBar;


- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

- (void)viewDidLoad
{
    self.tableOfCategories.tableHeaderView = nil;
    self.headerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.tableOfCategories.frame.size.width, 30)];
    [self.headerButton setTitle:NSLocalizedString(@"AddProductKey",nil) forState:UIControlStateNormal];
    self.headerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    [self.headerButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4] forState:UIControlStateNormal];
    [self.headerButton addTarget:self action:@selector(pictureMyProduct) forControlEvents:UIControlEventTouchDown];
    self.thisIsProducts = NO;
    [self customizeNavBar];
    if(!self.upperTitle){
    self.upperTitle = @"";
    }
    [self.navigationBar.topItem setTitle:self.upperTitle];
    //self.title = @"Pick a product";
    [self.backButton setEnabled:NO];
    self.backIds = [[NSMutableArray alloc] init];
    self.backTitles = [[NSMutableArray alloc] init];
    NSLog(@"ASK VIEW CONTROLLER");
    //[self.navigBar setTitle:NSLocalizedString(@"PickAProductKey",nil)];
    [_tableOfCategories setShowsVerticalScrollIndicator:NO];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    NSLog(@"upper %d", self.upperID);
    NSLog(@"ask %d", self.defaultID);
    self.upButtonShows = NO;
    [super viewDidLoad];
    _tableOfCategories.delegate = self;
    _tableOfCategories.dataSource = self;
    self.requestItemsString = [[NSMutableString alloc] initWithString:@""];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    
    
    if(!self.defaultID){
        [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadingInquirerListKey",nil)];
    [self.api getQuestionsWithParentID:0];
    }
    else
    {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadingInquirerListKey",nil)];
        [self.api getQuestionsWithParentID:self.defaultID];
    }
    NSLog(@"NEWWWW");
    
    }
-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSQuestionCell *cell;
    static NSString* cellIdentifier = @"questCellID";
    cell = [_tableOfCategories dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MSQuestionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.productImage.layer.cornerRadius = 5.0f;
    cell.productImage.clipsToBounds = YES;
    if([[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"] isEqualToString:@""])
    {
        cell.productImage.image = [UIImage imageNamed:@"bag.png"];
    }
    else
    {
        [cell.productImage setImage:[UIImage imageNamed:@"bag.png"]];
        [cell.productImage setImageWithURL:[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"] placeholderImage:[UIImage imageNamed:@"placeholder_415*415.png"]];
    }
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
        cell.nameLabel.minimumFontSize = 10.0f;
        cell.nameLabel.adjustsFontSizeToFitWidth = YES;
    }else{
        cell.nameLabel.minimumScaleFactor = 0.8;
        cell.nameLabel.adjustsFontSizeToFitWidth = YES;
    }

    cell.nameLabel.text = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    
        if([[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"] isEqualToString:@""])
            
        {
    NSString *countValue = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"cnt"];
    cell.countLabel.text = [@"available :" stringByAppendingString:countValue];
    }
        else{
            [cell.countLabel setText:@"available!"];
        }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.backButton setEnabled:YES];
    self.upButtonShows = YES;
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    self.translatingValue = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    
    if([[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"cnt"] integerValue] != 0)
    {
       // NSInteger currentSubCategory = [[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
        
        self.upperTitle = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
        [self.backTitles addObject:self.upperTitle];
        [self.backIds addObject:[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"]];
        _questionsCount = 0;
        [_tableOfCategories reloadData];
        [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadingInquirerListKey",nil)];
        [self.api getQuestionsWithParentID:[[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue]];
        _upperID = [[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
      
    }
    else
    {
        if(self.defaultID)
        {self.upperID = self.defaultID;
        }
        if([[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"] isEqualToString:@""])
        {
            UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No picture or not enough data =(" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [failmessage show];
        }
        else
        {
            _translatingUrl = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"];
            _sendingTitle = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
            self.finalID = self.defaultID;
                        [self.delegate setUpperId:self.upperID];
            if([[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"]){
                [self.delegate saveTitleView:self.upperTitle];
                [self.delegate addProduct:[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] withURL:[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"]];}
                      [self dismissViewControllerAnimated:YES completion:nil];
           
        
        }
        
    }
    [self.navigationBar.topItem setTitle:self.upperTitle];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)typefinished
{
    
    if(typefinished == kQuestCateg)
    {
        NSLog(@"zzzzzzz %u", _questionsCount);
        NSMutableArray *products = [[NSMutableArray alloc] init];
        _questionsArray = [dictionary valueForKey:@"list"];
        for(int i =1;i<_questionsArray.count;i++){
            if([[[_questionsArray objectAtIndex:i] valueForKey:@"cnt"] integerValue] == 0){
                if(![[[_questionsArray objectAtIndex:i] valueForKey:@"image"] isEqualToString:@""]){
                    [products addObject:[_questionsArray objectAtIndex:i]];
                }
            }
        
        }
    if(products.count != 0){
        NSLog(@"THis is products");
        self.thisIsProducts  = YES;
        self.tableOfCategories.tableHeaderView = self.headerButton;
    }
        [_tableOfCategories reloadData];
        
        //  _questionsCount = 0;
    }
   //  [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"DownloadIsCompletedKey",nil)];
}

- (IBAction)cancel:(id)sender {
    if(!self.gottedFromPrevious){
        
        [self.delegate setUpperId:0];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (IBAction)upAction:(id)sender {
//    _questionsCount = 0;
//    [_tableOfCategories reloadData];
//    [self.api getQuestionsWithParentID:0];
//    [_upButton setEnabled:NO];
//}
- (IBAction)backButtonPressed:(id)sender {
    [self.backIds removeLastObject];
    [self.backTitles removeLastObject];
    NSLog(@"Last object %@", [self.backTitles lastObject]);
    if(self.backTitles.count !=0){
        [self.navigationBar.topItem setTitle:[self.backTitles lastObject]];
        
    }
    else{
        [self.navigationBar.topItem setTitle:@""];
    }
    if(self.backIds.count != 0){

    NSInteger lastId = [[self.backIds objectAtIndex:(self.backIds.count-1)] integerValue];

    
    
    [self.api getQuestionsWithParentID:lastId];
        //[self.tableOfCategories reloadData];
    }
    else{
        [self.api getQuestionsWithParentID:0];
        [self.backButton setEnabled:NO];
    }
}
-(void)pictureMyProduct
{
    NSLog(@"Gonna pic");
            //перевірка наявності камири в девайсі
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //якщо є
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        [imagePickerController setDelegate:self];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setAllowsEditing:YES];
        
        [self presentModalViewController:imagePickerController animated:YES];
    }
    else
    {
        //якщо нема
        UIAlertView *cameraNotAvailableMessage = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Ошибка камеры",nil) message:NSLocalizedString(@"Камера не доступна",nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [cameraNotAvailableMessage show];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *editedProductImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSLog(@"Picture width: %f", editedProductImage.size.width);
    NSLog(@"Picture hight: %f", editedProductImage.size.height);
    
    CGSize sizeToScale;
    sizeToScale.width = 320.0;
    sizeToScale.height = 320.0;
    
    //зміна розміру фото
    editedProductImage = [self scalingImage:editedProductImage toSize:sizeToScale];
    
    NSLog(@"Picture width: %f", editedProductImage.size.width);
    NSLog(@"Picture hight: %f", editedProductImage.size.height);
    
    //стискання фото
    NSData *data = UIImageJPEGRepresentation(editedProductImage, 0.5);
    UIImage *compressedImage = [UIImage imageWithData:data];
    
    [picker dismissModalViewControllerAnimated:YES];
    self.addingView = [[MSAddingProductView alloc] initWithOrigin:CGPointMake(25, self.view.frame.size.height/2 - 120)];
    [self.addingView.productImageView setImage:compressedImage];
    self.addingView.categoryID = self.upperID;
    self.addingView.sendingImage = compressedImage;
    

    [self.view addSubview:self.addingView];
    
    [self.addingView attachPopUpAnimationForView:self.addingView.contentView];


}
-(void)dismissPopView:(BOOL)loginResult{
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

static inline double radians (double degrees) {return degrees * M_PI/180;}

//зміна розміру фото
- (UIImage *)scalingImage:(UIImage *)image toSize:(CGSize)targetSize
{
    CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
    
    CGImageRef imageRef = [image CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone)
    {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (image.imageOrientation == UIImageOrientationUp || image.imageOrientation == UIImageOrientationDown)
    {
		bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
	}
    else
    {
		bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
	}
    
    if (image.imageOrientation == UIImageOrientationLeft) {
		CGContextRotateCTM (bitmap, radians(90));
		CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
	} else if (image.imageOrientation == UIImageOrientationRight) {
		CGContextRotateCTM (bitmap, radians(-90));
		CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
	} else if (image.imageOrientation == UIImageOrientationUp) {
		// NOTHING
	} else if (image.imageOrientation == UIImageOrientationDown) {
		CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
		CGContextRotateCTM (bitmap, radians(-180.));
	}
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *newImage = [UIImage imageWithCGImage:ref];
    
	CGContextRelease(bitmap);
	CGImageRelease(ref);
    
	return newImage;
    
}

- (void)customizeNavBar {
    
    PrettyNavigationBar *navBar = (PrettyNavigationBar *)self.navigationBar;
    
    navBar.topLineColor = [UIColor colorWithHex:0x414141];
    navBar.gradientStartColor = [UIColor colorWithHex:0x373737];
    navBar.gradientEndColor = [UIColor colorWithHex:0x1a1a1a];
    navBar.bottomLineColor = [UIColor colorWithHex:0x000000];
    navBar.tintColor = navBar.gradientEndColor;
    
    
}

@end
