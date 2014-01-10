//
//  ViewController.m
//  AiromoSearchExample
//
//  Created by Pavel Shpak on 13/11/13.
//  Copyright (c) 2013 Airomo. All rights reserved.
//

#import "ViewController.h"
#import <AiromoSDK/AiromoSDK.h>

@interface ViewController () <UITextFieldDelegate>
{
    UIActivityIndicatorView *indicator;
}

@property (weak, nonatomic) IBOutlet UITextField *queryTextField;
@property (weak, nonatomic) IBOutlet UITextField *metaKeywordsTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextField *tagsTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *listTypeSegmentControl;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)onSearch:(id)sender;
- (IBAction)onJSON:(id)sender;

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.hidesWhenStopped = YES;
    CGFloat halfButtonHeight = self.searchButton.bounds.size.height / 2;
    CGFloat buttonWidth = self.searchButton.bounds.size.width;
    indicator.center = CGPointMake(buttonWidth - halfButtonHeight , halfButtonHeight);
    [self.searchButton addSubview:indicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldRotateToOrientation:(UIInterfaceOrientation)orientation
{
        return YES;
}

#pragma mark - Action methods

- (IBAction)onSearch:(id)sender
{
    [self.view endEditing:YES];

    AIManager *manager = [AIManager sharedManager];
    
    if (self.queryTextField.text.length || self.tagsTextField.text.length || self.urlTextField.text.length || self.metaKeywordsTextField.text.length)
    {
        [indicator startAnimating];
        
        NSMutableArray *tags = [NSMutableArray array];
        
        manager.query = self.queryTextField.text;
        manager.metaKeywords = self.metaKeywordsTextField.text;
        manager.url = self.urlTextField.text;
        [tags addObjectsFromArray:[self.tagsTextField.text componentsSeparatedByString:@","]];
             
        manager.tags = tags;
        
        if (self.priceSegmentControl.selectedSegmentIndex>=0)
        {
            manager.price = (self.priceSegmentControl.selectedSegmentIndex==0) ? AIPriceFree : AIPricePaid;
        }
        
        manager.phoneListType = (self.listTypeSegmentControl.selectedSegmentIndex==0) ? AIPhoneListTypeList : AIPhoneListTypeTile;
        
        [manager presentFromViewController:self
                                    withPartnerId:1
                                    withChannelId:1
                                       withOffset:0
                                  withSize:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 15 : (manager.phoneListType == AIPhoneListTypeTile)?28:10
                            withCompletionHandler:^(NSError *error)
         {
             
             if (error) {
                 [[[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
             }
             
             [indicator stopAnimating];
         }];
        
    }
}


/*
 *  Show JSON
 */
- (IBAction)onJSON:(id)sender {
    
    [self.view endEditing:YES];
    
    AIManager *manager = [AIManager sharedManager];
    
    if (self.queryTextField.text.length || self.tagsTextField.text.length || self.urlTextField.text.length || self.metaKeywordsTextField.text.length)
    {
        [indicator startAnimating];
        
        NSMutableArray *tags = [NSMutableArray array];
        
        manager.query = self.queryTextField.text;
        manager.metaKeywords = self.metaKeywordsTextField.text;
        manager.url = self.urlTextField.text;
        [tags addObjectsFromArray:[self.tagsTextField.text componentsSeparatedByString:@","]];
        
        manager.tags = tags;
        
        if (self.priceSegmentControl.selectedSegmentIndex>=0)
        {
            manager.price = (self.priceSegmentControl.selectedSegmentIndex==0) ? AIPriceFree: AIPricePaid;
        }
    
        [manager searchApplicationsWithPartnerId:1
                                   withChannelId:1
                                      withOffset:0
                                        withSize:10
                           withCompletionHandler:^(id response, NSError *error)
        {

            dispatch_async(dispatch_get_main_queue(),^{

                [indicator stopAnimating];
                self.searchButton.enabled = YES;
                if (!error)
                {
                    //result as dictionary
                    NSMutableDictionary *resultDictionary = (NSMutableDictionary*)response;

                    self.resultTextView.text = [resultDictionary description];

                }
                else
                {
                    [[[UIAlertView alloc] initWithTitle:@"API error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                }

            });
        }];
    }
}
@end
