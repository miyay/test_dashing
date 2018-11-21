require "./trans.rb"
require "yaml"
require "pp"

data = YAML.load_file("flower_word.yml")
out = []

data.each do |monses|
  monses.each_pair do |mon, data_days|
    data_days.each_pair do |k, flower_datas|
      flower_datas.each do |flower_data|
        unless flower_data[:flower_en]
          begin
            flower_data[:flower_en] = Trans.translate_text(flower_data[:flower])
          rescue
          end
        end

        sleep(0.01)
      end
      puts "#{k}\r"
    end
  end
end

#pp data[9]
open("flower_word_trans_all.yml", "w") {|f| f.write data.to_yaml}
