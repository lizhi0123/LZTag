#
# Be sure to run `pod lib lint LZTag.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LZTag'
  s.version          = '1.0.2'
  s.summary          = ' ios swift 标签选择器 tag Label selector,支持左对齐，右对齐，中间对齐'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  ios swift 标签选择器 tag Label selector，支持左对齐，右对齐，中间对齐
                       DESC

  s.homepage         = 'https://github.com/lizhi0123/LZTag'
   s.screenshots     = 'https://raw.githubusercontent.com/lizhi0123/LZTag/main/screenshots1.png', 'https://raw.githubusercontent.com/lizhi0123/LZTag/main/screenshots2.png',
   "https://raw.githubusercontent.com/lizhi0123/LZTag/main/screenshots3.png",
   "https://raw.githubusercontent.com/lizhi0123/LZTag/main/screenshots4.png"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lizhi0123' => '1056522750@qq.com' }
  s.source           = { :git => 'https://github.com/lizhi0123/LZTag.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LZTag/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LZTag' => ['LZTag/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
