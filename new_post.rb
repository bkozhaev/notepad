if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'post.rb'
require_relative 'link.rb'
require_relative 'task.rb'
require_relative 'memo.rb'


puts "Привет, я твой блокнот! Версия 2 + Sqlite"
puts "Что хотите записать в базу?"

choices = Post.post_types.keys

choice = 0

until choice.between?(1, choices.size) do
  choices.each_with_index do |type, index|
    puts "\t#{index + 1}, #{type}"
  end
  choice = STDIN.gets.chomp.to_i
end

entry = Post.create(choices[choice - 1])

entry.read_from_console

id = entry.save_to_db

puts "Ура, запись сохранена, id = #{id}"