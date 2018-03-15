require 'date'

class Task < Post

  def initialize
    super
    @due_date = Time.now
  end

  def read_from_console
    puts "Что надо сделать?"
    @text = STDIN.gets.chomp

    puts "К какому числу? Укажите дату в формате ДД.ММ.ГГГГ., например 12.05.2003"
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S")} \n\r"

    deadline = "Крайний срок: #{@due_date}"

    [deadline, @text, time_string]
  end

  def to_db_hash
    super.merge (
                  {
                    'text' => @text,
                    'due_date' => @due_date.to_s
                  }
                )
  end
end