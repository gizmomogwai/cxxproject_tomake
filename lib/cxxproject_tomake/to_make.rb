module ToMake
  def self.escape_spaces(command_line)
    command_line.map do |line|
      regexps = [/(-L)(.*)/,
                 /(-I)(.*)/]
      regexps.inject(line) do |memo, regexp|
        memo.gsub(regexp) do |match|
          "#{$1}\"#{$2}\""
        end
      end
    end
  end
end
