//
//  ComposeViewController.m
//  Recast
//
//  Created by Johannes Wärn on 08/01/15.
//  Copyright (c) 2015 Johannes Wärn. All rights reserved.
//

#import "ComposeViewController.h"

#import "AudioFinder.h"

@interface ComposeViewController () <AudioFinderDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *fileCell;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UITableViewCell *viaCell;

@property (nonatomic) AudioFinder *audioFinder;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    [self setupViaCell];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.commentTextView becomeFirstResponder];
}

- (void)setupViaCell
{
    NSDictionary *hostToName = @{
                                 @"overcast.fm": @"Overcast",
                                 @"itunes.apple.com": @"iTunes"
                                 };
    
    if ([hostToName objectForKey:_siteURL.host]) {
        self.viaString = [hostToName objectForKey:_siteURL.host];
    }
    
    [self.viaCell.textLabel setText:self.viaString];
    [self.viaCell.detailTextLabel setText:self.viaURL.absoluteString];
}

- (void)setSiteURL:(NSURL *)siteURL
{
    if (![_siteURL isEqual:siteURL]) {
        _siteURL = siteURL;
        
        self.viaString = _siteURL.host;
        self.viaURL = _siteURL;
        [self setupViaCell];
        
        self.audioFinder = [[AudioFinder alloc] initWithURL:_siteURL];
        [self.audioFinder setDelegate:self];
        [self.audioFinder findAudio];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)post:(id)sender {
    [self.view endEditing:YES];
    [self.delegate composeViewControllerShouldUpload:self];
}

- (IBAction)cancel:(id)sender {
    [self.view endEditing:YES];
    [self.delegate composeViewControllerDidCancel:self];
}

#pragma mark - AudioFinderDelegate

- (void)audioFinderFinished:(AudioFinder *)audioFinder
{
    if ([audioFinder isEqual:self.audioFinder]) {
        self.audioURLs = audioFinder.audioURLs;
        self.audioURL = audioFinder.audioURL;
        
        [self.fileCell.textLabel setText:[self.audioURL.pathComponents lastObject]];
        
        self.audioFinder = nil;
    }
}

@end
