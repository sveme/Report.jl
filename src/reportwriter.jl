function write(document::Markdown, author::Author)
    write(document.iostream, "")
end

function write(document::Markdown, header::Header)
   write(document.iostream, "#"^header.level*header.text*"\n\n") 
end

function write(document::Markdown, table::Table)
    # only works on string data arrays so far, so data need to be converted 
    header = ""
    underlines = ""
    dash = "-"
    rows = fill("", table.nrows)
    for i = 1:length(table.header)
        # first get the maximum size for each column
        hlength = length(table.header[i])
        maxlength = hlength
        for j = 1:table.nrows
            datalength = length(table.data[j,i])
            if datalength > maxlength
                maxlength = datalength
            end
        end
        # then write out the rows with spaces extending the cell to the maximum column size
        for j = 1:table.nrows
            cdata = table.data[j,i]
            nspaces = maxlength - length(cdata) + 1
            rows[j] = rows[j]*cdata*" "^nspaces
        end 

        nspaces = maxlength - hlength + 1
        header = header*table.header[i]*" "^nspaces
        underlines = underlines*dash^maxlength*" "
    end

    write(document.iostream,header*"\n")
    write(document.iostream,underlines*"\n")
    for r in rows
        write(document.iostream,r*"\n")
    end
    write(document.iostream,underlines*"\n")
    write(document.iostream,"\n")
    # TODO: Caption!

end

function write(document::Markdown, link::Link)
    write(document.iostream,"["*link.text*"]", "("*link.url*")")
end

function write(document::Markdown, figure::Figure)
    write(document.iostream,"!["*figure.caption*"]", "("*joinpath(document.figurefolder,figure.url)*")")
end

function write(document::Markdown, code::Code)
    write(document.iostream, "~~~~~~~~{.$code.language}\n")
    write(document.iostream, code.code*"\n")
    write(document.iostream, "~~~~~~~~\n")
end

function write(document::Markdown, paragraph::Paragraph)
    write(document.iostream, paragraph.text*"\n")
end

function write(document::Markdown, text::Union(ASCIIString,UTF8String))
    write(document.iostream, text*"\n")
end