Pod::Spec.new do |spec|
    spec.name         = 'ATSketchKit'
    spec.version      = '0.1'
    spec.license      = { :type => 'MIT' }
    spec.homepage     = 'https://github.com/athiercelin/ATSketchKit'
    spec.authors      = { 'Arnaud Thiercelin' => 'https://twitter.com/athiercelin', 'Sam Spencer' => 'https://samspencer.art' }
    spec.summary      = 'Fluid iOS drawing framework written in Swift.'
    spec.source       = { :git => 'https://github.com/athiercelin/ATSketchKit.git', :tag => '0.1' }
    spec.source_files = 'ATSketchKit/*.swift'
    spec.framework    = 'QuartzCore', 'CoreGraphics'
    spec.swift_version = '5.0'
    spec.ios.deployment_target  = '10.0'
end
