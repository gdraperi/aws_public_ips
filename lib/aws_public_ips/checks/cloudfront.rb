# frozen_string_literal: true

require 'aws-sdk-cloudfront'
require 'aws_public_ips/utils'

module AwsPublicIps
  module Checks
    module Cloudfront
      def self.run
        client = Aws::CloudFront::Client.new

        client.list_distributions.flat_map do |response|
          response.distribution_list.items.flat_map do |distribution|
            {
              id: distribution.id,
              hostname: distribution.domain_name,
              ip_addresses: Utils.resolve_hostname(distribution.domain_name)
            }
          end
        end
      end
    end
  end
end
