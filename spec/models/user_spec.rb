require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it { expect(subject).to allow_value('First').for(:first_name) }
  it { expect(subject).to_not allow_value('1st').for(:first_name) }
end
