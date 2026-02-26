# Loads all Brewfile.* sub-files automatically.
# To update: brew-dump
Dir.glob("#{File.dirname(__FILE__)}/Brewfile.*").sort.each do |file|
  instance_eval File.read(file)
end
