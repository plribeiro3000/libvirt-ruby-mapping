module Libvirt
  module Ruby
    module Connect
      extend Libvirt::Ruby

      def self.open(uri)
        virConnectOpen(:string, :pointer) unless respond_to_missing?(:virConnectOpen, false)
        virConnectOpen(uri)
      end
    end
  end
end