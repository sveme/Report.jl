# Report.jl

Lightweight Markdown report generator for Julia.

The very general idea is that you can create markdown-formatted reports from within Julia code. Potentially helpful when running a data analysis pipeline that creates tables and plots as output. Uses [pandoc](http://johnmacfarlane.net/pandoc/) Markdown and some of its extensions.

Some examples:

~~~~~~~~{.julia}
using Report
# create a Markdown document
doc = Report.Markdown("Report.md", "w", "figures")

# add a header to the document 
write(doc, Report.Header(1, "Report on Report.jl"))

# do some stuff, read in data, plot something
# Table(nrows, ncolumns, header, data, caption) creates a simple_table
write(doc, Report.Table(6, 3, ["Col1","Col2","Col3"], data, "Example table"))

# add a plot that was stored in `filename`
write(doc, Report.Figure(filename, "Yet another plot"))

# add some julia code to help you remember what you have done (uses fenced_code_blocks)

code = """
doc = Report.Markdown("Report.md", "w", "figures")
write(doc, Report.Header(1, "Report on Report.jl"))
write(doc, Report.Table(6, 3, ["Col1","Col2","Col3"], data, "Example table"))
write(doc, Report.Figure(filename, "Yet another plot"))
"""

write(doc, Report.Code("julia", code))
