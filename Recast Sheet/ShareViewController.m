//
//  ShareViewController.m
//  Recast Sheet
//
//  Created by Johannes Wärn on 06/01/15.
//  Copyright (c) 2015 Johannes Wärn. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>

#import "ShareViewController.h"
#import "ComposeViewController.h"

@interface ShareViewController () <ComposeViewControllerDelegate>

@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) ComposeViewController *composeController;
@property (nonatomic) NSURL *siteURL;

@end

@implementation ShareViewController

- (void)viewDidLoad
{
    NSExtensionItem *item = self.extensionContext.inputItems.firstObject;
    NSItemProvider *itemProvider = item.attachments.firstObject;
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *url, NSError *error) {
            self.siteURL = url;
            [self.composeController setSiteURL:self.siteURL];
        }];
    }
}

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
            self.composeController = composeViewController;
            [composeViewController setDelegate:self];
            if (composeViewController.siteURL == nil && self.siteURL != nil) {
                [self.composeController setSiteURL:self.siteURL];
            }
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
