//
//  XSRtmpViewController.m
//  XSSuperDemo-OC
//
//  Created by 晓松 on 2018/11/14.
//  Copyright © 2018 GoodMorning. All rights reserved.
//

#import "XSRtmpViewController.h"


@interface XSRtmpViewController ()

//@property (atomic, strong) id <IJKMediaPlayback> player;

@end

@implementation XSRtmpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RTMP";
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self setupPlayer];
    
}

//- (void)setupPlayer {
//#ifdef DEBUG
//
//    [IJKFFMoviePlayerController setLogReport:YES];
//    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_INFO];
//
//#else
//
//    [IJKFFMoviePlayerController setLogReport:YES];
//
//
//#endif
//
//
//    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
//
//    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
//
//    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"rtmp://218.245.0.236:8096/vod/0EDD5J_kAIE.mp4" withOptions:options];
//
//    self.player.view.frame = self.view.bounds;
//
//    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.player.shouldAutoplay = YES;
//    self.view.autoresizesSubviews = YES;
//
//    [self.view addSubview: self.player.view];
//
//    [self.player play];
//}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self installMovieNotificationObservers];
//    
////    [self.player prepareToPlay];
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    
////    [self.player shutdown];
////    [self removeMovieNotificationObservers];
//}

//- (void)loadStateDidChange:(NSNotification*)notification
//{
//    //    MPMovieLoadStateUnknown        = 0,
//    //    MPMovieLoadStatePlayable       = 1 << 0,
//    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
//    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
//
//    IJKMPMovieLoadState loadState = _player.loadState;
//
//    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
//        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
//    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
//        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
//    } else {
//        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
//    }
//}
//
//- (void)moviePlayBackDidFinish:(NSNotification*)notification
//{
//    //    MPMovieFinishReasonPlaybackEnded,
//    //    MPMovieFinishReasonPlaybackError,
//    //    MPMovieFinishReasonUserExited
//    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
//
//    switch (reason)
//    {
//        case IJKMPMovieFinishReasonPlaybackEnded:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
//            break;
//
//        case IJKMPMovieFinishReasonUserExited:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
//            break;
//
//        case IJKMPMovieFinishReasonPlaybackError:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
//            break;
//
//        default:
//            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
//            break;
//    }
//}
//
//- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
//{
//    NSLog(@"mediaIsPreparedToPlayDidChange\n");
//}
//
//- (void)moviePlayBackStateDidChange:(NSNotification*)notification
//{
//    //    MPMoviePlaybackStateStopped,
//    //    MPMoviePlaybackStatePlaying,
//    //    MPMoviePlaybackStatePaused,
//    //    MPMoviePlaybackStateInterrupted,
//    //    MPMoviePlaybackStateSeekingForward,
//    //    MPMoviePlaybackStateSeekingBackward
//
//    switch (_player.playbackState)
//    {
//        case IJKMPMoviePlaybackStateStopped: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
//            break;
//        }
//        case IJKMPMoviePlaybackStatePlaying: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
//            break;
//        }
//        case IJKMPMoviePlaybackStatePaused: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
//            break;
//        }
//        case IJKMPMoviePlaybackStateInterrupted: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
//            break;
//        }
//        case IJKMPMoviePlaybackStateSeekingForward:
//        case IJKMPMoviePlaybackStateSeekingBackward: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
//            break;
//        }
//        default: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
//            break;
//        }
//    }
//}
//
//
//
//
///* Register observers for the various movie object notifications. */
//-(void)installMovieNotificationObservers
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(loadStateDidChange:)
//                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
//                                               object:_player];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackDidFinish:)
//                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
//                                               object:_player];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
//                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
//                                               object:_player];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackStateDidChange:)
//                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
//                                               object:_player];
//}
//
//#pragma mark Remove Movie Notification Handlers
//
///* Remove the movie notification observers from the movie object. */
//-(void)removeMovieNotificationObservers
//{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
//}



@end
