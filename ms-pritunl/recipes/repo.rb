apt_repository 'pritunl' do
  uri          'http://repo.pritunl.com/stable/apt'
  distribution 'focal'
  components   ['main']
  keyserver    'keyserver.ubuntu.com'
  key          '7568D9BB55FF9E5287D586017AE645C0CF8E292A'
end
