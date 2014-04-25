FactoryGirl.define do
  [
    ["Sáb - 29/03", "17:30", "Warner"],    ["Sáb - 29/03", "17:30", "Warner HD"],
    ["Dom - 30/03", "00:35", "TNT"],       ["Dom - 30/03", "13:00", "TNT"],
    ["Dom - 30/03", "15:20", "Warner"],    ["Dom - 30/03", "15:20", "Warner HD"],
    ["Sex - 28/03", "09:14", "Space"],     ["Sex - 28/03", "09:14", "Space HD"],
    ["Dom - 06/04", "00:25", "Warner"],    ["Dom - 06/04", "00:25", "Warner HD"],
    ["Dom - 06/04", "22:00", "Warner HD"], ["Dom - 06/04", "22:00", "Warner"]
  ].each_with_index do |value, key|
    factory "prog_#{key}".to_sym, class: Programacao do
      initialize_with{ new(Hash[[:data, :hora, :canal].zip(value)]) }
    end
  end

  factory :filme do
    initialize_with{ new(tipo: 'Filme', filme: 'Matrix') }
    programacao do
      [ build(:prog_0), build(:prog_1), build(:prog_2),
        build(:prog_3), build(:prog_4), build(:prog_5) ]
    end
  end

  factory :sequel, class: Filme do
    initialize_with{ new(tipo: 'Filme', filme: 'Matrix Regurgitations') }
    programacao do
      [ build(:prog_6), build(:prog_7), build(:prog_8),
        build(:prog_9), build(:prog_10), build(:prog_11) ]
     end
  end

end
