module Report

import Base:write, close

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
  ncolumn::Integer
  nrows::Integer
  header::Array{String}
  data::Any
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