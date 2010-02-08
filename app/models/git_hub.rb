class GitHub < Struct.new(:user)
  
  def download_code  
    File.makedirs code_path
    
    Net::HTTP.start("github.com") { |http|
      resp = http.get("/#{user.nick}/#{user.repo_name}/raw/master/MyTronBot.rb")
  
      File.open("#{code_path}/MyTronBot.rb", "w") { |file|
        file.write(resp.body)
      }
    }
  end
  
  private
  def code_path
    RAILS_ROOT + "/" + user.code_path
  end
end
