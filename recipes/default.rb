#
# Cookbook Name:: aws_motd
# Recipe:: default
#

ruby_block "Read AWS Attributes" do
  block do
    require 'net/http'
    require 'json'
    http = Net::HTTP.new("169.254.169.254")
    http.open_timeout = 8
    http.read_timeout = 8
    begin
      instance_data_req = http.get('/latest/dynamic/instance-identity/document')
    rescue StandardError
    end
    begin
      instance_data = JSON.parse(instance_data_req.body)
      node.override['aws_motd']['aws_motd_successfully_parsed_aws_data'] = true
    rescue
      instance_data = Hash.new()
    end
    instance_data.each do |_k,_v|
      node.default['aws_motd']['aws'][_k] = _v
      begin
        node.default['aws_motd']['mapped'][_k] = node['aws_motd']['map'][_k][_v] 
      rescue
        node.default['aws_motd']['mapped'][_k] = _v
      end
    end
  end
end

template node['aws_motd']['motd'] do
  source 'motd.erb'
  mode '0644'
  owner 'root'
  group 'root'
  variables(
    :has_aws_data = node['aws_motd']['aws_motd_successfully_parsed_aws_data'] ? true : nil
  )
end

_motd_script = node['aws_motd']['motd_script']
_motd_script_path = File.dirname(_motd_script)
template _motd_script do
  source 'motd_script.erb'
  mode '0755'
  owner 'root'
  group 'root'
  variables(
    :has_aws_data = node['aws_motd']['aws_motd_successfully_parsed_aws_data'] ? true : nil
  )
  not_if do !File.directory?(_motd_script_path) end
end 



      
