# pandocinvoice
An archived git of my former invoicing process

Copyright Logo [:R] (C) Anselm Peischl - no usage without permission.
Copyright Code (C) Anselm Peischl, 2021 - do what you want.
This is a strong modification of the brieftemplate by (c) Marei Peischl (https://github.com/TeXhackse/LaTeX-basics/blob/main/Briefe/brieftemplate.tex)

# Generated Files
This is a hacky project, I will answer questions. The whole thing generates .journal-Files for hledger (https://hledger.org/) plus a pdf.

# Usage
`./invoice -f=template.md` or `./invoice --file=template.md`
write to script dir for preview

`./invoice -f=template.md -x` or `./invoice --file=template.md --export`
write to QUARTAL in invoice.sh 

`./smallerpdf template.pdf`
optimize pdf using ghostscript, drastic reduction in filesize
