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

    describe 'PUT /scores/:id' do
        it 'Update a score' do
            score=FactoryBot.create(:score, player: 'kenny0', score:'1', time: '2021/06/01 00:00:00')
            put "/scores/#{score.id}", params: { score: {score: '2'}  }
            expect(response).to have_http_status(:no_content)
        end
    end

    describe 'List ' do
        it 'Get all scores by playerX' do
            get '/scores/list?player=kenny2'
            expect(response).to have_http_status(:ok)
        end
        it 'Get all score after 05 Jun 2021' do
            get '/scores/list?start=2021-06-06'
            expect(response).to have_http_status(:ok)
        end
        it 'Get all scores by player1, player2 and player3 before 06 Jun 2021' do
            get '/scores/list?player[]=kenny&player[]=kenny2&start=2021-06-06'
            expect(response).to have_http_status(:ok)
        end
        it 'Get all scores in between' do
            get '/scores/list?start=2021-06-05&end=2021-06-06'
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'History ' do
        it 'Top score' do
            get '/scores/list?query=top&player=kenny2'
            expect(response).to have_http_status(:ok)
        end
        it 'Low score' do
            get '/scores/list?query=low&player=kenny2'
            expect(response).to have_http_status(:ok)
        end
        it 'Average score' do
            get '/scores/list?query=average&player=kenny2'
            expect(response).to have_http_status(:ok)
        end
        it 'List of all the scores of a player' do
            get '/scores/list?player=kenny2'
            expect(response).to have_http_status(:ok)
        end
    end
end