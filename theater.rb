require 'ostruct'
require 'pry'

class Theater

  def plays
    {
      'hamlet' => OpenStruct.new('name' => 'Hamlet', 'type' => 'tragedy'),
      'as_like' => OpenStruct.new('name' => 'As You Like It', 'type' => 'comedy'),
      'othello' => OpenStruct.new('name' => 'Othello', 'type' => 'tragedy')
    }
  end

  def invoice
    OpenStruct.new(
      'customer' => 'BigCo',
      'performances' =>
        [
          OpenStruct.new(
            'play_id' => 'hamlet',
            'audience' => 55
          ),
          OpenStruct.new(
            'play_id' => 'as_like',
            'audience' => 35
          ),
          OpenStruct.new(
            'play_id' => 'othello',
            'audience' => 40
          )
        ]
      )
  end

  def statement(invoice, plays)
    total_amount = 0
    volume_credits = 0

    result = "\nStatement for #{invoice.customer}\n"

    invoice.performances.each do |perf|
      play = plays[perf.play_id]
      amount = 0

      case play.type
      when 'tragedy'
        amount = 40_000
        if perf.audience > 30
          amount += 1000 * (perf.audience - 30)
        end
      when 'comedy'
        amount = 30_000
        if perf.audience >20
          amount += 10_000 + 500 * (perf.audience - 20)
        end
        amount += 300 * perf.audience
      else
        raise "unknown type: #{play.type}"
      end

      # add volume credits
      volume_credits += perf.audience - 30
      # add extra credit for every ten comedy attendees
      if play.type == 'comedy'
        volume_credits += (perf.audience / 5)
      end

      # print line for this order
      result += "  • #{play.name}: $#{amount / 100}.00 (#{perf.audience} seats)\n"
      total_amount += amount
    end

    result += "Amount owed is $#{total_amount / 100}.00\n"
    result += "You earned #{volume_credits} credits\n"
  end

end
