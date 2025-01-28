# run: ruby capture_safe_buffer.rb
# go to: localhost:3006

require "bundler/inline"

# require it (before Rails init) here to prevent: uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger (NameError)
require "logger"

gemfile(true) do
  source "https://rubygems.org"

  # gem "rails", "7.1.4" # Falla en esta versión
  gem "rails", "7.0.8" # Funciona en esta versión
  gem "puma"
end

require "rails"
require "action_controller/railtie"
require "action_view/railtie"

class TestApp < Rails::Application
  config.root = __dir__
  config.eager_load = false
  config.session_store :cookie_store, key: "_test_app_session"

  config.middleware.use ActionDispatch::Cookies
  config.middleware.use ActionDispatch::Session::CookieStore, config.session_options

  Rails.logger = Logger.new($stdout)
  Rails.logger.level = Logger::DEBUG
end

Rails.application.initialize!

module HeaderHelper
  class Context
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
    include Rails.application.routes.url_helpers

    attr_accessor :context, :content_buffer, :actions_buffer, :output_buffer, :controller, :title

    def initialize(context, title = nil)
      self.context = context
      self.title = title
      self.content_buffer = ActiveSupport::SafeBuffer.new
      self.actions_buffer = ActiveSupport::SafeBuffer.new
      self.output_buffer = ActiveSupport::SafeBuffer.new
    end

    def breadcrumbs(html_class = "breadcrumbs", &block)
      context = Context.new self

      capture { block.call context } if block_given?

      content_buffer << tag.ul(context.output_buffer, class: html_class)
    end

    def breadcrumb(text, path = nil, options = {})
      default_options = {
        html_class: "breadcrumb-item",
        icon: nil
      }
      options.reverse_merge! default_options

      text = sanitize "#{options[:icon]} #{text}" if options[:icon].present?

      output_buffer << if path.present?
                         tag.li class: options[:html_class] do
                           link_to text, path
                         end
                       else
                         tag.li class: "#{options[:html_class]} active" do
                           tag.span text
                         end
                       end
    end

    def actions(html_class = "actions", &block)
      actions_buffer << tag.div(context.capture(&block), class: html_class)
    end
  end

  def header(title_text, options = {}, &block)
    default_options = {
      heading_size: :h2,
      header_class: "header",
      content_class: "content"
    }
    options.reverse_merge! default_options

    context = Context.new self, title_text

    capture { block.call context } if block_given?

    # Add title to content section
    context.content_buffer << content_tag(options[:heading_size], title_text)

    tag.header class: options[:header_class] do
      concat tag.div(context.content_buffer, class: options[:content_class])
      concat context.actions_buffer
    end
  end
end

class ApplicationController < ActionController::Base
  helper HeaderHelper
end

class HomeController < ApplicationController
  def index
    render inline: <<-ERB
      <%= header "Transfer Appointments" do |h| %>
        <%= h.breadcrumbs do |b| %>
          <%= b.breadcrumb "Patients", "/patients" %>
          <%= b.breadcrumb "John Doe", "/patients/1" %>
          <%= b.breadcrumb "Care Plans" %>
          <%= b.breadcrumb "12345", "/care_plans/12345" %>
        <% end %>
      <% end %>
    ERB
  end
end

Rails.application.routes.draw do
  root "home#index"
end

if __FILE__ == $0
  require "rack/handler/puma"

  Rack::Handler::Puma.run Rails.application, Port: 3006
end
