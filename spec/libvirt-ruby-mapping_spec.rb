require 'spec_helper'

describe Libvirt::Ruby do
  let(:libvirt) { Libvirt::Ruby }
  let(:p) { Object }

  context "#initialize" do
    before :each do
      libvirt.stub(:virInitialize).with(:int).and_return(true)
      libvirt.stub(:virInitialize).and_return(true)
    end

    after :each do
      libvirt.initialize
    end

    context "when the c function is not attached yet" do
      it "should attach it" do
        libvirt.should_receive(:virInitialize).with(:int)
      end
    end

    context "when the c function is already attached" do
      before :each do
        libvirt.stub(:respond_to_missing?).with(:virInitialize, false).and_return(true)
      end

      it "should not try to attach it again" do
        libvirt.should_not_receive(:virInitialize).with(:int)
      end
    end

    it "should call the attached c function" do
      libvirt.should_receive(:virInitialize)
    end
  end

  context "#version" do
    before :each do
      libvirt.stub(:virGetVersion).with(:pointer, :string, :pointer, :int).and_return(true)
      FFI::MemoryPointer.stub(:new).with(:ulong).and_return(p)
      libvirt.stub(:virGetVersion).with(p, nil, nil).and_return(true)
      p.stub(:get_ulong).with(0).and_return(8003)
    end

    context "when the c function is not attached yet" do
      it "should attach it" do
        libvirt.should_receive(:virGetVersion).with(:pointer, :string, :pointer, :int)
        libvirt.version
      end
    end

    context "when the c function is already attached" do
      before :each do
        libvirt.stub(:respond_to_missing?).with(:virGetVersion, false).and_return(true)
      end

      it "should not try to attach it again" do
        libvirt.should_not_receive(:virGetVersion).with(:pointer, :string, :pointer, :int)
        libvirt.version
      end
    end

    it "should return the version" do
      libvirt.version.should == "0.8.3"
    end
  end
end