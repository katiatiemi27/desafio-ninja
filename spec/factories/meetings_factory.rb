FactoryBot.define do
  factory :meeting do
    room { 1 }
    date { "2022-04-11" }
    initial_time { "9:13" }
    final_time { "11:13" }
    name { "Reuniao Tecnica Projeto A" }
  end
end
