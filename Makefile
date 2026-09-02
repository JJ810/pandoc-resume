compile:
	pandoc resume.md -s --template=template.html -c style.css -o index.html
	pandoc resume.md --template=template.tex --pdf-engine=xelatex -o resume.pdf
