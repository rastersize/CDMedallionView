Pod::Spec.new do |s|
  s.name         = 'CDMedallionView'
  s.version      = '0.1.0'
  s.summary      = 'A medallion view for OS X (like the login image view introduced in Lion).'
  s.homepage     = 'https://github.com/rastersize/CDMedallionView'
  s.license      = 'MIT'
  s.author       = { 'Aron Cedercrantz' => 'aron@cedercrantz.se' }
  s.source       = { :git => 'https://github.com/rastersize/CDMedallionView.git', :tag => '0.1.0' }
  s.platform     = :osx, '10.6'
  s.source_files = 'CDMedallionView/*.{h,m}'
  s.requires_arc = true
end