# frozen_string_literal: true

require 'spec_helper'

module Notifiers
  describe Dunstify do
    it_should_behave_like 'a notifier'

    before do
      @dunstify = dunstify
    end

    describe '.installed?' do
      context 'when is linux or freebsd platform' do
        before do
          expect(Dunstify).to receive(:platform?).with(/(freebsd|linux)/).and_return(true)
        end

        context 'with dunstify installed' do
          before do
            expect(Dunstify).to receive(:command?).with('dunstify').and_return(true)
          end

          it 'returns true' do
            expect(Dunstify).to be_installed
          end
        end

        context 'without dunstify installed' do
          before do
            expect(Dunstify).to receive(:command?).with('dunstify').and_return(false)
          end

          it 'returns false' do
            expect(Dunstify).to_not be_installed
          end
        end
      end

      context 'when is not linux or freebsd platform' do
        before do
          expect(Dunstify).to receive(:platform?).with(/(freebsd|linux)/).and_return(false)
        end

        it 'returns false' do
          expect(Dunstify).to_not be_installed
        end
      end
    end

    describe '#image' do
      it 'sets the icon' do
        @dunstify.image('my_image.png')
        expect(@dunstify.instance_variable_get(:@icon)).to eql 'my_image.png'
      end
    end

    describe '#message' do
      it 'sets the message' do
        @dunstify.message('Hello World!')
        expect(@dunstify.instance_variable_get(:@message)).to eql 'Hello World!'
      end
    end

    describe '#title' do
      it 'sets the title' do
        @dunstify.title('My App')
        expect(@dunstify.instance_variable_get(:@title)).to eql 'My App'
      end
    end

    describe '#urgency' do
      it 'sets the urgency to low' do
        @dunstify.urgency(:low)
        expect(@dunstify.instance_variable_get(:@urgency)).to eql 'low'
      end

      it 'sets the urgency to normal' do
        @dunstify.urgency(:normal)
        expect(@dunstify.instance_variable_get(:@urgency)).to eql 'normal'
      end

      it 'sets the urgency to critical' do
        @dunstify.urgency(:critical)
        expect(@dunstify.instance_variable_get(:@urgency)).to eql 'critical'
      end
    end

    describe '#timeout' do
      it 'sets the timeout' do
        @dunstify.timeout(5000)
        expect(@dunstify.instance_variable_get(:@timeout)).to eql 5000
      end
    end

    describe '#action' do
      it 'sets the action' do
        @dunstify.action('open,Open File')
        expect(@dunstify.instance_variable_get(:@action)).to eql 'open,Open File'
      end
    end

    describe '#replace' do
      it 'sets the replace id' do
        @dunstify.replace(123)
        expect(@dunstify.instance_variable_get(:@replace)).to eql 123
      end
    end

    describe '#to_s' do
      it 'constructs the command with title and message' do
        command = @dunstify.title('Test').message('Hello World!').to_s
        expect(command).to eql "dunstify 'Test' 'Hello World!'"
      end

      it 'constructs the command with urgency and timeout' do
        command = @dunstify.title('Alert').message('Important').urgency(:critical).timeout(10000).to_s
        expect(command).to eql "dunstify -u 'critical' -t '10000' 'Alert' 'Important'"
      end

      it 'constructs the command with icon' do
        command = @dunstify.title('App').message('Done').image('icon.png').to_s
        expect(command).to eql "dunstify -i 'icon.png' 'App' 'Done'"
      end

      it 'constructs the command with replace' do
        command = @dunstify.title('Update').message('Progress').replace(42).to_s
        expect(command).to eql "dunstify -r '42' 'Update' 'Progress'"
      end

      it 'constructs the command with action' do
        command = @dunstify.title('File').message('Click to open').action('open,Open').to_s
        expect(command).to eql "dunstify -A 'open,Open' 'File' 'Click to open'"
      end
    end

    describe '#install_instructions' do
      it 'returns installation instructions' do
        expect(@dunstify.install_instructions).to eq 'dunstify is not installed. Install dunst notification daemon for your distribution.'
      end
    end
  end
end
