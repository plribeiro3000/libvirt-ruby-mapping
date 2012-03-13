module Libvirt
  module Ruby
    module Connect
      extend Libvirt::Ruby

      def self.open(uri)
        virConnectOpen(:string, :pointer) unless respond_to?(:virConnectOpen)
        virConnectOpen(uri)
      end

      def self.open_read_only(uri)
        virConnectOpenReadOnly(:string, :pointer) unless respond_to?(:virConnectOpenReadOnly)
        virConnectOpenReadOnly(uri)
      end
    end
  end
end