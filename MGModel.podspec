Pod::Spec.new do |s|
s.name         = 'MGModel'
s.summary      = 'reflect json object to objc model.'
s.version      = '0.1.0'
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.authors      = { 'maoguang' => 'guangmao53@gmail.com' }
s.social_media_url = 'https://github.com/haoguangli'
s.homepage     = 'https://github.com/haoguangli/MGModel'

s.ios.deployment_target = '6.0'


s.source       = { :git => 'https://github.com/haoguangli/MGModel.git', :tag => s.version.to_s }

s.requires_arc = true
s.source_files = 'MGModel/*.{h,m}'
s.public_header_files = 'MGModel/*.{h}'

s.frameworks = 'Foundation', 'CoreFoundation'

end
