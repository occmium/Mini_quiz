# encode: utf-8
# Задача 29-2 — Викторина с вопросами из XML
# Задача 13-3 — Викторина

require_relative "lib/reader"
require_relative "lib/counter"
require "rexml/document"
require 'timeout'

current_path = File.dirname(__FILE__)
file_name = current_path + "/data/quiz.xml"
abort "Файл quiz.xml не найден." if !File.exist?(file_name)

quiz = Reader.read_xml(file_name)
counter = Counter.new

puts "Ответьте на вопросы: (время для ответа ограничено)"
quiz.each do |episode|
  puts episode[:question]
  answers_for_print =[]
  episode[:answers].shuffle.each { |string| answers_for_print << string }
  answers_for_print.each_with_index { |string, index| puts "#{index + 1}: #{string}" }
  user_answer = nil
  time_left = episode[:time_left]

  counter.countdown_print(time_left)

  begin
    Timeout.timeout(episode[:time_left]) do
      until (1..answers_for_print.length).include?(user_answer.to_i)
        user_answer = STDIN.gets.chomp
      end
    end
  rescue Timeout::Error
    abort "          Потрачено!                          "
  end

  counter.stop if (1..answers_for_print.length).include?(user_answer.to_i)

  if answers_for_print[user_answer.to_i - 1] == episode[:right_answer]
    puts "Верный ответ!\n\n"
    counter.true_answers << answers_for_print[user_answer.to_i - 1]
  else
    puts "Неправильно. Правильный ответ: #{episode[:right_answer]}\n\n"
  end
end
puts "Правильных ответов #{counter.true_answers.length} из #{quiz.length}"
