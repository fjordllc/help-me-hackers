#require File.expand_path(File.dirname(__FILE__) + '/../../../../spec/spec_helper')

describe "rake" do
  it 'should be true to execute "rake db:fixtures:extract"' do
    system(IO.popen("which jruby", "r").gets.chomp.sub(/jruby$/, "") + "rake db:fixtures:extract").should == true
  end

  it 'should be true to execute "rake db:fixtures:convert DB=fantasista"' do
    system(IO.popen("which jruby", "r").gets.chomp.sub(/jruby$/, "") + "rake db:fixtures:convert DB=fantasista").should == true
  end
end
