#This module assumes an EC2 instance role to be used for authentication
#Usage: put "extend Amazon::Helpers" inside your recipe before calling "get_tag"
module Amazon
  module Helpers

    def get_tag(tag)
      #Check to see if the aws-sdk gem is installed, if not throw exception and install
      #The require aws-sdk statement is inside the method because we don't want chef to call it during compile phase and break.
      #This is not a perfect way of handling the sdk install but it works.
      begin
        gem "aws-sdk"
      rescue LoadError
        #install prereqs before install gem.
        system("yum install -y libxml2 tar gzip gcc patch make automake zlib-devel; /opt/chef/embedded/bin/gem install aws-sdk")
        Gem.clear_paths
      end

      require 'aws-sdk'

      instance_id = `curl -s http://169.254.169.254/latest/meta-data/instance-id`
      ec2 = AWS::EC2.new
      instance = ec2.instances[instance_id]
      tags = instance.tags
    
      #returns an array with two columns.  first column is the tag name, second column is the tag value.
      tags.each do |item|
        if item[0] == tag
          return item[1]
        end
      end
    end
  end
end

