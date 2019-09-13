module MigrationStatus 
  def self.status
    s = `rails db:migrate:status`.split("\n").reject(&:blank?)

    # Get rid of teh stuff before the stuff we want
    while(true) do
      break if s.first.include?("Status") && s.first.include?("Migration ID")
      s.shift
    end

    # We don't want the first 2 lines
    2.times { s.shift }

    s.map do |line|
      pieces = line.strip.split(" ")
      pieces.first(2) + [pieces[2..-1].join(" ")]
    end
  end
end
