require 'fileutils'

class MkdirChmodRmdir
  def initialize(opt = {})
      @dir = "ruby_dir"
  end

  def run
    if not Dir.exist?(@dir)
      puts("mkdir")
      FileUtils.mkdir_p(@dir)
    end

    if Dir.exist?(@dir)
      puts("chmod")
      FileUtils.chmod(0o777, @dir)

      puts("rmdir")
      FileUtils.rmdir(@dir)
    end
  end
end

if $0 == __FILE__
  mcr = MkdirChmodRmdir.new()
  mcr.run()
end