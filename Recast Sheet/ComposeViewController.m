//
//  ComposeViewController.m
//  Recast
//
//  Created by Johannes Wärn on 08/01/15.
//  Copyright (c) 2015 Johannes Wärn. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self.commentTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)post:(id)sender {
    [self.view endEditing:YES];
    [self.delegate composeViewControllerShouldUpload:self];
}

- (IBAction)cancel:(id)sender {
    [self.delegate composeViewControllerDidCancel:self];
}

@end
