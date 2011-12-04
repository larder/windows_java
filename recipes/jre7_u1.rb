#
# Author:: Paul Morton (<larder-project@biaprotect.com>)
# Cookbook Name:: windows_java
#
# Copyright 2011, Paul Morton
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
#

if ENV['PROCESSOR_ARCHITEW6432'] == 'AMD64'
  installer = 'http://download.oracle.com/otn-pub/java/jdk/7u1-b08/jre-7u1-windows-x64.exe'
  title = 'Java(TM) 7 Update 1 (64-bit)'
else
  installer = 'http://download.oracle.com/otn-pub/java/jdk/7u1-b08/jre-7u1-windows-i586.exe'
  title = 'Java(TM) 7 Update 1'
end

windows_package title do
  source installer
  action :install
  options "/s"
  installer_type :custom
end

begin
  java_path = Registry.get_value('HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\1.7.0_U1','JavaHome')
rescue
  java_path = 'C:\Program Files\Java\jre7'
end

env 'PATH' do
  action :modify
  delim ::File::PATH_SEPARATOR
  value "#{java_path}\\bin"
end