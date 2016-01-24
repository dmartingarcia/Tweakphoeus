require "tweakphoeus/version"
require "typhoeus"

module Tweakphoeus
  class Client
    attr_accessor :cookie_jar

    def initialize()
      @cookie_jar = {}
      @referer = [""]
      @base_headers = {
        "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:42.0) Gecko/20100101 Firefox/42.0",
        "Accept-Language" => "es-ES,es;q=0.8,en-US;q=0.5,en;q=0.3",
        "Accept-Encoding" => "",
        "DNT" => "1",
        "Connection" => "keep-alive"
      }
    end

    def get(url, body: nil, headers: nil, redirect: true)
      set_referer_from_headers(headers)
      http_request(url, body: body, headers: headers, redirect: redirect, method: :get)
    end

    def post(url, body: nil, headers: nil, redirect: false)
      set_referer_from_headers(headers)
      http_request(url, body: body, headers: headers, redirect: redirect, method: :post)
    end

    def get_hide_inputs response
      #TODO
    end

    def add_cookies host, key, value
      domain = get_domain(host)
      @cookie_jar[domain] ||= {}
      @cookie_jar[domain][key] = value
    end

    def get_domain domain
      domain.match(/([a-zA-Z0-9]+:\/\/|)([^\/]+)/)[2].gsub(/^\./,'')
    end

    def push_referer url = ""
      @referer << url
      url
    end

    def pop_referer
      @referer.pop
    end

    def get_referer
      @referer.last
    end

    private

    def http_request(url, body: nil, headers: nil, redirect: false, method: method)
      request_headers = @base_headers
      request_headers["Cookie"] = inject_cookies(url, headers)
      request_headers["Referer"] = get_referer
      response = Typhoeus.send(method, url, body: body, headers: request_headers)
      obtain_cookies(response)
      set_referer(url) if method != :post
      if redirect && has_redirect?(response)
        if response.code != 307
          method = :get
          body = nil
        end
        response = http_request(redirect_url(response),
                                body: body,
                                headers: headers,
                                redirect: redirect,
                                method: method)
      end
      response
    end

    def obtain_cookies response
      set_cookies_field = response.headers["Set-Cookie"]
      return if set_cookies_field.nil?
      if set_cookies_field.is_a?(String)
        set_cookies_field = [response.headers["Set-Cookie"]]
      end

      set_cookies_field.each do |cookie|
        key, value = cookie.match(/^([^=]+)=(.+)/).to_a[1..-1]
        domain = cookie.match(/Domain=([^;]+)/)

        if domain.nil?
          domain = get_domain(response.request.url)
        else
          domain = domain[1].gsub(/^\./,'')
        end

        if value != "\"\""
          @cookie_jar[domain] ||= {}
          @cookie_jar[domain][key] = value.split(';').first
        end
      end
    end

    def inject_cookies url, headers
      domain = get_domain(url)
      headers ||= {}
      cookies = parse_cookie(headers["Cookie"])

      while domain.split(".").count > 1
        if @cookie_jar[domain]
          cookies = @cookie_jar[domain].merge(cookies)
        end
        domain = domain.split(".")[1..-1].join(".")
      end

      cookies.map{|k,v| "#{k}=#{v}"}.join('; ')
    end

    def parse_cookie cookie_string
      cookies = {}

      if cookie_string.is_a?(String)
        cookie_string.split(';').each do |string|
          key, value = string.split('=')
          key.strip!
          cookies[key.strip] = value if value && !["Domain","Path","domain","path"].include?(key)
        end
      end

      cookies
    end

    def has_redirect? response
      !redirect_url(response).nil?
    end

    def redirect_url response
      response.headers["Location"]
    end

    def purge_bad_cookies cookies
      cookies.reject{|e| e.first.last=="\"\""}
    end

    def set_referer_from_headers headers
      if headers && headers["Referer"].is_a?(String)
        @referer.last.replace headers["Referer"]
      end
    end

    def set_referer url
      @referer.last.replace url
    end

  end
end
