//
//  ViewController.m
//  AiromoSearchExample
//
//  Created by Pavel Sh. on 13/11/13.
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
@property (weak, nonatomic) IBOutlet UISegmentedControl *platformSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *storeSegmentControl;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)onSearch:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.hidesWhenStopped = YES;
    CGFloat halfButtonHeight = self.searchButton.bounds.size.height / 2;
    CGFloat buttonWidth = self.searchButton.bounds.size.width;
    indicator.center = CGPointMake(buttonWidth - halfButtonHeight , halfButtonHeight);
    [self.searchButton addSubview:indicator];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Action methods

- (IBAction)onSearch:(id)sender{
    [self.view endEditing:YES];
    
    AIManager *manager = [AIManager sharedManager];
    
    if (self.queryTextField.text.length || self.tagsTextField.text.length || self.urlTextField.text.length || self.metaKeywordsTextField.text.length){
        
        [indicator startAnimating];
        
        NSMutableArray *tags = [NSMutableArray array];
        
        manager.query = self.queryTextField.text;
        manager.metaKeywords = self.metaKeywordsTextField.text;
        manager.url = self.urlTextField.text;
        [tags addObjectsFromArray:[self.tagsTextField.text componentsSeparatedByString:@","]];
        
        manager.tags = tags;
        
        if (self.priceSegmentControl.selectedSegmentIndex>=0){
            manager.price = (self.priceSegmentControl.selectedSegmentIndex==0) ? AIPriceFree: AIPricePaid;
        }
        
        [manager presentFromViewController:self
                                  animated:YES
                             withPartnerId:1
                              withChannelId:1
                                withOffset:0
                                  withSize:10
                     withCompletionHandler:^(NSError *error){
             
             if (error) {
                 [[[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
             }
             [indicator stopAnimating];
         }];
    }
}
@end
