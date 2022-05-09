class Comment < ApplicationRecord
    belongs_to :article
    belongs_to :user
    validates :comment, presence:true, :length =>{minimum: 2,maximum: 50}
end
