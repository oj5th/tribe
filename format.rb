module Format
  CODES = ["FLAC", "IMG", "VID"].freeze
  BUNDLES = {
    "FLAC" => {
      9 => 1147.50,
      6 => 810,
      3 => 427.50,
    }.freeze,
    "IMG" => {
      10 => 800,
      5 => 450,
    }.freeze,
    "VID" => {
      9 => 1530,
      5 => 900,
      3 => 570,
    }.freeze,
  }.freeze
end
