require 'serverspec'
require 'pathname'
require 'net/ssh'

include SpecInfra::Helper::Ssh
# include Serverspec::Helper::Cmd
include Serverspec::Helper::Windows
