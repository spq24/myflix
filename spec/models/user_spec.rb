require 'spec_helper'
require 'shoulda-matchers'

describe User do
  it { should have_secure_password}
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_man(:queue_items).order(:position) }
end