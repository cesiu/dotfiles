% ------
% This is a handout document class. It is based on the article class. It is design for creating handouts for a college class
% Created By: Roger Cortesi, 27 JUN 2007
% ----
% ---- Identification -----

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}

% ---- Initial Code ----

\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{color}

\newboolean{@showsolns} % The boolean which will determine if the solutions are displayed.
\pagenumbering{arabic}



% ---- Declare Options ----

\DeclareOption{solution}{\setboolean{@showsolns}{true}}
\DeclareOption*

% ---- Execution of Options ----

\ProcessOptions \relax

% --- Package Loading ----

\LoadClass{article}

% ---- Main Code ----

% --- Setup the Page Layout ---
    \setlength\textwidth{6.5in}
    \setlength\textheight{8.75in}
    \setlength\oddsidemargin{0in}
    \setlength\evensidemargin{1in}
    \setlength\topmargin{-0.25in}
    \setlength\parindent{0in}
    \setlength\parskip{0.5em}

% --- Define Some Useful Commands ---
    % Define the default values for these commands
    \newcommand{\CourseTitle}{}
    \newcommand{\HandoutTitle}{}
    \newcommand{\DueDate}{}
    \newcommand{\Student}{}
    \newcommand{\Instructor}{}
    \newcommand{\Semester}{}
    \newcommand{\Blank}{}

    % change the values if the user sets these commands
    \newcommand{\SetCourseTitle}[1]{\renewcommand{\CourseTitle}{#1}}
    \newcommand{\SetHandoutTitle}[1]{\renewcommand{\HandoutTitle}{#1}}
    \newcommand{\SetDueDate}[1]{\renewcommand{\DueDate}{#1}}
    \newcommand{\SetStudent}[1]{\renewcommand{\Student}{#1}}
    \newcommand{\SetInstructor}[1]{\renewcommand{\Instructor}{#1}}
    \newcommand{\SetSemester}[1]{\renewcommand{\Semester}{#1}}
    \newcommand{\ShowNameBlank}{\renewcommand{\Blank}{\large Name:\rule{2in}{0.5pt}\\}}
    \newcommand{\ShowNameDateBlanks}{\renewcommand{\Blank}{\large Name:\rule{2in}%
        {0.5pt} Date:\rule{0.75in}{0.5pt}\\}}
    \newcommand{\ShowAllBlanks}{\renewcommand{\Blank}{\large Name:\rule{2in}%
        {0.5pt} Section:\rule{0.75in}{0.5pt} Date:\rule{0.75in}{0.5pt}\\}}
    \newcommand{\ShowDueDate}{\ifthenelse{\NOT\equal{\DueDate}{\empty}}{Due: \DueDate}{}}

    % redefine the make title command
    \newcommand{\ShowDatedTitle}{
        \thispagestyle{handouttitle}
        \begin{center}
            \LARGE{\HandoutTitle} \\
            \large\textbf{\ShowDueDate}\Student \\
        \end{center}
    }

    \newcommand{\ShowUndatedTitle}{
        \thispagestyle{handouttitle}
        \begin{center}
            \LARGE{\HandoutTitle} \\
        \end{center}
    }

    \renewcommand{\maketitle}{\ShowDatedTitle}

    % Redefine the sectioning commands \section \subsection and \subsubsection
    \renewcommand\section{\@startsection
        {section}{2}{0mm}{0.1\baselineskip}{0.1\baselineskip}{\normalfont\large\textbf}
    }
    \renewcommand\subsection{\@startsection
        {subsection}{2}{0mm}{0.1\baselineskip}{0.1\baselineskip}{\normalfont\normalsize\textbf}
    }
    \renewcommand\subsubsection{\@startsection
        {subsubsection}{2}{0mm}{0.1\baselineskip}{0.1\baselineskip}{\normalfont\normalsize\textbf}
    }

    % Create a question environment
    \newcounter{questionnumber}
    \newenvironment{questions}
        {   \begin{enumerate}
            \setcounter{enumi}{\thequestionnumber}
        }
        {   \setcounter{questionnumber}{\theenumi}
            \end{enumerate}
        }

    % Create a solution environment and code to toggle showing and hiding solutions.
    \ifthenelse{\NOT\isundefined{\makesolution}}{\setboolean{@showsolns}{true}}{}

    \ifthenelse{\boolean{@showsolns}}{}{\setboolean{@showsolns}{false}} % if the solution option was not passed don't set default to not display solutions.

    % The color to display the solution and solution stamps in.
    \newcommand{\solncolor}{red}
    % The command to change the color for the solutions.
    \newcommand{\setsolncolor}[1]{\renewcommand{\solncolor}{#1}}

    % The solution environment.
    \newenvironment{solution}{\color{\solncolor} \em }{}

    % \showsoln displays the solutions for the document.
    \newcommand{\showsoln}{\setboolean{@showsolns}{true} \pagestyle{homework}}
    % \hidesoln hides the solutions for the document.
    \newcommand{\hidesoln}{\setboolean{@showsolns}{false}}
    % This is the solution stamp put at the top and bottom of each page.
    \newcommand{\solnstamp}{\small \textcolor{\solncolor}{\textbf{SOLUTION}}}

    % Defines \solnraw{given}{soln}, which optionally hides an answer:
    %  given - Any text to be shown outside of solutions
    %  soln  - Any text to be shown inside of solutions
    \newcommand{\solnraw}[2]{
        \ifthenelse{\boolean{@showsolns}} {
            \begin{solution}
                {#2}
            \end{solution}
        } {
            {#1}
        }
    }

    % Defines \soln{height}{answer}, which also leaves space for an answer.
    \newcommand{\soln}[2]{
        \begin{minipage}[t][#1][t]{\linewidth}
            \setlength{\parskip}{0.25em}
            \setitemize{nosep, itemsep=0.25em}
            \setenumerate{nosep, itemsep=0.25em}
            \solnraw{\vphantom{}}{#2}
        \end{minipage}
    }

    % Defines \solnbox{height}{answer}, which also boxes space for an answer.
    \newcommand{\solnbox}[2]{\fbox{\soln{#1}{#2}}}

    % Defines \solninline{answer}, which only highlights a given answer.
    \newcommand{\solninline}[1]{\solnraw{#1}{#1}}

    %\ExecuteOptions{solution}
% --- Define the Header and Footer Styles ---

    % The style for the page with \maketitle called on it.
    \fancypagestyle{handouttitle} {
        \renewcommand\headrulewidth{0.5pt}
        \renewcommand\footrulewidth{0.5pt}
        \lhead{ \small \CourseTitle }
        \rhead{\Blank \small \Semester}
        \lfoot{}
        \cfoot{\thepage\ of \pageref{LastPage}}
        \rfoot{}
        \ifthenelse{\boolean{@showsolns}}{
            \chead{\solnstamp}
        }{
            \chead{}
        }
    }

    % The style for pages without \maketitle called on it.
    \fancypagestyle{homework} {
        \renewcommand\headrulewidth{0.5pt}
        \renewcommand\footrulewidth{0.5pt}
        \lhead{ \small \CourseTitle \\ \Semester\ }
        \chead{}
        \lfoot{}
        \cfoot{\thepage\ of \pageref{LastPage}}
        \rfoot{}
        \ifthenelse{\boolean{@showsolns}}{
            \rhead{ \Blank \textbf{\small \HandoutTitle} \\ \solnstamp }
        }{
            \rhead{ \Blank \textbf{\small \HandoutTitle} \\ \small \textbf{\ShowDueDate} }
        }
    }

% Set the default page style to homework.
    \pagestyle{homework}
