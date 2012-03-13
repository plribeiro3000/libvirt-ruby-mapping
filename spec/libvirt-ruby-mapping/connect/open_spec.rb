require 'spec_helper'

describe Libvirt::Ruby::Connect do
  let(:connect) { Libvirt::Ruby::Connect }
  let(:p) { Object }

  context "#open" do
    before :each do
      connect.stub(:virConnectOpen).with(:string, :pointer).and_return(true)
      connect.stub(:virConnectOpen).with("uri").and_return(p)
    end

    after :each do
      connect.open("uri")
    end

    context "when virConnectOpen is not attached yet" do
      it "should attach it" do
        connect.should_receive(:virConnectOpen).with(:string, :pointer)
      end
    end

    context "when virConnectOpen is already attached" do
      before :each do
        connect.stub(:respond_to_missing?).with(:virConnectOpen, false).and_return(true)
      end

      it "should not try to attach it again" do
        connect.should_not_receive(:virConnectOpen).with(:string, :pointer)
      end
    end

    it "should call virConnectOpen" do
      connect.should_receive(:virConnectOpen)
    end

    it "should return the pointer to the new connection" do
      connect.open("uri").should == p
    end
  end
end