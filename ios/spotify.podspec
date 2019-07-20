#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'spotify'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for using the Spotify mobile SDKs.'
  s.description      = <<-DESC
A Flutter plugin for using the Spotify mobile SDKs.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  
#  s.frameworks = 'Frameworks/SpotifyiOS'
#  s.pod_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '.', 'OTHER_LDFLAGS' => '-framework SpotifyiOS' }
  s.preserve_paths = 'Frameworks/*.framework'
  s.vendored_frameworks = 'Frameworks/SpotifyiOS.framework'
#
#  s.frameworks = 'SwiftSpotifyiOS'
#  s.pod_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '.', 'OTHER_LDFLAGS' => '-framework SwiftSpotifyiOS' }
#  s.preserve_paths = 'SwiftSpotifyiOS.framework'
#  s.vendored_frameworks = 'SwiftSpotifyiOS.framework'

  s.ios.deployment_target = '8.0'
end

