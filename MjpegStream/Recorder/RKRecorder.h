#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RKRecorder : NSObject

- (void)start:(NSString *)videoName completion:(void (^)(NSError *))completion;
- (void)stop:(UIViewController *)vc completion:(void (^)(NSError *))completion;

@end

@interface RKRecorderFileUtils: NSObject

+ (void)createVidsIfNeeded;
+ (NSString *)path:(NSString *)name;
+ (NSArray<NSURL *> *)all;

@end
