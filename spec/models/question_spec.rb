require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it do
    should validate_length_of(:title).
      is_at_least(5).is_at_most(30)
  end
  it { should validate_length_of(:body).is_at_least(10) }
  it { should have_many(:answers).dependent(:destroy) }
end
