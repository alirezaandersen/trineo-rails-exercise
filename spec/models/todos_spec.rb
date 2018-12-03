require 'rails_helper'

RSpec.describe Todo, type: :model do

  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:title) }

end
