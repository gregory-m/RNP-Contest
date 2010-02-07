class CodeRunner < Struct.new(:file_name)
  def perform
    %x[java -jar #{RAILS_ROOT}/engine/Tron.jar #{RAILS_ROOT}/maps/empty-room.txt 'ruby #{RAILS_ROOT}/tmp/bots/MyTronBot.rb' 'ruby #{RAILS_ROOT}/tmp/bots/MyTronBot.rb' 0 1]
  end
end
