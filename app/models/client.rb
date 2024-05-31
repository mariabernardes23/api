class Client < ApplicationRecord
    validates :name, presence: true
    validates :sobrenome, presence: true
    validates :endereco, presence: true
end
