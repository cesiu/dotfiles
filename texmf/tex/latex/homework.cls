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
    \newcommand{\ShowDueDate}{Due: \DueDate}

    % redefine the make title command
    \renewcommand\maketitle{
        \thispagestyle{handouttitle}
        \begin{center}
            \LARGE{\HandoutTitle} \\
            \large\textbf{\ShowDueDate}\Student \\
        \end{center}
    }

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
    \newcommand{\solnstamp}{\large \textcolor{\solncolor}{\textbf{SOLUTION}}}

    %The command \soln{length}{text} takes two arguments.
    %The length is the amount of vertical space to display when the solution is not shown.
    %The text is the text of the solution to display when the solution is displayed.
    \newcommand{\soln}[2]{
        \ifthenelse{\boolean{@showsolns}} {
            \begin{solution}
                {#2}
            \end{solution}
        } {
            \vspace{#1}
        }
    }

    % This version of soln works for highlighting existing text, e.g., for
    %  multiple choice questions.
    \newcommand{\solninline}[1]{
        \ifthenelse{\boolean{@showsolns}} {
            \begin{solution}
                {#1}
            \end{solution}
        } {
            {#1}
        }
    }

    % This version of soln lets you specify the non-soln text. Also useful for
    %  inputting the vspace command yourself when used with cprotect.
    \newcommand{\solnraw}[2]{
        \ifthenelse{\boolean{@showsolns}} {
            \begin{solution}
                {#2}
            \end{solution}
        } {
            {#1}
        }
    }

    % This version of soln takes a list of characters and prints blanks
    %  that are underlined.
    \newcommand{\solnblanks}[1]{
        \ifthenelse{\boolean{@showsolns}} {
            \vspace{0.75em}
            \begin{solution}
                \foreach \char in {#1} {
                    \texttt{\,~\char~\,}
                }
            \end{solution}
        } {
            \vspace{2em}
        }

        \foreach \char in {#1} {
            \ifthenelse{\equal{\char}{~}} {
                \texttt{~~~~}
            } {
                \underline{\texttt{~~~~}}
            }
            % Spacing might be a little off here...this works experimentally.
            \hspace{-1.125em}
        }
    }

    %\ExecuteOptions{solution}
% --- Define the Header and Footer Styles ---

    % The style for the page with \maketitle called on it.
    \fancypagestyle{handouttitle} {
        \renewcommand\headrulewidth{0.5pt}
        \renewcommand\footrulewidth{0.5pt}
        \chead{}
        \cfoot{\thepage\ of \pageref{LastPage}}
        \rhead{\Blank \small \Semester}
        \ifthenelse{\boolean{@showsolns}}{
            \renewcommand\headsep{25pt}
            \lhead{ \solnstamp \\ \small \CourseTitle }
            \lfoot{\solnstamp}
        }{
            \lhead{ \small \CourseTitle }
            \lfoot{}
        }
    }

    % The style for pages without \maketitle called on it.
    \fancypagestyle{homework} {
        \renewcommand\headrulewidth{0.5pt}
        \renewcommand\footrulewidth{0.5pt}
        \chead{}
        \cfoot{\thepage\ of \pageref{LastPage}}
        \rhead{ \Blank \textbf{\small \HandoutTitle} \\  \small \textbf{\ShowDueDate} }
        \ifthenelse{\boolean{@showsolns}}{
            \renewcommand\headsep{14pt}
            \lhead{ \solnstamp \\ \small \CourseTitle \\ \Semester\ }
            \lfoot{\solnstamp}
        }{
            \lhead{ \small \CourseTitle \\ \Semester\ }
            \lfoot{}
        }
    }

% Set the default page style to homework.
    \pagestyle{homework}
