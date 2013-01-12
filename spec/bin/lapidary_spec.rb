require "spec_helper"

describe "bin/lapidary" do
  before :all do
    @stdout_redirect = Lapidary::REDIRECT[:stdout]
    @stderr_redirect = Lapidary::REDIRECT[:stderr]
  end
  
  it "should create valid gem template" do
    work_dir = "#{ENV["HOME"]}/git"
    if ! FileTest.exists?(work_dir)
      Dir.mkdir(work_dir)
    end
    Dir.chdir(work_dir){
      if FileTest.exists?("lapidary_test")
        result = system("rm -rf lapidary_test")
        result.should be_true
      end
      system("ruby -I #{Lapidary::LAPIDARY_HOME}/lib #{Lapidary::LAPIDARY_HOME}/bin/lapidary --test lapidary_test #{@stdout_redirect} #{@stderr_redirect}").should be_true
      Dir.chdir("lapidary_test"){
        result = system("rake spec spec:rcov yard #{@stdout_redirect} #{@stderr_redirect}")
        result.should be_true
        
        FileTest.exists?("coverage").should be_true
        
        FileTest.exists?("doc").should be_true
        FileTest.exists?("doc/_index.html").should be_true

        File::Stat.new("./bin/lapidary_test").mode.should == 0100755
        
        system("ruby -I ./lib ./bin/lapidary_test").should be_true
      }
      
      
      # Dir.chdir("lapidary_test"){
        # result = system("rake ci:setup:rspec spec #{@stdout_redirect} #{@stderr_redirect}")
        # result.should be_true
# 
        # FileTest.exists?("spec/reports").should be_true
      # }
    }
  end
end
