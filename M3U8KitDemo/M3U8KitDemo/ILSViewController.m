//
//  ILSViewController.m
//  M3U8KitDemo
//
//  Created by Sun Jin on 4/22/14.
//  Copyright (c) 2014 iLegendsoft. All rights reserved.
//

#import "ILSViewController.h"

#import <M3U8Kit/M3U8Kit.h>

@interface ILSViewController ()

@end

@implementation ILSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSString *baseURL = @"http://hls.ted.com/";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"769" ofType:@"m3u8"];
        NSError *error;
        NSURL *url = [NSURL URLWithString:@"http://60.55.12.192:80/b557e203267e10eebdfe30226f88cc46.m3u8?w=1&key=b26cb3ece0819e257a1f9da2288c8def&k=de9bb221cc76eb51641326d20325001e-3b23-1452149587&type=phone.ios.vip&sv=6.0&platform=iphone4&ft=1&accessType=wifi&vvid=5766CF17-69D5-47E6-B2AA-24E93F566BE2&video=true"];
//        NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        NSString *str = [[NSString alloc] initWithContentsOfURL:url
                                                        encoding:NSUTF8StringEncoding
                                                           error:&error];

        if (error) {
            NSLog(@"error: %@", error);
        }
        
        NSTimeInterval begin = [NSDate timeIntervalSinceReferenceDate];

        M3U8PlaylistModel *medel = [[M3U8PlaylistModel alloc] initWithString:str baseURL:url.absoluteString error:NULL];
        
        NSLog(@"segments names: %@", [medel segmentNamesForPlaylist:medel.audioPl]);
        
        NSString *m3u8Path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"str.m3u8"];
        error = nil;
//        [medel savePlaylistsToPath:m3u8Path error:&error];
        if (error) {
            NSLog(@"playlists save error: %@", error);
        }
        
        NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];
        NSLog(@"spend time = %f", end - begin);
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
