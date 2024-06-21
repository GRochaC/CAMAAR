class Questao < ApplicationRecord
  belongs_to :template
  has_one :tipo
  has_many :alternativas, dependent: :destroy,  class_name: "Alternativa"
  accepts_nested_attributes_for :alternativas, reject_if: :all_blank, allow_destroy: true

  validates :pergunta, presence: true
  validates :pontos, numericality: { greater_than_or_equal_to: 0 }
  validates :fatorDeCorrecao, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :alternativaCorreta, presence: true,  unless: -> { template.discursiva? }
end
