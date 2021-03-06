//
//  ComposeViewController.h
//  Recast
//
//  Created by Johannes Wärn on 08/01/15.
//  Copyright (c) 2015 Johannes Wärn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ComposeViewControllerDelegate;

@interface ComposeViewController : UITableViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@property (nonatomic) NSURL *siteURL;
@property (nonatomic) NSString *viaString;
@property (nonatomic) NSURL *viaURL;
@property (nonatomic) NSArray *audioURLs;
@property (nonatomic) NSURL *audioURL;

@end

@protocol ComposeViewControllerDelegate <NSObject>

- (void)composeViewControllerDidCancel:(ComposeViewController *)composeViewController;
- (void)composeViewControllerShouldUpload:(ComposeViewController *)composeViewController;

@end