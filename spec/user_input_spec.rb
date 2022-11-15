require_relative '../lib/chess'

class FakePlayer
  include UserInput
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end
end

describe UserInput do
  describe '#ask_coordinate' do
    let(:player) { FakePlayer.new('Joey', 'white') }
    let(:prompt_message) { "#{player.name} insert the coordinate of the piece you want to move: " }
    let(:invalid_coordinate_message) { 'That coordinate is not valid. Please try again: ' }

    context 'when the input is valid' do
      it 'stops the loop and returns the coordinate' do
        valid_input = 'a3'
        allow(player).to receive(:print).with(prompt_message)
        allow(player).to receive(:gets).and_return(valid_input)
        result = player.ask_coordinate(:start_square, player.name)

        expect(result).to eq('a3')
      end
    end

    context 'when the input is invalid twice and then valid' do
      it 'runs the loop 3 times' do
        invalid_input = ['a10', '22']
        valid_input = 'c5'
        allow(player).to receive(:gets).and_return(invalid_input[0], invalid_input[1], valid_input)

        expect(player).to receive(:print).with(prompt_message).once
        expect(player).to receive(:print).with(invalid_coordinate_message).twice
        player.ask_coordinate(:start_square, player.name)
      end
    end
  end
end
