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

  factory :multifield do
    f650 do
      {
        indicator2: "0",
        a: "A",
        z: ["B1", "B2"],
        x: "C",
        y: "D"
      }
    end

    f650 do
      {
        indicator2: "0",
        a: "A",
        z: "B"
      }
    end
  end
end
