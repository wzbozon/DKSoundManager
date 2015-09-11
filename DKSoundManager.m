//
//  DKSoundManager.m
//
//  Created by Dennis Kutlubaev on 11.09.15.
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Copyright (c) 2015 Dennis Kutlubaev (kutlubaev.denis@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "DKSoundManager.h"
#import <AVFoundation/AVFoundation.h>

static DKSoundManager *sharedSoundManager;

@interface DKSoundManager()
{
    NSDate *_lastPlayDate;
    
    AVAudioPlayer *_successPlayer;
    AVAudioPlayer *_errorPlayer;
    AVAudioPlayer *_pageFlipPlayer;
}

@end


@implementation DKSoundManager


- (id)init
{
    self = [super init];
    
    if (self) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"blip1" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        _successPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
        
        path =  [[NSBundle mainBundle] pathForResource:@"bass_deny" ofType:@"wav"];
        url = [NSURL fileURLWithPath:path];
        _errorPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
        
        path =  [[NSBundle mainBundle] pathForResource:@"page-flip-4" ofType:@"wav"];
        url = [NSURL fileURLWithPath:path];
        _pageFlipPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];

    }
    
    return self;
}


+ (DKSoundManager *)sharedSoundManager
{
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        sharedSoundManager = [[DKSoundManager alloc] init];
        
    });
    
    return sharedSoundManager;
}


- (void)shootSuccessSound
{
    if ( [self tooFrequent] ) return;
    
    [_successPlayer play];
    
    _lastPlayDate = [NSDate date];
}


- (void)shootErrorSound
{
    if ( [self tooFrequent] ) return;
    
    [_errorPlayer play];
    
    _lastPlayDate = [NSDate date];
}


- (void)shootPageFlipSound
{
    [_pageFlipPlayer play];
    
    _lastPlayDate = [NSDate date];
}


- (BOOL)tooFrequent
{
    if (_lastPlayDate != nil) {
        NSInteger interval = [_lastPlayDate timeIntervalSinceNow];
        if ( labs(interval) < 0.5 ) {
            return YES;
        }
    }
    
    return NO;
}

@end
