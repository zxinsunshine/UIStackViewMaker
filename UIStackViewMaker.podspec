
Pod::Spec.new do |s|
  s.name             = "UIStackViewMaker"
  s.version          = "1.2"
  s.summary          = "UIStackView构造器"
  s.author           = { "Theo Though" => "zxinsunshine@126.com" }
  
  s.homepage         = "https://github.com/zxinsunshine/UIStackViewMaker"
  s.license          = 'MIT'
  
  s.source = {
    :git => 'https://github.com/zxinsunshine/UIStackViewMaker.git',
    :tag => s.version.to_s
  }
  
  s.ios.deployment_target = '11.0'
  s.ios.frameworks = 'UIKit'
  
  s.subspec 'ObjC' do |oc|
    oc.source_files = "UIStackViewMaker/Objc/*.{h,m,mm,swift}"
    oc.public_header_files = "UIStackViewMaker/Objc/*.h"
  end
  
  s.swift_version = '5.0'
  s.subspec 'Swift' do |swift|
    swift.source_files = 'UIStackViewMaker/Swift/*.{h,m,mm,swift}'
  end
  
  s.default_subspec = 'ObjC'
end

