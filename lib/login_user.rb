require 'yaml/store'

class LoginUser
  def initialize(file_name)
    @login = YAML::Login.new(file_name)
  end
end
