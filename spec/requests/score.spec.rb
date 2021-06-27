require 'rails_helper'

describe'Score API', type: :request do
    describe 'GET /scores' do
        it 'returns all scores' do
            # FactoryBot.create(:score, player:'kenny3', score:'10')
            get '/scores'

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /score' do
        it 'Create new score record' do
            expect {
                post '/scores', params:{ score: {'player': 'kenny2',
                'score': '10',
                'time': '2021/06/21 18:00'}}
            }.to change { score.count }.from(0).to(1)
            expect(response).to have_http_status(:created)
        end
    end

    describe 'DELETE /scores/:id' do
        it 'delete a score' do
            score=FactoryBot.create(:score, player: 'kenny0', score:'10', time: '2021/06/10 00:00:00')
            delete "/scores/#{score.id}"
            expect(response).to have_http_status(:no_content)
        end
    end
end