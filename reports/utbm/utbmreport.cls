% Document class for the UTBM reports
%
% Copyright (c) 2013-14 Stephane GALLAND <galland@arakhne.org>
% 
% This program is free library; you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as
% published by the Free Software Foundation; either version 3 of the
% License, or any later version.
%
% This library is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; see the file COPYING.  If not,
% write to the Free Software Foundation, Inc., 59 Temple Place - Suite
% 330, Boston, MA 02111-1307, USA.

%%--------------------
%% Declare the LaTeX class
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{utbmreport}[2014/03/03]

%%--------------------
%% Class options
\gdef\utbmreportclasslanguage{french}
\gdef\utbm@report@class@options{}

\DeclareOption{english}{%
	\gdef\utbmreportclasslanguage{english}%
}
\DeclareOption{french}{%
	\gdef\utbmreportclasslanguage{french}%
}

\DeclareOption*{%
	\xdef\utbm@report@class@options{\utbm@report@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

%%--------------------
%% Load the document style
\expandafter\LoadClass[\utbmreportclasslanguage\utbm@report@class@options]{upmethodology-document}

%%--------------------
%% Check for the correct version of tex-upmethodology
\@ifclasslater{UPMVERSION}{2014/03/02}{}{\@latex@error{You must install a version of tex-upmethodology greater or equal to 20140303}\@eha}

%%--------------------
%% Use the style dedicated to UTBM report
\UseExtension{utbm}

%%--------------------
%% Force the name of the bibliographie for French
\AtBeginDocument{
	\ifthenelse{\equal{\utbmreportclasslanguage}{french}}{%
		\renewcommand{\refname}{Bibliographie}%
		\renewcommand{\listtablename}{Liste des tables}%
	}{}
}

%%--------------------
%% Add a small message on the backcover.
\Set{backcovermessage}{%
	\begin{center}\scriptsize
		\ifthenelse{\equal{french}{\upmcurrentlang}}{
			Document r\'ealis\'e avec \LaTeX\ et : \\
			le style \LaTeX\ cr\'e\'e par S. Galland --- \url{http://www.multiagent.fr/ReportStyle} \\
			la collection de paquets \texttt{tex-upmethodology} --- \url{http://www.arakhne.org/tex-upmethodology/}\\[.25cm]
		}{
			Document generated with \LaTeX\ and: \\
			the \LaTeX\ style created by S. Galland --- \url{http://www.multiagent.fr/ReportStyle} \\
			the \texttt{tex-upmethodology} package suite --- \url{http://www.arakhne.org/tex-upmethodology/}\\[.25cm]
		}
	\end{center}
}

\endinput
