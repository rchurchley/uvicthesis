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



%   TITLE PAGE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Generates a correctly-formatted title page, provided the following
%   information is given in the preamble:
%
%   \title{...}
%   \author{...}
%   \previousdegrees{...}
%   \thesistype{...}
%   \degree{...}
%   \department{...}
%   \copyrightyear{...}
%
%   The ``all rights reserved'' text may also be overrided with
%   \copyrightnotice{...}
%

\renewcommand{\maketitle}{{%
    \thispagestyle{empty}
                    \begin{center}
                        \@title                             \\[12pt]
                          by                                \\[12pt]

                        \@author                            \\
                  \@previousdegrees                         \\[12pt]


  A {\@thesistype} Submitted in Partial Fulfillment of the  \\
            Requirements for the Degree of                  \\[12pt]

               \MakeUppercase{\@degree}                     \\[12pt]

                 in the \@department
                                                            \vfill


        \textcopyright\ \@author, \@copyrightyear           \\
               University of Victoria                       \\[12pt]

                 \@copyrightnotice
                    \end{center}
    \newpage
}}

%   The implementation creates a new "variable" for each metadata needed,
%   initially storing placeholder text and an instruction to throw a warning
%   if the user hasn't provided the correct information. We then define the
%   user-facing commands to set the corresponding variables when called.

\newcommand{\@thesistype}{THESIS \@MissingMetadata{thesistype}}
\newcommand{\@previousdegrees}{PREVIOUS DEGREES \@MissingMetadata{previousdegrees}}
\newcommand{\@degree}{DEGREE \@MissingMetadata{degree}}
\newcommand{\@department}{DEPARTMENT \@MissingMetadata{department}}
\newcommand{\@copyrightyear}{YEAR \@MissingMetadata{copyrightyear}}
\newcommand{\@copyrightnotice}{%
    All rights reserved. This \MakeLowercase{\@thesistype} may not be reproduced in whole or in part, by photocopying or other means, without the permission of the author.
}

\newcommand{\@MissingMetadata}[1]{\ClassWarning{sfuthesis}{%
    Missing #1. Set this in the preamble to fix your frontmatter.
}}

\newcommand{\previousdegrees}[1]{\renewcommand{\@previousdegrees}{#1}}
\newcommand{\thesistype}[1]{\renewcommand{\@thesistype}{#1}}
\newcommand{\degree}[1]{\renewcommand{\@degree}{#1}}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\copyrightyear}[1]{\renewcommand{\@copyrightyear}{#1}}
\newcommand{\copyrightnotice}[1]{\renewcommand{\@copyrightnotice}{#1}}


%   COMMITTEE PAGE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Generates a correctly formatted committee page, provided a commitee is
%   given in the preamble as follows:
%
%   \committee{
%       \member{Name}{Supervisor}{Department}
%       \member{Name}{Role on Committee}{Department}
%   }
%
%   To display the committee, invoke \makecommittee.
%


\newcommand{\makecommittee}{
    \addtoToC{Supervisory Committee}
                    \begin{center}
                        \@title                             \\[12pt]
                          by                                \\[12pt]

                        \@author                            \\
                   \@previousdegrees                        \\[12pt]
                      \end{center}                          \vfill

    \noindent Supervisory Committee                         \\[12pt]
    \@committee                                             \vfill
    \newpage
}

%   Implementation: Have \@committee store the committee, \committee set it,
%   and \chair and \member format its contents.

\newcommand{\@committee}{}
\newcommand{\committee}[1]{\renewcommand\@committee{#1}}
\newcommand{\member}[3]{\noindent #1, #2\\(#3)\\[12pt]}

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