require 'ostruct'
require 'yaml'

# Custom config options
all_config = YAML.load_file("#{Rails.root}/config/config.yml") || {}
env_config = all_config[Rails.env] || {}
AppConfig = OpenStruct.new(env_config)