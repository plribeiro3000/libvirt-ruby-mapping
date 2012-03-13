require 'spec_helper'

describe Libvirt::Ruby::Connect do
  let(:connect) { Libvirt::Ruby::Connect }
  let(:p) { Object }

  context "#open_read_only" do
    before :each do
      connect.stub(:virConnectOpenReadOnly).with(:string, :pointer).and_return(true)
      connect.stub(:virConnectOpenReadOnly).with("uri").and_return(p)
    end

    after :each do
      connect.open_read_only("uri")
    end

    context "when virConnectOpenReadOnly is not attached yet" do
      it "should attach it" do
        connect.should_receive(:virConnectOpenReadOnly).with(:string, :pointer)
      end
    end

    context "when virConnectOpenReadOnly is already attached" do
      before :each do
        connect.stub(:respond_to_missing?).with(:virConnectOpenReadOnly, false).and_return(true)
      end

      it "should not try to attach it again" do
        connect.should_not_receive(:virConnectOpenReadOnly).with(:string, :pointer)
      end
    end

    it "should call virConnectOpenReadOnly" do
      connect.should_receive(:virConnectOpenReadOnly)
    end

    it "should return the pointer to the new read only connection" do
      connect.open_read_only("uri").should == p
    end
  end
end