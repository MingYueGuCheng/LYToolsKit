Pod::Spec.new do |s|
  s.name             = 'LYToolsKit'
  s.version          = '0.2.0'
  s.summary          = 'LYToolsKit is Foundation|UI|Utility SDK.'

  s.homepage         = 'https://github.com/yyly/LYToolsKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yyly' => 'mingyuegucheng@icloud.com' }
  s.source           = { :git => 'https://github.com/yyly/LYToolsKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'LYToolsKit/LYToolsKit.h'

  s.subspec 'Foundation' do |f|
    f.source_files = 'LYToolsKit/Foundation/**/*.{h,m}'
    f.pod_target_xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
  end

  s.subspec 'UI' do |u|
    u.source_files = 'LYToolsKit/UI/**/*.{h,m}'
    u.pod_target_xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
  end

  s.subspec 'Utility' do |ut|
    ut.source_files = 'LYToolsKit/Utility/**/*.{h,m}'
    ut.dependency "Masonry"
    ut.dependency "LYToolsKit/UI"
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
