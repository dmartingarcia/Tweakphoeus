require 'spec_helper'

describe Tweakphoeus do
  it 'has a version number' do
    expect(Tweakphoeus::VERSION).not_to be nil
  end

  [:get, :post, :put, :delete, :head, :patch, :options].each do |name|
    describe ".#{name}" do
      let(:response) { Typhoeus::Request.method(name).call("http://localhost:8080/") }

      it "returns ok" do
        expect(response.return_code).to eq(:ok)
      end

      unless name == :head
        it "makes #{name.to_s.upcase} requests" do
          expect(response.response_body).to include("#{name.to_s.upcase} /")
        end
      end
    end
  end
end
