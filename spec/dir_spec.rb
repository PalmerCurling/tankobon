require 'spec'
require 'tankobon'
require 'fileutils'

describe Dir do
  before(:each) do
    FileUtils.mkdir_p 'test'
  end
  
  after(:each) do
    FileUtils.rm_rf 'test'
  end
  
  it "should recognize an empty directory" do
    Dir.empty?('test').should == true
  end
  
  it "should explore a directory tree" do
    FileUtils.mkdir_p 'test/a/aa'
    FileUtils.mkdir_p 'test/b'
    Dir.chdir('test/a/aa') { File.open("file_name1.ext", "w").close() }
    exploration = []
    Dir.xplore('test') do |f|
      exploration << f
    end
    exploration.join(":")\
      .should == 'test/a/aa/file_name1.ext:test/a/aa:test/a:test/b'
  end
  
end