Pod::Spec.new do |s|
    s.name = 'MFPageFlowView'
    s.version = '0.2'
    s.license = 'MIT'
    s.summary = 'A paging flow view, similar to the scrollable iOS App Store screenshots.'
    s.authors = { 'Kyle Fuller' => 'inbox@kylefuller.co.uk' }
    s.homepage = 'https://bitbucket.org/mentallyfriendlyldn/mfpageflowview'
    s.source = { :git => 'https://bitbucket.org/mentallyfriendlyldn/mfpageflowview.git', :tag => '0.1' }

    s.requires_arc = true

    s.platform = :ios, '5.0'
    s.ios.source_files = 'MFPageFlowView.{m,h}'
end

