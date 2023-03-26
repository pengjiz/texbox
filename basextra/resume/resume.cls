% A simple document class for resumes

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2023/03/25 v0.1.0 Simple resume document class]

%% Option
\DeclareOption{a4paper}{%
  \setlength{\paperheight}{297mm}
  \setlength{\paperwidth}{210mm}}
\DeclareOption{letterpaper}{%
  \setlength{\paperheight}{11in}
  \setlength{\paperwidth}{8.5in}}

\newcommand*{\@ptsize}{}
\DeclareOption{10pt}{\renewcommand*{\@ptsize}{0}}
\DeclareOption{11pt}{\renewcommand*{\@ptsize}{1}}
\DeclareOption{12pt}{\renewcommand*{\@ptsize}{2}}

\DeclareOption{draft}{\setlength{\overfullrule}{5pt}}
\DeclareOption{final}{\setlength{\overfullrule}{0pt}}

\ExecuteOptions{a4paper,11pt,final}
\ProcessOptions{}

%% Fundamental
\input{size1\@ptsize.clo}
\RequirePackage{etoolbox}

\setlength{\lineskip}{1\p@}
\setlength{\normallineskip}{1\p@}
\renewcommand*{\baselinestretch}{}
\setlength{\parskip}{\z@}

\@lowpenalty=51
\@medpenalty=151
\@highpenalty=301

\onecolumn
\raggedbottom{}
\pagenumbering{arabic}
\pagestyle{plain}

%% Core
\newcommand*{\resume@firstname}{}
\newcommand*{\resume@lastname}{}
\newcommand*{\name}[2]{%
  \renewcommand*{\resume@firstname}{#1}
  \renewcommand*{\resume@lastname}{#2}}

\newcommand*{\resume@tagline}{}
\newcommand*{\tagline}[1]{\renewcommand*{\resume@tagline}{#1}}

\newcommand{\resume@titlextra}{}
\newcommand{\titlextra}[2][wrap]{%
  \renewcommand{\resume@titlextra}{%
    \ifstrequal{#1}{nowrap}{#2}{%
      \begin{tabular}[b]{r@{\hspace{0.5em}}l}#2\end{tabular}}}}

\newcommand*{\resume@headingstyle}{\bfseries}
\newcommand*{\headingstyle}[1]{\renewcommand*{\resume@headingstyle}{#1}}

\newcommand*{\maketitle}{%
  \par\addvspace{3.5ex}\@afterindentfalse%
  {\setlength{\parindent}{\z@}\raggedright\interlinepenalty=\@M\normalfont%
    \begin{minipage}[b]{0.5\textwidth}
      \huge\resume@headingstyle\resume@firstname~\resume@lastname
    \end{minipage}%
    \hfill%
    \begin{minipage}[b]{0.5\textwidth}
      \begin{flushright}\resume@titlextra\end{flushright}
    \end{minipage}%
    \ifdefempty{\resume@tagline}{}{%
      \par\addvspace{1ex}\emph{\resume@tagline}}%
    \par}\nobreak\addvspace{3ex}\@afterheading}

\newcommand*{\section}[1]{%
  \par\addvspace{3ex}\@afterindentfalse%
  \phantomsection\addcontentsline{toc}{section}{#1}%
  {\setlength{\parindent}{\z@}\raggedright\interlinepenalty=\@M\normalfont%
    \LARGE\resume@headingstyle #1\par}%
  \nobreak\addvspace{2.5ex}\@afterheading}

\newcommand*{\subsection}[1]{%
  \par\addvspace{2.5ex}\@afterindentfalse%
  \phantomsection\addcontentsline{toc}{subsection}{#1}%
  {\setlength{\parindent}{\z@}\raggedright\interlinepenalty=\@M\normalfont%
    \Large\resume@headingstyle #1\par}%
  \nobreak\addvspace{2ex}\@afterheading}

\newenvironment{block}[1]{%
  \par\addvspace{1.5ex}\@afterindentfalse%
  \ifstrempty{#1}{}{%
    {\setlength{\parindent}{\z@}#1\par}%
    \nobreak\addvspace{1ex}}%
  \@afterheading%
}{\par\addvspace{1.5ex}}

%% List
\setlength{\leftmargin}{1.5em}
\setlength{\leftmargini}{\leftmargin}
\setlength{\leftmarginii}{\leftmargin}
\setlength{\leftmarginiii}{\leftmargin}
\setlength{\leftmarginiv}{\leftmargin}
\setlength{\labelsep}{0.5em}
\setlength{\labelwidth}{\leftmargin}
\addtolength{\labelwidth}{-\labelsep}

\@beginparpenalty=-\@lowpenalty
\@endparpenalty=-\@lowpenalty
\@itempenalty=-\@lowpenalty

\newcommand*{\labelitemfont}{\normalfont}
\newcommand*{\labelitemi}{\labelitemfont\textbullet}
\newcommand*{\labelitemii}{\labelitemfont\bfseries\textendash}
\newcommand*{\labelitemiii}{\labelitemfont\textasteriskcentered}
\newcommand*{\labelitemiv}{\labelitemfont\textperiodcentered}

\renewcommand*{\theenumi}{\@arabic\c@enumi}
\renewcommand*{\theenumii}{\@alph\c@enumii}
\renewcommand*{\theenumiii}{\@roman\c@enumiii}
\renewcommand*{\theenumiv}{\Alph\c@enumiv}
\newcommand*{\labelenumi}{\theenumi.}
\newcommand*{\labelenumii}{(\theenumii)}
\newcommand*{\labelenumiii}{\theenumiii.}
\newcommand*{\labelenumiv}{\theenumiv.}
\renewcommand*{\p@enumii}{\theenumi}
\renewcommand*{\p@enumiii}{\theenumi(\theenumii)}
\renewcommand*{\p@enumiv}{\p@enumiii\theenumiii}

\newcommand*{\descriptionlabel}[1]{%
  \hspace{\labelsep}\normalfont\bfseries #1}
\newenvironment*{description}{%
  \list{}{\setlength{\labelwidth}{\z@}%
    \setlength{\itemindent}{-\leftmargin}%
    \let\makelabel\descriptionlabel}%
}{\endlist}

\RequirePackage{enumitem}
\setlist{nosep}

%% Extra
\setcounter{tocdepth}{2}
\AtEndPreamble{%
  \RequirePackage{hyperref}
  \hypersetup{%
    hidelinks=true,
    pdfauthor={\resume@firstname~\resume@lastname},
    pdftitle={Resume of \resume@firstname~\resume@lastname},
    pdfsubject={Resume of \resume@firstname~\resume@lastname},
    pdfkeywords={\resume@firstname~\resume@lastname, resume},
    pdfpagemode=UseNone,
    bookmarksopen=true}}

\endinput
