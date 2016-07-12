Gem::Specification.new do |s|
  s.name        = 'sendcloud-sms'
  s.version     = '0.0.2'
  s.date        = '2016-07-13'
  s.summary     = 'An unofficial gem to send SMS with SendCloud API.'
  s.description = 'An unofficial gem to send SMS with SendCloud API.'
  s.authors     = ['HeckPsi Lab']
  s.email       = 'business@heckpsi.com'
  s.files       = ['lib/sendcloud-sms.rb']
  s.require_paths = ['lib']
  s.homepage    = 'https://github.com/heckpsi-lab/sendcloud-sms'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rest-client'
end
