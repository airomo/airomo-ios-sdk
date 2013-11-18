//
//  ViewController.m
//  AiromoSearchExample
//
//  Created by Pavel Shpak on 13/11/13.
//  Copyright (c) 2013 Airomo. All rights reserved.
//

#import "ViewController.h"
#import <AiromoSDK/AiromoSDK.h>

@interface ViewController ()
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

- (IBAction)onSearch:(id)sender
{
    [self.view endEditing:YES];
    self.searchButton.enabled = NO;

    AIManager *manager = [AIManager sharedManager];
    
    if (self.queryTextField.text.length)
    {
        
        [indicator startAnimating];
        
        manager.query = self.queryTextField.text;
        if (self.metaKeywordsTextField.text.length)
            manager.metaKeywords = self.metaKeywordsTextField.text;
        if (self.urlTextField.text.length)
            manager.url = self.urlTextField.text;
        if (self.tagsTextField.text.length)
            manager.tags = [NSMutableArray arrayWithArray:[self.tagsTextField.text componentsSeparatedByString:@","]];
        [manager searchApplicationsWithPartnerId:1 withChannelId:1 withOptions:nil withOffset:1 withSize:10 withCompletionHandler:^(id response, NSError *error)
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
