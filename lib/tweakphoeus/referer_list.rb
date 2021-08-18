# frozen_string_literal: true

module Tweakphoeus
  # RefererList class handle referer logic for Referer header in requests
  class RefererList
    def initialize
      @referer = []
    end

    def push_referer(url)
      @referer << url
    end

    def pop_referer
      @referer.pop || ''
    end

    def last_referer
      @referer.last
    end

    def referer_from_headers(headers)
      @referer.last.replace(headers['Referer']) if headers && headers['Referer'].is_a?(String)
    end
  end
end
