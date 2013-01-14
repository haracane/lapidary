# coding: utf-8
module Lapidary
  # Lapidary sub-commands
  module Command
    # Rubygem builder command
    module Build
      # Rubygem generator method
      #
      # This method generates a new Rubygem project
      # @param argv [Array] command-line arguments
      def self.run(argv)
        @user_name = `/usr/bin/env git config --get user.name`.chomp
        @user_email = `/usr/bin/env git config --get user.email`.chomp
        @github_user = `/usr/bin/env git config --get github.user`.chomp

        next_argv = []
        while 0 < argv.length
          val = argv.shift
          case val
          when "--test"
            @user_name = "Test User"
            @user_email = "test@mail.com"
            @github_user = "testuser"
          else
            next_argv.push val 
          end
        end
        
        argv = next_argv
        
        if @user_name == ""
          STDERR.puts "ERROR: user.name is not set in git config"
          return 1
        end
        
        if @user_email == ""
          STDERR.puts "ERROR: user.email is not set in git config"
          return 1
        end
        
        if @github_user == ""
          STDERR.puts "ERROR: github.user is not set in git config"
          return 1
        end
        
        @project_name = argv.shift
        @module_name = Lapidary.to_camel_case(@project_name)
        
        [
          @project_name,
          "#{@project_name}/bin",
          "#{@project_name}/lib",
          "#{@project_name}/spec",
          "#{@project_name}/spec/lib"
          ].each do |dirpath|
          Dir.mkdir(dirpath) unless FileTest.exist?(dirpath)
        end
        
        all_flag = false
        
        [
          ".document",
          ".gitignore",
          ".rspec",
          "Gemfile",
          "LICENSE.txt",
          "README.md",
          "Rakefile",
          "bin/project",
          "lib/project.rb",
          "spec/spec_helper.rb",
          "spec/lib/project_spec.rb",
          ].each do |filepath|
          content = ERB.new(File.read("#{Lapidary::TEMPLATES_DIR}/#{filepath}.erb")).result(binding)
          dest_path = "#{@project_name}/#{filepath.gsub(/project/, @project_name)}"
          exist_flag = FileTest.exist?(dest_path)
          if !all_flag && exist_flag
            STDOUT.print "overwrite #{dest_path}?(y/n/a): "
            answer = STDIN.gets
            answer.chomp!
            case answer
            when "y"
            when "n"
              next
            when "a"
              all_flag = true
            end
          end
          File.open(dest_path, "w") do |f|
            f.write(content)
          end
          if exist_flag
            STDOUT.puts "overwrited #{dest_path}"
          else
            STDOUT.puts "created #{dest_path}"
          end
        end
        
        File.chmod(0755, "#{@project_name}/bin/#{@project_name}")
        
        return 0
      end
    end
  end
end
