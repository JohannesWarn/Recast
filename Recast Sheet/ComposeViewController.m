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

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (nonatomic) AudioFinder *audioFinder;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self.commentTextView becomeFirstResponder];
}

- (void)setSiteURL:(NSURL *)siteURL
{
    if (![_siteURL isEqual:siteURL]) {
        _siteURL = siteURL;
        
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

- (void)audioFinder:(AudioFinder *)audioFinder foundAudioLinks:(NSArray *)audioLinks
{
    if ([audioFinder isEqual:self.audioFinder]) {
        self.audioLinks = audioLinks;
        [self.commentTextView setText:[[audioLinks firstObject] absoluteString]];
        
        self.audioFinder = nil;
    }
}

@end
