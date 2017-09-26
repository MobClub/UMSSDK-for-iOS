Pod::Spec.new do |s|
s.name                = "UMSSDK"
s.version             = "1.0.0"
s.summary             = 'mob.com的用户管理系统'
s.license             = 'Copyright © 2012-2017 mob.com'
s.author              = { "Jinghuang Liu" => "liujinghuang@icloud.com" }
s.homepage            = 'http://www.mob.com'
s.source              = { :git => "https://github.com/MobClub/UMSSDK-for-iOS.git", :tag => s.version.to_s }
s.platform            = :ios, '7.0'
s.frameworks          = "CoreLocation"
s.libraries           = "z", "stdc++", "icucore"
s.default_subspecs    = 'UMSSDK'
s.vendored_frameworks = 'SDK/UMSSDK/UMSSDK.framework'
s.resources = 'JiMu.bundle'
s.dependency 'MOBFoundation' , "JiMu" , "SMSSDK" , "ShareSDK3"

s.subspec 'UMSSDK' do |sp|
sp.vendored_frameworks = 'SDK/UMSSDK/UMSSDK.framework'
sp.libraries           = 'icucore', 'z', 'stdc++'
sp.frameworks          = "CoreLocation"
sp.vendored_frameworks = 'SDK/UMSSDK/UMSSDK.framework'
end

s.subspec 'UMSSDKUI' do |sp|
sp.vendored_frameworks = 'SDK/UMSSDK/UMSSDKUI.framework'
sp.resources           = 'SDK/UMSSDK/UMSSDKUI.bundle'
sp.libraries           = 'icucore', 'z', 'stdc++'
sp.frameworks          = "CoreLocation"
sp.dependency "MJRefresh"
end

end
