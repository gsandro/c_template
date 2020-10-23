\NeedsTeXFormat{LaTeX2e}
\newcommand{\super@classversion}{3.0}
\ProvidesPackage{./template-latex/latex-report}[2020/09/10 SUPER Template LaTex,\super@classversion]

% Options Definitions ######################################################
\RequirePackage{kvoptions}
\SetupKeyvalOptions{prefix=super@option@}

\DeclareStringOption[fr,en,de]{lang}
\DeclareStringOption{path}
\DeclareStringOption[\@empty]{changelog}
\DeclareBoolOption[true]{confidential}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessKeyvalOptions*

\LoadClass[12pt,a4paper,titlepage]{report}

% Options Processing #######################################################
\input{./configuration/packages.tex}

\titlespacing*{\chapter}{0pt}{-40pt}{40pt}

\titleformat{\chapter}[display]
	{\Huge\bfseries}
	{}
	{0pt}
	{\thechapter.\ }
\titleformat{name=\chapter,numberless}[display]
	{\Huge\bfseries}
	{}
	{0pt}
	{}

% language management
\ifnum\pdf@strcmp{\super@option@lang}{fr}=0
	\RequirePackage[french]{babel}
	\input{\super@option@path/latex-report-fr.lang}
\else
	\ifnum\pdf@strcmp{\super@option@lang}{de}=0
		\RequirePackage[german]{babel}
		\input{\super@option@path/latex-report-de.lang}
	\else
		\RequirePackage[english]{babel}
		\input{\super@option@path/latex-report-en.lang}
	\fi
\fi


% Commands Definitions #####################################################
\newcommand{\super@project}{\@empty}
\newcommand{\project}[1]{\renewcommand{\super@project}{#1}}

\newcommand{\super@subtitle}{\@empty}
\newcommand{\subtitle}[1]{\renewcommand{\super@subtitle}{#1}}

\newcommand{\super@author}{\@empty}
\renewcommand{\author}[1]{\renewcommand{\super@author}{#1}}

\newcommand{\email}[1]{\@empty}
\newcommand{\super@email}{\@empty}
\renewcommand{\email}[1]{\renewcommand{\super@email}{#1}}

\newcommand{\super@keywords}{\@empty}
\newcommand{\keywords}[1]{\renewcommand{\super@keywords}{#1}}

% clear a double page for a new chapter - when there isn't any content in a page, this
% would automaticly clear headers
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{
	\clearpage
	{\pagestyle{empty}\origdoublepage}
}

% table of contents helper
% force toc page style -- http://tex.stackexchange.com/questions/5787/table-of-contents-with-page-style-empty
\addtocontents{toc}{\protect\thispagestyle{plain}}
\newcommand{\inserttoc}{
	\pdfbookmark{\contentsname}{toc}
	\setcounter{tocdepth}{3}
	\tableofcontents
	%\clearemptydoublepage
}

% list of figure helper
\newcommand{\insertlof}{
	\newpage
	\phantomsection
	\addcontentsline{toc}{chapter}{\listfigurename}
	\listoffigures\thispagestyle{plain}
}

% list of table helper
\newcommand{\insertlot}{
	\newpage
	\phantomsection
	\addcontentsline{toc}{chapter}{\listtablename}
	\listoftables
}

% list of listening helper
\newcommand{\insertlol}{
	\newpage
	\phantomsection
	\addcontentsline{toc}{chapter}{\lstlistlistingname}
	\lstlistoflistings
}

% list of abbreviation helper
\newcommand{\insertlob}{
	\phantomsection
	\printacronyms[include=abbrev,heading={chapter*},name=\super@str@chapterAbbr]
	\addcontentsline{toc}{chapter}{\super@str@chapterAbbr}
}

% bibliography helper
\newcommand{\insertbibliography}{
	\nocite{*}
	\newpage
	\phantomsection
	\printbibliography[heading=bibintoc]
}

% revision chapter
\newcommand{\insertrevision}[1]{
	\phantomsection
	\section*{\super@str@chapterRevisions}
	\input{#1}
}

% Macro to fill part of a page with a color ################################

% Macro \changepagecolor has the same syntax as \pagecolor or \color
% with an optional argument and a mandatory argument.
\newcommand*{\changepagecolor}{\@ifnextchar[\@changepagecolor@i\@changepagecolor@ii}
% Case: \changepagecolor[...]{...}
\def\@changepagecolor@i[#1]#2{\@changepagecolor@do{[{#1}]{#2}}}
% Case: \changepagecolor{...}
\newcommand*{\@changepagecolor@ii}[1]{\@changepagecolor@do{{#1}}}
\newcommand*{\@changepagecolor@do}[1]{
	% Fill the remaining space with a colored rule
	{
		\offinterlineskip
		\hbox to 0pt{
			\kern-\paperwidth
			\vtop to 0pt{
				\color#1
				\hrule width 2\paperwidth height \paperheight
				\vss
			}
		\hss
		}
	}
}


% More Package Setup #######################################################

% use arial font
\renewcommand{\familydefault}{\sfdefault}

% header and footer
\fancypagestyle{plain}{
	\fancyhf{}%
	\renewcommand{\headheight}{30pt}
	\fancyhead[RO,LE]{\includegraphics[height=0.8cm]{\super@option@path/gfx/Logo.png}}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{1.5pt}
	\renewcommand{\footrule}{\hbox to\headwidth{\color{black}\leaders\hrule height \footrulewidth\hfill}}
	\fancyfoot[RO,LE]{\thepage/\pageref{LastPage}}
	\fancyfoot[C]{\ifsuper@option@confidential \super@str@confidential \else \empty \fi}
	\fancyfoot[RE,LO]{\@title}
}

% group listings into the table of listing by chapter
\let\Chapter\chapter
\def\chapter{\addtocontents{lol}{\protect\addvspace{10pt}}\Chapter}

% indentation
\setlength\parindent{0pt}


% Title Page ###############################################################
\AtBeginDocument{

	% does not count these pages in the numbering
	\pagenumbering{alph}

	% define interactive pdf parameters
	\hypersetup{
		%bookmarks=false, 		% show bookmarks bar?
		unicode=false,			% non-Latin characters in Acrobat’s bookmarks
		%pdftoolbar=true,		% show Acrobat’s toolbar?
		%pdfmenubar=true,		% show Acrobat’s menu?
		%pdffitwindow=false,	% window fit to page when opened
		%pdfstartview={FitH},	% fits the width of the page to the window
		pdftitle={\super@project: \@title},	% title
		pdfauthor={\super@author},			% author
		pdfsubject={\super@subtitle},		% subject of the document
		pdfcreator={MiKTeX 2.9},			% creator of the document
		pdfproducer={\super@str@company\ - Latex Toolchain},	% producer of the document
		pdfkeywords={\super@keywords},		% list of keywords
		pdfnewwindow=true,		% links in new PDF window
		pdfborder={0 0 0},
	}

	\newgeometry{left=1.5cm,right=1.5cm,top=1cm,bottom=1cm}
	\pagestyle{empty}

	\begin{flushright}
		\includegraphics[width=3.7cm]{\super@option@path/gfx/Logo.png}
	\end{flushright}

	\begin{center}
	\vspace*{3cm}
		
	\Huge{\bfseries\super@project}\\
	\ifsuper@option@confidential
		{\color{red}\Large\bfseries\super@str@confidential}
	\fi
		
	\vspace*{4cm}
	\huge{\bfseries\@title}\\
	\Large{\bfseries\super@subtitle}

	\vspace*{4cm}
	\super@author\\\medskip 
	\small{\href{mailto:\super@email}{\super@email}}

	\vspace*{1cm}
	\large\today

	\vspace*{\fill}

	\changepagecolor{lightgray}
	\begin{minipage}[b]{0.69\textwidth}
		\color{black}\small
		\super@str@companyWebsite
	\end{minipage}
	\begin{minipage}[b]{0.29\textwidth}
		\color{black}\small
		\vspace*{1.5cm}
		\super@str@company\\
		\super@str@street\\
		\super@str@zip \ \super@str@city\\
		\super@str@companyPhone\\
		\super@str@companyEmail
	\end{minipage}
	\end{center}  
	\newpage
	\restoregeometry
		
	% Legal notice #########################################################
	\section*{\super@str@impressum}
	\label{sec:legalNotice}
	
	% remove page number from footer for legal page
	\pagestyle{plain}
	\fancyfoot[RO,LE]{}
	
	\vspace*{0.2cm}
	\begin{center}
		\begin{tabular}{p{0.2\textwidth} p{0.74\textwidth}}	
			\toprule
			\textbf{\super@str@publisher}	& \super@str@company\\
											& \super@str@street\\
											& \super@str@zip \ \super@str@city\\
											& T\ \super@str@companyPhone\\
											& F\ \super@str@companyFax\\
											& \super@str@companyWebsite\\
											& \super@str@companyEmail\\ \hline
			\textbf{\super@str@dateIssue} 	& \today\\ \hline
			\textbf{\super@str@copyright}	& \textrm{\textcopyright}\ \textbf{\the\year}\\
											& \super@str@copyrightText\\ \hline
			\textbf{\super@str@update}    	& \super@str@updateText\\ \hline
			\textbf{\super@str@write}		& \super@author\\ \bottomrule
		\end{tabular}
	\end{center}

	\ifdefempty{\super@option@changelog}
	{
		% no changelog given
	}
	{
		% changelog given
		\vspace*{0.5cm}
		\insertrevision{\super@option@changelog}
	}
	
	\newpage
	% restore page numbering and header/footer
	\pagenumbering{arabic}	
	\pagestyle{plain}
}

\endinput