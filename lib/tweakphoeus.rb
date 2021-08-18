# frozen_string_literal: true

require 'tweakphoeus/version'
require 'tweakphoeus/user_agent'
require 'typhoeus'

module Tweakphoeus
  # Http client class
  class Client
    attr_accessor :cookie_jar, :referer_list, :base_headers, :redirect
    attr_reader :ssl_verifypeer

    def initialize(ua_systems: %i[linux mac], ssl_verifypeer: true, redirect: false)
      @cookie_jar = Tweakphoeus::CookieJar.new
      @referer_list = Tweakphoeus::RefererList.new
      @redirect = redirect
      @base_headers = build_base_headers(ua_systems)
      @proxy = nil
      @proxyuserpwd = nil
      @ssl_verifypeer = ssl_verifypeer
    end

    def get(url, body: nil, params: nil, headers: nil)
      referer_from_headers(headers)
      http_request(url, body: body, params: params, headers: headers, method: :get)
    end

    def delete(url, body: nil, headers: nil)
      referer_from_headers(headers)
      http_request(url, body: body, headers: headers, method: :delete)
    end

    def post(url, body: nil, headers: nil)
      referer_from_headers(headers)
      http_request(url, body: body, headers: headers, method: :post)
    end

    def set_proxy(url, auth = nil)
      @proxyuserpwd = "#{auth[:user]}:#{auth[:password]}" if auth.is_a?(Hash)
      @proxy = url
    end

    def unset_proxy
      @proxyuserpwd = nil
      @proxy = nil
    end

    private

    def http_request(url, body: nil, params: nil, headers: nil, method: :get)
      response = Typhoeus.send(method, url, body: body, params: params, headers: build_request_headers(headers),
                                            proxy: @proxy, proxyuserpwd: @proxyuserpwd, ssl_verifypeer: ssl_verifypeer)

      @cookie_jar.obtain_cookies(response)
      @referer_list.push_referer(url) if method != :post

      return process_redirect(response) if redirect && redirect?(response)

      response
    end

    def build_request_headers(headers)
      request_headers = merge_default_headers(headers)
      request_headers['Cookie'] = @cookie_jar.cookie_string(url, headers)
      request_headers['Referer'] = @referer_list.last_referer
    end

    def process_redirect(response)
      if response.code != 307
        method = :get
        body = nil
      end

      http_request(redirect_url(response), body: body, headers: headers,
                                           redirect: redirect, method: method, ssl_verifypeer: ssl_verifypeer)
    end

    def build_base_headers(ua_systems)
      {
        'User-Agent' => UserAgent.random(systems: ua_systems),
        'Accept-Language' => 'es-ES,es;q=0.9,en;q=0.8',
        'Accept-Encoding' => '',
        'Connection' => 'keep-alive'
      }
    end

    def merge_default_headers(headers)
      headers ? @base_headers.merge(headers) : @base_headers
    end

    def redirect?(response)
      !redirect_url(response).nil?
    end

    def redirect_url(response)
      response.headers['Location']
    end
  end
end
