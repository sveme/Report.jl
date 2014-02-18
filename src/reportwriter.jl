function write(document::Markdown, author::Author)
    write(document.iostream, "")
end

function write(document::Markdown, table::Table)
    # TODO check that the length of columns is the larger of (header, maxlength(datarow))
    header = ""
    underlines = ""
    dash = "-"
    rows = fill("", nrows)
    for i = 1:length(table.header)
        hlength = length(table.header[i])
        header = header*"\t"*table.header[i]
        underlines = underlines*dash^hlength*"\t"
        for j = 1:length(rows)
            cdata = table.data[j,i]
            overlap = hlength - length(cdata)

            # hack, use sprintf instead! cuts off stuff! 
            overlap <= 0 ? cdata = cdata[1:end] : cdata*" "^overlap
            rows[i] = rows[i]*cdata*"\t"
        end
        rows[i] = rows[i]*"\n"
    end

    write(document.iostream,header*"\n")
    write(document.iostream,underlines*"\n")
    for r in rows
        write(document.iostream,r)
    end

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

function write(document::Markdown, text::String)
    write(document.iostream, text*"\n")
end