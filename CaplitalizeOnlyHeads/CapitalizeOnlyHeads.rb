class CapitalizeOnlyHeads
  def initialize(opt = {} )
  end

  def convert(str)
    last_str = ""
    str.scan(/(\s*)([^\s]*)/) {|s| last_str += s[0]+s[1].capitalize }
    print(last_str)
  end
end

if $0 == __FILE__
  capitalizer = CapitalizeOnlyHeads.new()
  str = " can you caplitalize?";
  puts(capitalizer.convert(str))
end
