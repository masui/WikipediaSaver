// -*- mode:objc; indent-tabs-mode:nil; coding:utf-8 -*-
//
//  WikipediaSaverLoader.m
//
// http://blog.deadbeaf.org/archives/1781 を参考にして。
//

#import <Cocoa/Cocoa.h>
#import <RubyCocoa/RBRuntime.h>
#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>

@interface WikipediaSaverLoader : ScreenSaverView
{
  id wikipediaSaver;
}
@end

@implementation WikipediaSaverLoader
- (id)initWithFrame:(NSRect)frameRect isPreview:(BOOL)preview
{
  [super initWithFrame:frameRect isPreview:preview];
  
  static int installed = 0;
  if (! installed) {
    if (RBBundleInit("WikipediaSaver.rb", [self class], nil))
      NSLog(@"WikipediaSaverLoader.install: failed");
    else {
      NSLog(@"WikipediaSaverLoader.install: success");
      installed = 1;
    }

    Class rubyClass = NSClassFromString(@"WikipediaSaver");
    NSAssert(nil != rubyClass, @"could not find Ruby class");

    wikipediaSaver = [[rubyClass alloc] initWithFrame:frameRect isPreview:preview];
    NSAssert(nil != wikipediaSaver, @"Ruby instance should not be nil");

    [wikipediaSaver setSaver:self];
  }

  return self;
}

- (NSTimeInterval) animationTimeInterval {
  return [wikipediaSaver animationTimeInterval];
}

- (void)animateOneFrame
{
  [wikipediaSaver animateOneFrame];
}

@end
