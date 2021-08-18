# frozen_string_literal: true

require 'tweakphoeus/helpers'

module Tweakphoeus
  # Cookie manager
  class CookieJar
    include Tweakphoeus::Helpers

    def initialize
      @cookie_jar = {}
    end

    def purge_bad_cookies(cookies)
      cookies.reject { |cookie| cookie.first.last == '""' }
    end

    def cookie_string(url, headers = {})
      domain = get_domain(url)
      headers ||= {}
      cookies = parse_cookie(headers['Cookie'])

      while domain != ''
        @cookie_jar[domain]&.each do |key, value|
          cookies[key] ||= value
        end
        domain = domain.gsub(/^([^.]+\.?)/, '')
      end

      cookies.map { |key, value| "#{key}=#{value}" }.join('; ')
    end

    def obtain_cookies(response)
      set_cookies_field = [response.headers['Set-Cookie']].compact

      set_cookies_field.each do |cookie|
        key, value = cookie.match(/^([^=]+)=(.+)/).to_a[1..]
        domain = cookie.match(/Domain=([^;]+)/)&.at(1)&.gsub(/^\./, '')

        domain = get_domain(response.request.url) if domain.nil
        set_cookie(domain, key, value)
      end
    end

    def add_cookies(host, key, value)
      domain = get_domain(host)
      @cookie_jar[domain] ||= {}
      @cookie_jar[domain][key] = value
    end

    private

    def set_cookie(domain, key, value)
      @cookie_jar[domain] ||= {}

      value = value.split(';').first

      if value == '""'
        @cookie_jar[domain].delete(key)
      else
        @cookie_jar[domain][key] = value
      end
    end

    def parse_cookie(string)
      cookies = {}

      if string.is_a?(String)
        string.split(';').each do |part|
          key, value = part.split('=')
          key.strip!
          cookies[key.strip] = value if value && !%w[Domain Path domain path].include?(key)
        end
      end

      cookies
    end
  end
end
