//
//  AudioFinder.m
//  Recast
//
//  Created by Johannes Wärn on 24/01/15.
//  Copyright (c) 2015 Johannes Wärn. All rights reserved.
//

#import "AudioFinder.h"

@interface AudioFinder ()

@property (nonatomic) NSArray *audioSuffixes;

@end

@implementation AudioFinder

- (instancetype)initWithURL:(NSURL *)url;
{
    self = [super init];
    if (self) {
        self.url = url;
        self.audioSuffixes = @[@"aif", @"aifc", @"aiff", @"wav", @"flac", @"mp2", @"mp3", @"mp4", @"m4a", @"m4p", @"m4b", @"ogg"];
    }
    return self;
}

- (void)findAudio
{
    typeof(self) __weak weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *htmlString = [[NSString alloc] initWithContentsOfURL:weakSelf.url encoding:NSUTF8StringEncoding error:nil];
        
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [detector matchesInString:htmlString options:0 range:NSMakeRange(0, [htmlString length])];
        
        NSMutableArray *audioURLs = [NSMutableArray array];
        [matches enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSURL *link = ((NSTextCheckingResult *)obj).URL;
            NSString *suffix = [[link.absoluteString componentsSeparatedByString:@"."] lastObject];
            suffix = [[suffix componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"?#"]] firstObject];
            if ([self.audioSuffixes containsObject:suffix]) {
                [audioURLs addObject:link];
            }
        }];
        
        self.audioURLs = audioURLs;
        self.audioURL = [audioURLs firstObject];;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.delegate audioFinderFinished:weakSelf];
        });
    });
}

@end
