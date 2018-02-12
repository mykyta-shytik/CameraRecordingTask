#import "RKRecorder.h"

#import <AVFoundation/AVFoundation.h>
#import <ReplayKit/ReplayKit.h>
#import <UIKit/UIKit.h>

@interface RKRecorder()

@property (nonatomic, strong) AVAssetWriter *writer;
@property (nonatomic, strong) AVAssetWriterInput *input;

@end

@implementation RKRecorder

#pragma mark - Public -

- (void)start:(NSString *)videoName completion:(void (^)(NSError *))completion {
    NSString *path = [RKRecorderFileUtils path:@"video6"];
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    
    self.writer = [[AVAssetWriter alloc] initWithURL:url fileType:AVFileTypeMPEG4 error:nil];
    NSDictionary *outS = @{AVVideoCodecKey: AVVideoCodecTypeH264,
                           AVVideoWidthKey: @([UIScreen mainScreen].bounds.size.width),
                           AVVideoHeightKey: @([UIScreen mainScreen].bounds.size.height)};
    
    self.input = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:outS];
    self.input.expectsMediaDataInRealTime = YES;
    [self.writer addInput:self.input];
    
    RPScreenRecorder *r = [RPScreenRecorder sharedRecorder];
    [r startRecordingWithHandler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)stop:(UIViewController *)vc completion:(void (^)(NSError *))completion {
    [[RPScreenRecorder sharedRecorder] stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
        [vc presentViewController:previewViewController animated:true completion:nil];
    }];
}

@end

@implementation RKRecorderFileUtils

+ (void)createVidsIfNeeded {
    NSString *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    NSString *reps = [docs stringByAppendingString:@"/Replays/"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:reps]) {
        [fm createDirectoryAtPath:reps withIntermediateDirectories:false attributes:nil error:nil];
    }
}

+ (NSString *)path:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *docs = paths.firstObject;
    NSString *folder = [docs stringByAppendingString:@"/"];
    NSString *fileName = [name stringByAppendingString:@".mp4"];
    NSString *res = [folder stringByAppendingString:fileName];
    NSLog(@"\n\n\n\n\n\n\n\n\nVIDP%@", res);
    return res;
}

+ (NSArray<NSString *> *)all {
    NSString *dir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject absoluteString];
//    NSString *path = [dir stringByAppendingString:@"Replays/"];
//    NSLog(@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\npath: %@", path);
    NSArray *c = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
    NSLog(@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\npath: %@", dir);
    return c;
}

@end
