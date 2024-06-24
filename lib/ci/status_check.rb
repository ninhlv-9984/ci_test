require 'net/http'

module Ci
  class StatusCheck
    attr_reader :coverage

    def initialize(coverage)
      @coverage = coverage
    end

    def call
      # Initialize the HTTP object
      repo_name = ENV['CIRCLE_PROJECT_REPONAME']
      commit_hash = ENV['CIRCLE_SHA1']
      branch_name = ENV['CIRCLE_BRANCH']
      build_url = ENV['CIRCLE_BUILD_URL']
      owner = ENV['CIRCLE_PROJECT_USERNAME']

      puts "Repo Name: #{repo_name}"
      puts "Commit Hash: #{commit_hash}"
      puts "Branch Name: #{branch_name}"
      puts "Coverage: #{coverage}%"

      # Send the coverage data to the API
      uri = URI.parse("https://crk6el99hd.execute-api.ap-northeast-1.amazonaws.com/Prod/coverage")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      request.body = {
        repo_name: repo_name,
        commit_hash: commit_hash,
        branch_name: branch_name,
        coverage: coverage,
        build_url: build_url,
        owner: owner
      }.to_json

      response = http.request(request)
      puts "Response from API: #{response.body}"
    end
  end
end
