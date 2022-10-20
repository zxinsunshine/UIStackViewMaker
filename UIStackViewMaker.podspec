
Pod::Spec.new do |s|
    s.name             = "UIStackViewMaker"
    s.version          = "1.1"
    s.summary          = "UIStackView构造器"
    s.author           = { "Theo Though" => "zxinsunshine@126.com" }

    s.homepage         = "https://github.com/zxinsunshine/UIStackViewMaker"
    s.license          = 'MIT'

    s.source = {
        :git => 'https://github.com/zxinsunshine/UIStackViewMaker.git',
        :tag => s.version.to_s,
        :branch => 'main'
    }

    s.source_files = "UIStackViewMaker/*.{h,m,mm,swift}"
    s.public_header_files = "UIStackViewMaker/*.h"
   
    s.ios.deployment_target = '11.0'
    s.ios.frameworks = 'UIKit'
    
end
    
