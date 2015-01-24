//
//  AudioFinder.h
//  Recast
//
//  Created by Johannes Wärn on 24/01/15.
//  Copyright (c) 2015 Johannes Wärn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AudioFinderDelegate;

@interface AudioFinder : NSObject

@property (nonatomic, weak) id <AudioFinderDelegate> delegate;

@property (nonatomic) NSURL *url;

@property (nonatomic) NSArray *audioURLs;
@property (nonatomic) NSURL *audioURL;

- (instancetype)initWithURL:(NSURL *)url;
- (void)findAudio;

@end


@protocol AudioFinderDelegate <NSObject>

- (void)audioFinderFinished:(AudioFinder *)audioFinder;

@end