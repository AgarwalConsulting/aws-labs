#!/usr/bin/env ruby

require 'json'

RAW_DATA = File.read("/tmp/participant_creds.json")
participants = JSON.parse(RAW_DATA)

participants.each do |info|
  cluster_name = info["eks_cluster_name"]
  arn = info["arn"]
  name = arn.split("/").last

  if name == "participants-01"
    next
  end

  puts "# ----"

  puts "aws eks update-kubeconfig --name #{cluster_name} --region us-east-1"

  user_yaml = <<-YAML
  mapUsers: |
    - userarn: #{arn}
      username: participants/#{name}
      groups:
        - system:masters
  YAML

  puts "USER_ARN=\"#{user_yaml.gsub("\n", "\\n")}\""

  puts 'kubectl get -n kube-system configmap/aws-auth -o yaml | awk "/data:/{print;print \"$USER_ARN\";next}1" > /tmp/aws-auth-patch.yml'

  puts 'kubectl patch configmap/aws-auth -n kube-system --patch "$(cat /tmp/aws-auth-patch.yml)"'

  puts "# ----"
end
