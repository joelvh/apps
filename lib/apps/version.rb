require 'json'

module Apps
  PACKAGE_PATH ||= File.expand_path('../../package.json', File.dirname(__FILE__))
  VERSION ||= JSON.parse(File.read(PACKAGE_PATH)).fetch('version')
end
