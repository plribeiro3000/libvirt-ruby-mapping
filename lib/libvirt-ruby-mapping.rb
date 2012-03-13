require "libvirt-ruby-mapping/version"

module Libvirt
  module Ruby
    autoload :Connect, 'libvirt-ruby-mapping/connect'

    def self.initialize
      virInitialize(:int) unless respond_to?(:virInitialize)
      virInitialize
    end

    def self.version
      virGetVersion(:pointer, :string, :pointer, :int) unless respond_to?(:virGetVersion)
      p = FFI::MemoryPointer.new(:ulong)
      virGetVersion(p, nil, nil)
      version = p.get_ulong(0)
      "#{version / 1_000_000}.#{(version % 1_000_000) / 1_000}.#{(version % 1_000_000) %1000}"
    end
  end
end