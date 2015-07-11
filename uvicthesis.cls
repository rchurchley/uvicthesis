%   Copyright (C) 2014--2015 Ross Churchley
%
%   License
%   =======
%
%   This work may be distributed and/or modified under the conditions of
%   the LaTeX Project Public License, either version 1.3 of this license
%   or (at your option) any later version. The latest version of this
%   license is in:
%
%      http://www.latex-project.org/lppl.txt
%
%   and version 1.3 or later is part of all distributions of LaTeX version
%   2005/12/01 or later.
%
%   This work consists of the file uvicthesis.cls and template.tex.
%
%   This work has the LPPL maintenance status `maintained'. The Current
%   Maintainer is Ross Churchley.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uvicthesis}[2014/01/21 UVic Thesis/Dissertation Template]


%   BASE CLASS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   uvicthesis.cls is based on the standard `book` document class.
%   For more information (including standard class options), see
%   http://texdoc.net/texmf-dist/doc/latex/base/classes.pdf
%   or type `texdoc book` on the command line.
%

\PassOptionsToClass{12pt}{book}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions

\LoadClass{book}


%   FONTS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Use the Latin Modern implementation of Computer Modern, for better support
%   of diacritics and non-English glyphs, including correct PDF search.
%   The fontenc package ensures proper hyphenation of accented words.
%

\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}


%   MARGINS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Sets margins according to the UVic thesis requirements.
%

\RequirePackage[top=1.3in,left=1.5in,bottom=1in,right=1in,headsep=0.5in]{geometry}


%   LINE SPACING & PAGINATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Sets doublespacing for the document body. (This does not affect spacing
%   inside figures, tables, and other floats, which remain single-spaced.)
%
%   Provides commands to set page numbers in roman numerals for preliminary
%   pages (frontmatter) and arabic numbers for all other content (mainmatter).
%
%   Sets the page number in the top right corner of all pages by default.
%

\RequirePackage{setspace}
\RequirePackage{titlesec}
\usepackage{fancyhdr}

\newcommand{\defaultspacing}{\doublespacing}
\newcommand{\smallspacing}{\onehalfspacing}
\renewcommand{\frontmatter}{\smallspacing\pagenumbering{roman}}
\renewcommand{\mainmatter}{\clearpage\defaultspacing\pagenumbering{arabic}}

%   Fixes spacing for chapter titles
\titleformat{\chapter}[display]{\Huge\bfseries}{Chapter \thechapter}{0pt}{}{}

\setlength{\headheight}{15pt}
\fancypagestyle{plain}{%
        \fancyhf{}
        \fancyhead[R]{\thepage}
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0pt}
}
\pagestyle{plain}


%   Title page metadata
%
%   Allows the user to easily set the information displayed on the title page.
%

\renewcommand{\@date}{\the\year}

\newcommand{\type}[1]{\renewcommand\@type{#1}}
\newcommand{\@type}{%
    \ClassError{uvicthesis}{I need to know whether this is a thesis or a dissertation. Use \protect\type{Thesis} or \protect\type{Dissertation} in the preamble.}{}}
    
\newcommand{\authordetails}[1]{\renewcommand\@authordetails{#1}}
\newcommand{\@authordetails}{}

\newcommand{\degree}[1]{\renewcommand\@degree{#1}}
\newcommand{\@degree}{%
    \ClassError{uvicthesis}{What degree are you writing this for? Use \protect\degree in the preamble to tell me your expected degree.}{}}

\newcommand{\department}[1]{\renewcommand\@department{#1}}
\newcommand{\@department}{%
    \ClassError{uvicthesis}{What department are you in? Let me know with  \protect\department in the preamble.}{}
}

\newcommand\panelist[3]{\noindent #1, #2\\\noindent(#3)\tpbreak}
\newcommand{\panel}[1]{\renewcommand\@panel{#1}}
\newcommand{\@panel}{}


%   Title page
%
%   Displays the title page and second page listing the supervisory
%   committee.
%

\RequirePackage{textcase}
\newcommand{\tpbreak}{\\[\baselineskip]}    % an extra big line break

\newcommand{\maketitlepage}{{\centering
    \@title                                                             \tpbreak
    by                                                                  \tpbreak
    \@author                                                            \\
    \@authordetails                                                     \tpbreak
    A {\@type} Submitted in Partial Fulfillment of the \\
    Requirements for the Degree of                                      \tpbreak
    \MakeUppercase{\@degree}                                                            \tpbreak
    in the \@department                     \\\vfill
    
    \begin{tabular}{cl}
        \copyright  & \@author, \@date\\
                    & University of Victoria
    \end{tabular}                                                       \tpbreak
    All rights reserved. This \MakeLowercase{\@type} may not be reproduced in whole or in part, by photocopying or other means, without the permission of the author.       \\
}}

\newcommand{\makepanelpage}{
    \addtoToC{Supervisory Committee}
    {\centering
    \@title                                                             \tpbreak
    by                                                                  \tpbreak
    \@author                                                            \\
    \@authordetails                                                     \tpbreak
    }                                                                   \vfill

    \noindent Supervisory Committee                                     \tpbreak
    \@panel                                                             \vfill
}

\renewcommand{\maketitle}{%
    \thispagestyle{empty}
    \maketitlepage%             % prints the actual title page (defined above)
    \newpage%
    \setcounter{footnote}{0}
}

\newcommand{\makecommittee}{%
    \makepanelpage
    \newpage%
}


%   Abstract
%
%   Displays the abstract page (including the supervisory committee again) and
%   adds it to the table of contents.
%

\newenvironment{abstract}{%
    \newpage\addtoToC{Abstract}

    \noindent \textbf{Supervisory Committee}
    \tpbreak
    \@panel

    \begin{center}\textbf{ABSTRACT}\end{center}
    
    }{}


%   Table of Contents
%
%   Fixes some display issues for the table of contents.
%   Provides a command to add sections like the bibliography to the ToC.
%

\newcommand{\addtoToC}[1]{\addcontentsline{toc}{chapter}{#1}}

\usepackage{tocloft}
\renewcommand{\cfttabpresnum}{Table\ }
\renewcommand{\cfttabnumwidth}{0.75in}
\renewcommand{\cftfigpresnum}{Figure\ }
\renewcommand{\cftfignumwidth}{0.90in}

\setcounter{lofdepth}{2}


%   Acknowledgements
%
%   Displays the acknowledgements page and adds it to the table of contents.
%

\newenvironment{acknowledgements}{%
    \newpage\addtoToC{Acknowledgements}

    \begin{center}\textbf{ACKNOWLEDGEMENTS}\end{center}
    
    }{}


%   Dedication
%
%   Displays the dedication page and adds it to the table of contents.
%

\newenvironment{dedication}{%
    \newpage\addtoToC{Dedication}

    \begin{center}\textbf{DEDICATION}\end{center}
    
    }{}


\endinput