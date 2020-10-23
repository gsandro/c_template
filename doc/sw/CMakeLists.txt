#[[------------------------------------------

	-------------------------------
	gsandro's cmake script
	-------------------------------
	
	Project: Generic

---------------------------------------------]]# 

set( SwDocInputs
	chapters/chapter1.tex
	chapters/chapter2.tex
	configuration/codeCommands.tex
	configuration/commands.tex
	configuration/packages.tex
	references/abbreviations.tex
	references/revisions.tex
	template-latex/latex-report.cls
	template-latex/latex-report-de.lang
	template-latex/latex-report-en.lang
	template-latex/latex-report-fr.lang
)
	
set( SwDocBiblio
	references/bibliography.bib
)

set( SwDocImages
	template-latex/gfx/Logo.png
	images/lama.png
)

add_latex_document( sw.tex
	BIBFILES ${SwDocBiblio}
	INPUTS ${SwDocInputs}
	IMAGES ${SwDocImages}
)

# Usage: add_latex_document(<tex_file>
        #  [BIBFILES <bib_file> <bib_file> ...]
        #  [INPUTS <tex_file> <tex_file> ...]
        #  [IMAGE_DIRS <directory1> <directory2> ...]
        #  [IMAGES <image_file1> <image_file2>
        #  [CONFIGURE <tex_file> <tex_file> ...]
        #  [DEPENDS <tex_file> <tex_file> ...]
        #  [MULTIBIB_NEWCITES] <suffix_list>
        #  [USE_BIBLATEX] [USE_INDEX] [USE_GLOSSARY] [USE_NOMENCL]
        #  [FORCE_PDF] [FORCE_DVI] [FORCE_HTML]
        #  [TARGET_NAME] <name>
        #  [EXCLUDE_FROM_ALL]
        #  [EXCLUDE_FROM_DEFAULTS])