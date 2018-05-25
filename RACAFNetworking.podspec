Pod::Spec.new do |s|
s.name         = "RACAFNetworking"
s.version      = "1.1"
s.summary      = "AFNetworking ReactiveObjC extension"
s.homepage     = "https://github.com/zhaochengfeng/RACAFNetworking"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "Zhao Chengfeng" => "zhaochengfengios@163.com" }
s.source       = { :git => "https://github.com/zhaochengfeng/RACAFNetworking", :tag => "#{s.version}" }
s.ios.deployment_target = '8.0'
s.requires_arc = true


s.dependency 'ReactiveObjC', '>3.0.0'
s.dependency "AFNetworking",  '>3.0.0'
s.source_files  = "RACAFNetworking/RACAFNetworking/*"

end
