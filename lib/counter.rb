# encode: utf-8
# Задача 29-2 — Викторина с вопросами из XML
# Задача 13-3 — Викторина

class Counter
  attr_accessor :true_answers

  def initialize
    @true_answers = []
  end

  def countdown_print(time_left)
    @countdown = Thread.new do
      time_left.times do
        print "          Времени на ответ #{time_left} сек.\r"
        time_left -= 1
        sleep 1
        print "                                            \r"
      end
    end
    @countdown
  end

  def stop
    @countdown.kill
  end
end
