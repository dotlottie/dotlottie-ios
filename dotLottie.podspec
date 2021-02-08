#
# Be sure to run `pod lib lint dotLottie.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'dotLottie'
  s.version          = '0.1.7'
  s.summary          = 'An iOS library to natively render .lottie files with the help of Lottie iOS Library https://dotlottie.io/'

  s.description      = <<-DESC
dotLottie is an open-source file format that aggregates one or more Lottie files and their associated resources into a single file. They are ZIP archives compressed with the Deflate compression method and carry the file extension of .lottie.
                       DESC

  s.homepage         = 'https://github.com/dotlottie/dotlottie-ios'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'eharrison' => 'evandro.hoffmann@gmail.com' }
  s.source           = { :git => 'https://github.com/dotlottie/dotlottie-ios.git', :tag => s.version.to_s }
  
  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'

  s.source_files = 'Sources/**/*'
  
  s.module_name = 'dotLottie'
  
  s.dependency 'dotLottieLoader', '~> 0.1.3'
  s.dependency 'lottie-ios', '~> 3.2.0'
end
