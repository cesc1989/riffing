# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  # Activate the gem you are reporting the issue against.
  gem "activesupport", "7.0.5.1" # Fails in this version
  # gem "activesupport", "7.0.7" # Works in this version
end

require "active_support"
require "active_support/core_ext/date"
require "minitest/autorun"

# Add default format
Date::DATE_FORMATS[:default] = '%Y/%m/%d'

class DateDeprecatedConversionsTest < Minitest::Test
  def test_implicit_default_conversions
    assert_equal Date.new(2023, 6, 21).to_s, '2023/06/21'
  end

  def test_explicit_default_conversions
    assert_equal Date.new(2023, 6, 21).to_s(:default), '2023/06/21'
  end
end
