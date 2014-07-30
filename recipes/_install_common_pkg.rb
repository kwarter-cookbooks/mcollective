#
# Cookbook Name:: mcollective
# Recipe:: install_common_pkg
#
# Installs mcollective-common using packages.
#
# Copyright 2013, Zachary Stevens
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if node['mcollective']['enable_puppetlabs_repo']
  include_recipe 'mcollective::puppetlabs-repo'
end

#
# HEADS-UP: This is a HACK, but works ;)
#
# AG.- On Ubuntu 14.04 rubygems is not available, so package as been removed
#      Reference of issue: http://projects.puppetlabs.com/issues/17804
#package "rubygems" do
#  action :install
#end

package "rubygem-stomp" do
  case node['platform_family']
  when "debian"
    # AG .- Other HACK, libstom-ruby is not available on Ubuntu 14.04
    #       use ruby-stomp instead
    #package_name "libstomp-ruby"
    package_name "ruby-stomp"
  when "rhel","fedora"
    package_name "rubygem-stomp"
  end
  action :install
end

package "mcollective-common" do
  action :install
  version node['mcollective']['package']['version']
end
