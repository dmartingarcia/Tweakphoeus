# frozen_string_literal: true

module Tweakphoeus
  # Helper functions for common behavious across all classes
  module Helpers
    def get_domain(domain)
      domain.match(%r{([a-zA-Z0-9]+://|)([^/]+)})[2].gsub(/^\./, '')
    end
  end
end
