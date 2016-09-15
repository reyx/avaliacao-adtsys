class Model < ActiveRecord::Base
    validates :name, :make_id, presence: true
end
