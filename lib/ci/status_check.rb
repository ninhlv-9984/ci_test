require 'net/http'

module Ci
  class StatusCheck
    attr_reader :coverage

    def initialize(coverage)
      @coverage = coverage
    end

    def call(init_coverall_check = nil)
      # Initialize the HTTP object
      repo_name = ENV['CIRCLE_PROJECT_REPONAME']
      commit_hash = ENV['CIRCLE_SHA1']
      branch_name = ENV['CIRCLE_BRANCH']
      build_url = ENV['CIRCLE_BUILD_URL']
      owner = ENV['CIRCLE_PROJECT_USERNAME']
      url = ENV['CI_CHECK_URL']
      token = ENV['CI_CHECK_TOKEN']

      puts "Repo Name: #{repo_name}"
      puts "Commit Hash: #{commit_hash}"
      puts "Branch Name: #{branch_name}"
      puts "Coverage: #{coverage}%"

      # Send the coverage data to the API

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      request.body = {
        repo_name: repo_name,
        commit_hash: commit_hash,
        branch_name: branch_name,
        coverage: coverage,
        build_url: build_url,
        owner: owner,
        token: token,
        init_coverall_check: init_coverall_check
      }.to_json

      response = http.request(request)
      puts "Response from API: #{response.body}"
    end
  end
end
