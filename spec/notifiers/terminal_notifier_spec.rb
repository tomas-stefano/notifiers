# frozen_string_literal: true

require 'spec_helper'

module Notifiers
  describe TerminalNotifier do
    it_should_behave_like 'a notifier'

    before do
      @terminal_notifier = terminal_notifier
    end

    describe '.installed?' do
      context 'when is darwin platform' do
        before do
          expect(TerminalNotifier).to receive(:platform?).with(/darwin/).and_return(true)
        end

        context 'with terminal-notifier installed' do
          before do
            expect(TerminalNotifier).to receive(:command?).with('terminal-notifier').and_return(true)
          end

          it 'returns true' do
            expect(TerminalNotifier).to be_installed
          end
        end

        context 'without terminal-notifier installed' do
          before do
            expect(TerminalNotifier).to receive(:command?).with('terminal-notifier').and_return(false)
          end

          it 'returns false' do
            expect(TerminalNotifier).to_not be_installed
          end
        end
      end

      context 'when is not darwin platform' do
        before do
          expect(TerminalNotifier).to receive(:platform?).with(/darwin/).and_return(false)
        end

        it 'returns false' do
          expect(TerminalNotifier).to_not be_installed
        end
      end
    end

    describe '#image' do
      it 'sets the icon' do
        @terminal_notifier.image('my_image.png')
        expect(@terminal_notifier.instance_variable_get(:@icon)).to eql 'my_image.png'
      end
    end

    describe '#message' do
      it 'sets the message' do
        @terminal_notifier.message('Hello World!')
        expect(@terminal_notifier.instance_variable_get(:@message)).to eql 'Hello World!'
      end
    end

    describe '#title' do
      it 'sets the title' do
        @terminal_notifier.title('My App')
        expect(@terminal_notifier.instance_variable_get(:@title)).to eql 'My App'
      end
    end

    describe '#sound' do
      it 'sets the sound' do
        @terminal_notifier.sound('default')
        expect(@terminal_notifier.instance_variable_get(:@sound)).to eql 'default'
      end

      it 'sets a custom sound' do
        @terminal_notifier.sound('Ping')
        expect(@terminal_notifier.instance_variable_get(:@sound)).to eql 'Ping'
      end
    end

    describe '#group' do
      it 'sets the group' do
        @terminal_notifier.group('my-group')
        expect(@terminal_notifier.instance_variable_get(:@group)).to eql 'my-group'
      end
    end

    describe '#open' do
      it 'sets the url to open' do
        @terminal_notifier.open('https://example.com')
        expect(@terminal_notifier.instance_variable_get(:@open)).to eql 'https://example.com'
      end
    end

    describe '#execute' do
      it 'sets the command to execute' do
        @terminal_notifier.execute('open .')
        expect(@terminal_notifier.instance_variable_get(:@execute)).to eql 'open .'
      end
    end

    describe '#to_s' do
      it 'constructs the command with title and message' do
        command = @terminal_notifier.title('Test').message('Hello World!').to_s
        expect(command).to eql "terminal-notifier -title 'Test' -message 'Hello World!'"
      end

      it 'constructs the command with image and sound' do
        command = @terminal_notifier.message('Alert').image('icon.png').sound('default').to_s
        expect(command).to eql "terminal-notifier -message 'Alert' -contentImage 'icon.png' -sound 'default'"
      end

      it 'constructs the command with group and open' do
        command = @terminal_notifier.message('Click me').group('notifications').open('https://example.com').to_s
        expect(command).to eql "terminal-notifier -message 'Click me' -group 'notifications' -open 'https://example.com'"
      end

      it 'constructs the command with execute' do
        command = @terminal_notifier.message('Run').execute('open .').to_s
        expect(command).to eql "terminal-notifier -message 'Run' -execute 'open .'"
      end
    end

    describe '#install_instructions' do
      it 'returns installation instructions' do
        expect(@terminal_notifier.install_instructions).to eq 'terminal-notifier is not installed. Install with: brew install terminal-notifier'
      end
    end
  end
end
