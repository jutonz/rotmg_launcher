require 'net/http'

class RotmgLauncher

  def initialize
    @flashplayer = 'flashplayer_17_sa.exe' # In same directory as this script.
    url = get_url
    launch_from url
  end

  def get_url
    base_url = 'https://realmofthemadgodhrd.appspot.com/AssembleeGameClient__VERSION__.swf'
    version = Net::HTTP.get URI('http://www.realmofthemadgod.com/version.txt')
    base_url.gsub! '__VERSION__', version
  end

  def launch_from(url)
    begin
      pid = Kernel.spawn @flashplayer, url
      Process.detach pid
    rescue
      puts "Cannot find #{@flashplayer} in #{Dir.pwd}"
      puts 'Press enter to close.'
      gets
    end
  end

end

RotmgLauncher.new