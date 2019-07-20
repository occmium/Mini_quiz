# encode: utf-8
# Задача 29-2 — Викторина с вопросами из XML
# Задача 13-3 — Викторина

class Reader
  def self.read_xml(file_name)
    file = File.new(file_name, "r:UTF-8")
    doc = REXML::Document.new(file)
    file.close

    data_for_quiz = []

    doc.root.elements.each("questions/question") do |element|
      data_for_episode = {}
      data_for_episode[:time_left] = element.attributes["seconds"].to_i
      data_for_episode[:question] = element.elements["text"].text
      arr_answers = []
      element.elements.each('variants/variant') do |element|
        data_for_episode[:right_answer] = element.text if element.attributes["right"] == 'true'
        arr_answers << element.text.to_s
      end
      data_for_episode[:answers] = arr_answers
      data_for_quiz << data_for_episode
    end

    data_for_quiz
  end
end
