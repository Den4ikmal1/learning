require 'rails_helper'


RSpec.describe Question, type: :model do
  subject { build(:question)}
  it { should have_many :answers}
  it { should have_many :attachments }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should accept_nested_attributes_for :attachments}

  it 'should calculate reputatioon after creating' do
  	expect(subject).to receive(:calculate_reputation)
  	subject.save!
  end
  it 'should  not calculate reputatioon after update' do
  	subject.save!
  	expect(subject).to_not receive(:calculate_reputation)
  	subject.update(title: "saad")
  end
  

end
