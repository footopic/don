# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  title      :string           not null
#  text       :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_templates_on_title    (title)
#  index_templates_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Template, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_presence_of(:user) }
end
