require 'spec_helper'

describe Libvirt::Ruby::Connect do
  let(:connect) { Libvirt::Ruby::Connect }
  let(:p) { Object }

  context "#close" do
    before :each do
      connect.stub(:virConnectClose).with(:pointer, :int).and_return(true)
      connect.stub(:virConnectClose).with(p).and_return(0)
    end

    after :each do
      connect.close(p)
    end

    context "when virConnectClose is not attached yet" do
      before :each do
        connect.stub(:respond_to?).with(:virConnectClose).and_return(false)
      end

      it "should attach it" do
        connect.should_receive(:virConnectClose).with(:pointer, :int)
      end
    end

    context "when virConnectClose is already attached" do
      before :each do
        connect.stub(:respond_to?).with(:virConnectClose).and_return(true)
      end

      it "should not try to attach it again" do
        connect.should_not_receive(:virConnectClose).with(:pointer, :int)
      end
    end

    it "should call virConnectClose" do
      connect.should_receive(:virConnectClose)
    end

    it "should return a the response of the close method" do
      connect.close(p).should == 0
    end
  end
end