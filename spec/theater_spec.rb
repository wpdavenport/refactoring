require 'spec_helper'

describe Theater do

  subject { Theater.new.statement(invoice, plays)}
  subject { Theater.new.statement(invoice, plays) }

  let(:invoice)     { double(:customer => "KungFoo", :performances => [performance]) }
  let(:performance) { double(:play_id => "hamlet", :audience => 40) }
  let(:plays)       { Theater.new.plays }

  context "Tragedy plays" do

    it "should calculate credits" do
      expect(subject).to eq("\nStatement for KungFoo\n  • Hamlet: $500.00 (40 seats)\nAmount owed is $500.00\nYou earned 10 credits\n")
    end

  end

  context "Comedy plays" do

    let(:performance) { double(:play_id => "as_like", :audience => 40) }

    it "should calculate extra credit" do
      expect(subject).to eq("\nStatement for KungFoo\n  • As You Like It: $620.00 (40 seats)\nAmount owed is $620.00\nYou earned 18 credits\n")
    end

  end

end
