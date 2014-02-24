
function write(document::Markdown, block::Blockquote)
    text = block.text 
    # TODO put a > before all \n
    write(document.iostream, ">$text")
end

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
    # reshape = shape the data to fit the nrows and ncolumns - TODO: check for validity
    data = reshape(table.data, table.nrows, table.ncolumns)
    for i = 1:length(table.header)
        # first get the maximum size for each column
        hlength = length(table.header[i])
        maxlength = hlength
        for j = 1:table.nrows
            datalength = length(string(data[j,i]))
            if datalength > maxlength
                maxlength = datalength
            end
        end
        # then write out the rows with spaces extending the cell to the maximum column size
        for j = 1:table.nrows
            cdata = string(data[j,i])
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
    caption = table.caption
    if caption != ""
        write(document.iostream,"Table: $caption\n")
    end
    write(document.iostream,"\n\n")
end

function write(document::Markdown, link::Link)
    write(document.iostream,"["*link.text*"]("*link.url*")")
end

function write(document::Markdown, figure::Figure)
    # to cover situations where the figure file has an absolute path
    if document.figurefolder != ""
        url = joinpath(document.figurefolder,figure.url)
    else
        url = figure.url
    end
    write(document.iostream,"!["*figure.caption*"]("*url*")\n\n")
end

function write(document::Markdown, code::Code)
    lang = code.language
    head = ""
    if code.identifier != ""
        id = code.identifier
        head = head*"#$id "
    end
    if lang != ""
        head = head*".$lang "
    end
    if code.numberLines
        startFrom = code.startFrom
        head = head*".numberLines startFrom=$startFrom"
    end
    
    if head != ""
        head = "{"*head*"}"
    end

    write(document.iostream, "~~~~~~~~"*head*"\n")
    write(document.iostream, code.code*"\n")
    write(document.iostream, "~~~~~~~~\n")
end

function write(document::Markdown, paragraph::Paragraph)
    write(document.iostream, paragraph.text*"\n")
end

function write(document::Markdown, text::String)
    write(document.iostream, text*"\n")
end