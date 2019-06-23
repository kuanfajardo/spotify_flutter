#import "SpotifyPlugin.h"
#import <spotify/spotify-Swift.h>

@implementation SpotifyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSpotifyPlugin registerWithRegistrar:registrar];
}
@end
