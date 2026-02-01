# frozen_string_literal: true

require 'spec_helper'

module Notifiers
  describe Osascript do
    it_should_behave_like 'a notifier'

    before do
      @osascript = osascript
    end

    describe '.installed?' do
      context 'when is darwin platform' do
        before do
          expect(Osascript).to receive(:platform?).with(/darwin/).and_return(true)
        end

        context 'with osascript installed' do
          before do
            expect(Osascript).to receive(:command?).with('osascript').and_return(true)
          end

          it 'returns true' do
            expect(Osascript).to be_installed
          end
        end

        context 'without osascript installed' do
          before do
            expect(Osascript).to receive(:command?).with('osascript').and_return(false)
          end

          it 'returns false' do
            expect(Osascript).to_not be_installed
          end
        end
      end

      context 'when is not darwin platform' do
        before do
          expect(Osascript).to receive(:platform?).with(/darwin/).and_return(false)
        end

        it 'returns false' do
          expect(Osascript).to_not be_installed
        end
      end
    end

    describe '#message' do
      it 'sets the message' do
        @osascript.message('Hello World!')
        expect(@osascript.instance_variable_get(:@message)).to eql 'Hello World!'
      end
    end

    describe '#title' do
      it 'sets the title' do
        @osascript.title('My App')
        expect(@osascript.instance_variable_get(:@title)).to eql 'My App'
      end
    end

    describe '#subtitle' do
      it 'sets the subtitle' do
        @osascript.subtitle('Additional info')
        expect(@osascript.instance_variable_get(:@subtitle)).to eql 'Additional info'
      end
    end

    describe '#sound' do
      it 'sets the sound' do
        @osascript.sound('default')
        expect(@osascript.instance_variable_get(:@sound)).to eql 'default'
      end

      it 'sets a custom sound' do
        @osascript.sound('Glass')
        expect(@osascript.instance_variable_get(:@sound)).to eql 'Glass'
      end
    end

    describe '#to_s' do
      it 'constructs the command with message only' do
        command = @osascript.message('Hello World!').to_s
        expect(command).to eql "osascript -e 'display notification \"Hello World!\"'"
      end

      it 'constructs the command with title and message' do
        command = @osascript.title('Test').message('Hello World!').to_s
        expect(command).to eql "osascript -e 'display notification \"Hello World!\" with title \"Test\"'"
      end

      it 'constructs the command with subtitle' do
        command = @osascript.title('Test').subtitle('Info').message('Hello').to_s
        expect(command).to eql "osascript -e 'display notification \"Hello\" with title \"Test\" subtitle \"Info\"'"
      end

      it 'constructs the command with sound' do
        command = @osascript.message('Alert').sound('Glass').to_s
        expect(command).to eql "osascript -e 'display notification \"Alert\" sound name \"Glass\"'"
      end

      it 'constructs the full command' do
        command = @osascript.title('App').subtitle('Status').message('Done').sound('default').to_s
        expect(command).to eql "osascript -e 'display notification \"Done\" with title \"App\" subtitle \"Status\" sound name \"default\"'"
      end
    end

    describe '#install_instructions' do
      it 'returns empty string since osascript is built-in' do
        expect(@osascript.install_instructions).to eq ''
      end
    end
  end
end
