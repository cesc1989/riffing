# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  # Activate the gem you are reporting the issue against.
  gem "activesupport", "7.1.4"
end

require "active_support"
require "active_support/core_ext/date"
require "minitest/autorun"

Date::DATE_FORMATS[:prueba] = '%Y/%m/%d'

class DateDeprecatedConversionsTest < Minitest::Test
  # Fails. #to_s does not accept an argument
  def test_implicit_default_conversions
    assert_equal Date.new(2023, 6, 21).to_s(:prueba), "2023/06/21"
  end

  # Starting Rails 7.1.4, use #to_fs to pass an argument
  def test_explicit_default_conversions
    assert_equal Date.new(2023, 6, 21).to_fs(:prueba), "2023/06/21"
  end
end
