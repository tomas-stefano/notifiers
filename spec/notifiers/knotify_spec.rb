require 'spec_helper'

module Notifiers
  describe Knotify do
    it_should_behave_like 'a notifier'

    before do
      @knotify = Knotify.new
    end

    describe '.installed?' do
      context 'when is darwin platform' do
        before do
          expect(Knotify).to receive(:platform?).with(/(freebsd|linux)/).and_return(true)
        end

        context 'with dcop process' do
          before do
            expect(Knotify).to receive(:process?).with('dcop').and_return(true)
          end

          it 'returns true' do
            expect(Knotify).to be_installed
          end
        end

        context 'without dcop process' do
          before do
            expect(Knotify).to receive(:process?).with('dcop').and_return(false)
          end

          it 'returns false' do
            expect(Knotify).to_not be_installed
          end
        end
      end

      context 'when is not linux or bsd platform' do
        before do
          expect(Knotify).to receive(:platform?).with(/(freebsd|linux)/).and_return(false)
        end

        it 'returns false' do
          expect(Knotify).to_not be_installed
        end
      end
    end

    describe '#message' do
      it "should set the message instance variable" do
        @knotify.message('Bulls on Parade')
        expect(@knotify.instance_variable_get(:@message)).to eql 'Bulls on Parade'
      end

      it "should be possible to set the message instance variable" do
        @knotify.message('Wake Up')
        expect(@knotify.instance_variable_get(:@message)).to eql 'Wake Up'
      end
    end

    describe '#title' do
      it "should set the title" do
        @knotify.title('Rage Against the Machine')
        expect(@knotify.instance_variable_get(:@title)).to eql 'Rage Against the Machine'
      end

      it "should be possible to set the title" do
        @knotify.title('AudioSlave')
        expect(@knotify.instance_variable_get(:@title)).to eql 'AudioSlave'
      end
    end

    describe '#to_s' do
      it "should return the entire command" do
        command = @knotify.title('Ruby').message('For the Win').to_s
        expect(command).to eql "dcop knotify default notify eventname 'Ruby' 'For the Win' '' '' 12 1"
      end
    end
  end
end