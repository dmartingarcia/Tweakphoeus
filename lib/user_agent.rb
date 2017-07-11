module Tweakphoeus
  class UserAgent
    OS_DATA = {
      types: [:win, :linux, :mac],
      linux_distro: ["Ubuntu", "Debian", "Fedora", "gNewSense", "Linux Mint", "OpenSUSE", "Mandriva"],
      arch: ["x86", "x86_64"],
      win_arch: ["Win64; x64", "WOW64"]
    }

    class << self
      def random(systems: OS_DATA[:types])
        user_agent = "Mozilla/5.0 (#{os[systems.sample]}) #{browser}"
        firefox_version = user_agent.match(/Firefox\/([0-9\.]+)/).try(:[], 1)
        user_agent.gsub!(')', "; rv:#{firefox_version})") if firefox_version
        user_agent
      end

      private

      def os
        {
          win: "Windows NT #{%w(5 6 7 8 10).sample + '.' + %w(0 1).sample}",
          linux: "X11; #{["", OS_DATA[:linux_distro].sample+"; "].sample}Linux #{OS_DATA[:arch].sample}",
          mac: "Macintosh; Intel Mac OS X 10_#{Random.rand(9..12)}_#{Random.rand(0..5)}"
        }
      end

      def browser
        chrome_version = "Chrome/5#{Random.rand(0..9)}.0.#{Random.rand(1000..4000)}.#{Random.rand(100..900)}"
        webkit_603 = "603.#{Random.rand(0..9)}.#{Random.rand(0..9)}"
        ["Gecko/20100101 Firefox/#{Random.rand(40..54)}.#{Random.rand(0..9)}",
         "AppleWebKit/537.36 (KHTML, like Gecko) #{chrome_version} Safari/537.36",
         "AppleWebKit/#{webkit_603} (KHTML, like Gecko) Version/10.1 #{chrome_version} Safari/#{webkit_603}"
        ].sample
      end
    end
  end
end
