require 'spec_helper'

describe ReleaseConductor do
  before(:each) do
    Rake::Task['load:defaults'].invoke
  end

  it "invokes release_conductor:deploy:finished after deploy:finished" do
    # expect(ReleaseConductor).
    Rake::Task['deploy:finished'].execute
  end
end
