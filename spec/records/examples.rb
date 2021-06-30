MarcBot.define do
  factory :example do
    leader { "1234567890" }
    f006 { "00000000000000" }
    f100 { "The Author" }
    f245 do
      {
        a: "Title A",
        b: "Title B"
      }
    end
  end
end
