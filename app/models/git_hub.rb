class GitHub < Struct.new(:user)
  
  def download_code  
    FileUtils.mkdir_p code_path
    
    Net::HTTP.start("github.com") { |http|
      resp = http.get("/#{user.nick}/#{user.repo_name}/raw/master/MyTronBot.rb")
      
      safe_code = make_code_safe(resp.body)
      
      File.open("#{code_path}/MyTronBot.rb", "w") { |file|
        file.write(safe_code)
        unless user.active?
          user.active = true
          user.save
        end
      }
    }
  end
  
  private
  def code_path
    RAILS_ROOT + "/" + user.code_path
  end
  
  def make_code_safe(code)
    file_safe_head + "\n" +code.gsub(/^.*?require.*?$/, "")
    
  end
  
  def file_safe_head
    ['require File.join(File.dirname(__FILE__), "../map.rb")',
      'require File.join(File.dirname(__FILE__), "../printing.rb")',
      '$SAFE = 3'].join($/)
  end
end
