Pod::Spec.new do |spec|
  spec.name         = "KHBannerView"
  spec.version      = "1.0.0"
  spec.summary      = "A simple infinity carousel that automatically scrolls banners."
  spec.homepage     = "https://github.com/kyeonghunkim0/KHBannerView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "KyeongHun Kim" => "kyeonghunkim0@gmail.com" }

  spec.platform     = :ios, "13.0"
  spec.swift_versions = '5.0'

  spec.source       = { :git => "https://github.com/kyeonghunkim0/KHBannerView.git", :tag => "#{spec.version}" }
  
  # 소스 파일 경로를 실제 폴더 위치에 맞게 수정
  spec.source_files  = "KHBannerView/*.swift"

  # 프로젝트에 프레임워크 의존성이 있다면 추가 (현재는 UIKit 기반이므로 기본으로 포함됨)
  spec.frameworks    = "UIKit"
end