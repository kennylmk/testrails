class Score < ApplicationRecord
    validates :player, :score, :time, presence:true
end
