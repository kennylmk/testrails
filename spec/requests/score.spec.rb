require 'rails_helper'

describe'Score API', type: :request do
    describe 'POST /score' do
        it 'Create new score record' do
            post '/scores', params:{ 'player': 'testPost','score': '10','time': '2021/06/21 18:00'}
            expect(response).to have_http_status(:created)
        end
    end

    describe 'DELETE /scores/:id' do
        it 'delete a score' do
            score=FactoryBot.create(:score, player: 'testDelete', score:'10', time: '2021/06/10 00:00:00')
            delete "/scores/#{score.id}"
            expect(response).to have_http_status(:no_content)
        end
    end

    describe 'PUT /scores/:id' do
        it 'Update a score' do
            score=FactoryBot.create(:score, player: 'testPut', score:'1', time: '2021/06/01 00:00:00')
            put "/scores/#{score.id}", params: { score: {score: '2'}  }
            expect(response).to have_http_status(:no_content)
        end
    end

    describe 'List ' do
        it 'Get all scores by playerX' do
            FactoryBot.create(:score, player: 'testList', score:'1', time: '2021/06/01 00:00:00')
            get '/scores/list?player=TESTLIST'
            expect(response).to have_http_status(:ok)
        end
        it 'Get all score after 05 Jun 2021' do
            get '/scores/list?start=2021-06-06'
            expect(response).to have_http_status(:ok)
        end
        it 'Get all scores by player1, player2 and player3 before 06 Jun 2021' do
            FactoryBot.create(:score, player: 'testList1', score:'1', time: '2021/06/01 00:00:00')
            FactoryBot.create(:score, player: 'testList2', score:'1', time: '2021/06/01 00:00:00')
            get '/scores/list?player[]=testlist1&player[]=TESTLIST2&start=2021-06-06'
            expect(response).to have_http_status(:ok)
        end
        it 'Get all scores in between' do
            get '/scores/list?start=2021-06-05&end=2021-06-06'
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'History ' do
        it 'Top score' do
            FactoryBot.create(:score, player: 'testHistory', score:'1', time: '2021/06/01 00:00:00')
            FactoryBot.create(:score, player: 'testHistory', score:'2', time: '2021/06/03 00:00:00')
            get '/scores/list?query=top&player=testHistory'
            expect(response).to have_http_status(:ok)
        end
        it 'Low score' do
            FactoryBot.create(:score, player: 'testHistory', score:'0', time: '2021/06/04 00:00:00')
            FactoryBot.create(:score, player: 'testHistory', score:'5', time: '2021/06/13 00:00:00')
            get '/scores/list?query=top&player=testHistory'
            expect(response).to have_http_status(:ok)
        end
        it 'Average score' do
            FactoryBot.create(:score, player: 'testHistory', score:'1', time: '2021/06/01 00:00:00')
            FactoryBot.create(:score, player: 'testHistory', score:'2', time: '2021/06/03 00:00:00')
            FactoryBot.create(:score, player: 'testHistory', score:'0', time: '2021/06/04 00:00:00')
            FactoryBot.create(:score, player: 'testHistory', score:'5', time: '2021/06/13 00:00:00')
            get '/scores/list?query=average&player=testHistory'
            expect(response).to have_http_status(:ok)
        end
        it 'List of all the scores of a player' do
            FactoryBot.create(:score, player: 'testHistory', score:'1', time: '2021/06/01 00:00:00')
            FactoryBot.create(:score, player: 'testHistory', score:'2', time: '2021/06/03 00:00:00')
            FactoryBot.create(:score, player: 'testHistory', score:'0', time: '2021/06/04 00:00:00')
            FactoryBot.create(:score, player: 'testHistory', score:'5', time: '2021/06/13 00:00:00')
            get '/scores/list?player=testHistory'
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'GET /scores' do
        it 'returns all scores' do
            get '/scores'

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end
end