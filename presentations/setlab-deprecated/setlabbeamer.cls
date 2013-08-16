% Copyright (c) 2013 Stephane GALLAND <galland@arakhne.org>
%
% UTBM, IRTES  and SET logos and names are registered and owned by the
% "Universite de Technology of Belfort-Montbeliard".
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
%
% Creation date: 2013-05-27
% Modifications:
%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]

\ProvidesClass{setlabbeamer}
   [2013/05/27 v1.0 Class for IRTES-SET slides]

\gdef\beamer@theme@setlab@classlang{english}%

\DeclareOption{english}{%
  \gdef\beamer@theme@setlab@classlang{english}%
}
\DeclareOption{french}{%
  \gdef\beamer@theme@setlab@classlang{french}%
}
\DeclareOption{francais}{%
  \gdef\beamer@theme@setlab@classlang{french}%
}

\ProcessOptions*\relax

\expandafter\LoadClass[pdflatex,\beamer@theme@setlab@classlang,notes=hide]{beamer}

\RequirePackage[T1]{fontenc}
\RequirePackage{ifthen}
\RequirePackage{color}
\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{hyperref}
\RequirePackage{url}

\DeclareGraphicsExtensions{.pdf,.png,.jpg,.jpeg}

\usetheme[language=Java]{IRTES}

\gdef\@beamer@setlab@unstituteurl{http://set.utbm.fr}
\newcommand{\instituteurl}[1]{%
	\gdef\@beamer@setlab@unstituteurl{#1}
}

\institute[IRTES-SET]{
	\textbf{Universit\'e de Technologie de Belfort-Montb\'eliard}, \\[0cm]
	90010 Belfort cedex, France - \expandafter\url{\@beamer@setlab@unstituteurl}
}

