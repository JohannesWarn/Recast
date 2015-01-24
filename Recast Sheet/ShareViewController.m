//
//  ShareViewController.m
//  Recast Sheet
//
//  Created by Johannes Wärn on 06/01/15.
//  Copyright (c) 2015 Johannes Wärn. All rights reserved.
//

#import "ShareViewController.h"
#import "ComposeViewController.h"

@interface ShareViewController () <ComposeViewControllerDelegate>

@property (nonatomic) UINavigationController *navigationController;

@end

@implementation ShareViewController

- (void)viewDidAppear:(BOOL)animated
{
    [self performSegueWithIdentifier:@"show" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        self.navigationController = navigationController;
        if ([[navigationController.viewControllers firstObject] isKindOfClass:[ComposeViewController class]]) {
            ComposeViewController *composeViewController = (ComposeViewController *)[navigationController.viewControllers firstObject];
            [composeViewController setDelegate:self];
        }
    }
}

#pragma mark - ComposeViewControllerDelegate

- (void)composeViewControllerDidCancel:(ComposeViewController *)composeViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
    }];
}

- (void)composeViewControllerShouldUpload:(ComposeViewController *)composeViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
    }];
}

@end
