# frozen_string_literal: true

require 'spec_helper'

module Notifiers
  describe NotifySend do
    it_should_behave_like 'a notifier'

    before do
      @notify_send = notify_send
    end

    describe '.installed?' do
      context 'when is linux or freebsd platform' do
        before do
          expect(NotifySend).to receive(:platform?).with(/(freebsd|linux)/).and_return(true)
        end

        context 'with notify-send installed' do
          before do
            expect(NotifySend).to receive(:command?).with('notify-send').and_return(true)
          end

          it 'returns true' do
            expect(NotifySend).to be_installed
          end
        end

        context 'without notify-send installed' do
          before do
            expect(NotifySend).to receive(:command?).with('notify-send').and_return(false)
          end

          it 'returns false' do
            expect(NotifySend).to_not be_installed
          end
        end
      end

      context 'when is not linux or freebsd platform' do
        before do
          expect(NotifySend).to receive(:platform?).with(/(freebsd|linux)/).and_return(false)
        end

        it 'returns false' do
          expect(NotifySend).to_not be_installed
        end
      end
    end

    describe '#image' do
      it 'sets the image' do
        @notify_send.image('my_image.png')
        expect(@notify_send.instance_variable_get(:@icon)).to eql 'my_image.png'
      end

      it 'sets the icon option' do
        @notify_send.image('homer_simpson.png')
        expect(@notify_send.instance_variable_get(:@icon)).to eql 'homer_simpson.png'
      end
    end

    describe '#message' do
      it 'sets the message' do
        @notify_send.message('Oh Donuts!')
        expect(@notify_send.instance_variable_get(:@message)).to eql 'Oh Donuts!'
      end

      it 'sets the message option' do
        @notify_send.message('Duff Beer')
        expect(@notify_send.instance_variable_get(:@message)).to eql 'Duff Beer'
      end
    end

    describe '#title' do
      it 'sets the title' do
        @notify_send.title('W00T!!')
        expect(@notify_send.instance_variable_get(:@title)).to eql 'W00T!!'
      end

      it 'sets a title as instance variable' do
        @notify_send.title('Joker Owned Batman!')
        expect(@notify_send.instance_variable_get(:@title)).to eql 'Joker Owned Batman!'
      end
    end

    describe '#urgency' do
      it 'sets the urgency instance variable to low' do
        @notify_send.urgency(:low)
        expect(@notify_send.instance_variable_get(:@urgency)).to eql 'low'
      end

      it 'sets the urgency instance variable to normal' do
        @notify_send.urgency(:normal)
        expect(@notify_send.instance_variable_get(:@urgency)).to eql 'normal'
      end

      it 'sets the urgency to critical' do
        @notify_send.urgency(:critical)
        expect(@notify_send.instance_variable_get(:@urgency)).to eql 'critical'
      end
    end

    describe '#expire_time' do
      it 'sets the expire time' do
        @notify_send.expire_time(1000)
        expect(@notify_send.instance_variable_get(:@expire_time)).to eql 1000
      end

      it 'sets the expire time in milliseconds' do
        @notify_send.expire_time(2000)
        expect(@notify_send.instance_variable_get(:@expire_time)).to eql 2000
      end
    end

    describe '#hint' do
      it 'sets the hint' do
        @notify_send.hint([:string, :me, :yeah])
        expect(@notify_send.instance_variable_get(:@hint)).to eql 'string:me:yeah'
      end

      it 'sets the hint in int' do
        @notify_send.hint([:int, :me, 1])
        expect(@notify_send.instance_variable_get(:@hint)).to eql 'int:me:1'
      end
    end

    describe '#category' do
      it 'sets the category' do
        @notify_send.category('email')
        expect(@notify_send.instance_variable_get(:@category)).to eql 'email'
      end
    end

    describe '#to_s' do
      it 'transforms in a command' do
        command = @notify_send.title('Inception').message('3 levels').image('my_image.png').to_s
        expect(command).to eql "notify-send --icon=my_image.png 'Inception' '3 levels'"
      end

      it 'transforms in a command with hint and expire_time' do
        command = @notify_send.title('Joker').message('Haha ha!').expire_time(1000).hint([:string, :me, :woot]).to_s
        expect(command).to eql "notify-send --expire-time=1000 --hint=string:me:woot 'Joker' 'Haha ha!'"
      end

      it 'transforms in a command with urgency' do
        command = @notify_send.title('Batman').urgency(:critical).to_s
        expect(command).to eql "notify-send --urgency=critical 'Batman'"
      end

      it 'transforms in a command with category' do
        command = @notify_send.title('Mail').message('New email').category('email').to_s
        expect(command).to eql "notify-send --category=email 'Mail' 'New email'"
      end
    end

    describe '#install_instructions' do
      it 'returns installation instructions' do
        expect(@notify_send.install_instructions).to eq 'notify-send is not installed. Install libnotify for your distribution.'
      end
    end
  end
end