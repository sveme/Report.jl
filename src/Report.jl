module Report

import Base.write
import Base.close

type Markdown
  filename::String
  writeorappend::ASCIIString
  figurefolder::String
  iostream::IO
end
Markdown(filename) = Markdown(filename, "w", "", open(filename,"w"))
Markdown(filename, writeorappend) = Markdown(filename, writeorappend,"", open(filename,writeorappend))
Markdown(filename, writeorappend, figurefolder) = Markdown(filename, writeorappend,figurefolder, open(filename,writeorappend))
close(doc::Markdown) = close(doc.iostream)

type Header
  level::Integer
  text::String
end

type Author
  name::String
  email::String
  address::String
  affiliation::String
  website::String
end

type Figure
  url::String
  caption::String
end

type Code
  language::String
  code::String
end

type Table
  nrows::Integer
  ncolumn::Integer
  header::Array{String}
  data::Array{Any}
  caption::String
end

type Link
  text::String
  url::String
end

type Paragraph
  text::String
end

include("reportwriter.jl")

end