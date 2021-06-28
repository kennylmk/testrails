class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :update, :destroy]

  skip_before_action :verify_authenticity_token
  def index 
    @scores=Score.all
  
    json_response(@scores)
    # render json: {status: 'SUCCESS', message: 'Loaded', data: hash}

  end

  def new
    @score = Score.new
  end

  # POST /scores
  def create
    @score = Score.create!(score_params)
    json_response(@score,:created)
  end
\
  def show
    json_response(@score)
  end

  # PUT /scores/:id
  def update
    @score.update(score_params)
    head :no_content
  end

  # DELETE /scores/:id
  def destroy
    @score.destroy
    json_response(@score)

    head :no_content
  end

  def list
    # "Get all scores by playerX"
    # "Get all score after 1st November 2020"
    # "Get all scores by player1, player2 and player3 before 1st december 2020"
    # "Get all scores after 1 Jan 2020 and before 1 Jan 2021"

    per_page=2
    unless params[:players].blank?
      players = params[:players]
      @scores=Score.select('score').where(player:players)
    end
    if params.has_key?(:player) 
      request.query_parameters.each do |key,value|
        if key =='player'
          @scores = @scores ? @scores.select('score').where(player:value.to_s) :  Score.select('score').where(player:value.to_s)
        end
      end
    end
    if params.has_key?(:start)
      request.query_parameters.each do |key,value|
        if key=="start"
          startDate = DateTime.parse(value).strftime('%Y-%m-%d')
          @str="STRFTIME('%Y-%m-%d',time) => :"+startDate
          @strVal=startDate
          @scores =  @scores ? @scores.select('score').where("STRFTIME('%Y-%m-%d',time) >= ? ",startDate) : Score.select('score').where("STRFTIME('%Y-%m-%d',time) >= ? ",startDate)
        end
      end
    end
    if params.has_key?(:end)
      request.query_parameters.each do |key,value|
        if key=="end"
          endDate = DateTime.parse(value).strftime('%Y-%m-%d')
          @scores=@scores ? @scores.select('score').where("STRFTIME('%Y-%m-%d',time) <= ? ",endDate) : @scores=Score.select('score').where("STRFTIME('%Y-%m-%d',time) <= ? ",endDate)
        end
      end
    end
    total_count= @scores.count
    @scores=@scores.page(params[:page]||1).per(per_page)
    render json: { scores: @scores, meta: { records: total_count, per_page: per_page } }
  end

  def history
    # top score (time and score) which the best ever score of the player.
    # # low score (time and score) worst score of the player.
    # # average score value for player
    # # list of all the scores (time and score) of this player.

    if params.has_key?(:query) && params[:query]=="top"
      request.query_parameters.each do |key,value|
        if key != "top"
          if key =='player'
            @scores = Score.select('score','time').where(player:value.to_s).order("score DESC").first
          end
        end
      end
    elsif params.has_key?(:query) && params[:query]=="low"
      request.query_parameters.each do |key,value|   
        if key != "low"     
          if key =='player'
            @scores = Score.select('score','time').where(player:value.to_s).order("score asc").first
          end
        end
      end
    elsif params.has_key?(:query) && params[:query]=="average"
      request.query_parameters.each do |key,value|
        if key != "average"
          if key =='player'
            @scores = Score.where(player:value.to_s).order("score asc").average('score')
          end
        end
      end
    elsif params.has_key?(:player) 
      request.query_parameters.each do |key,value|
        @scores = Score.select('score','time').where(player:value.to_s)
      end
    end
    json_response(@scores)
  end

  private
  def score_params
    params.permit(:player, :score, :time,:start_date, :end_date,:query,:page)
    # params.require(:score).permit(:player, :score, :time)
  end

  def set_score
    @score = Score.find(params[:id])
  end
end