if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all
  Footnotes::Filter.prefix = "editor://open?url=file://%s&line=%d"

  # ... other init code
end
