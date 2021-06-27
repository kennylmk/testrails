require 'rails_helper'
describe'Score Model', type: :model do
    describe 'validations' do
        it 'accept a valid score' do
            score = Score.new('player': 'test', 'score':'6', 'time': '2021/06/14 00:00:00')
            expect(score.save).to be(true)
        end
        it 'validates presence of player' do
            score = Score.new('score':'6', 'time': '2021/06/14 00:00:00')
            expect(score.save).to be(false)
        end
        it 'validates presence of score' do
            score = Score.new('player': 'test', 'time': '2021/06/14 00:00:00')
            expect(score.save).to be(false)
        end
        it 'validates presence of time' do
            score = Score.new('player': 'test', 'score':'6')
            expect(score.save).to be(false)
        end
    end
end