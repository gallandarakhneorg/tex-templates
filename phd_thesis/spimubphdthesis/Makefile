FILE ?= upmethodology-spimubphdthesis-doc

TEXFILE=${FILE}.tex
DVIFILE=${FILE}.dvi
PDFFILE=${FILE}.pdf
PSFILE=${FILE}.ps
BBLFILE=${FILE}.bbl
AUXFILE=${FILE}.aux

TEXFILES = ${TEXFILE} $(shell find . -name "*.tex" -path "./*/*")

XFIG_FIG=        $(shell find . -name "*.fig" -a ! -name "*.ltx.fig")
PSTEX_FIG=       $(shell find . -name "*.ltx.fig")
EPSGZ_FIG=       $(shell find . -name "*.eps.gz")
PNGGZ_FIG=       $(shell find . -name "*.png.gz")
SVG_FIG=         $(shell find . -name "*.svg")

EPS_XFIG=          $(addsuffix .eps,          $(basename ${XFIG_FIG}))
PSTEX_XFIG=        $(addsuffix .pstex,        $(basename $(basename ${PSTEX_FIG})))
PDF_PSTEX=         $(addsuffix .pdf,          $(basename ${PSTEX_XFIG}))
PSTEX_T_XFIG=      $(addsuffix .pstex_t,      $(basename $(basename ${PSTEX_FIG})))
EPS_EPSGZ=         $(addsuffix .eps,          $(basename $(basename ${EPSGZ_FIG})))
PNG_PNGGZ=         $(addsuffix .png,          $(basename $(basename ${PNGGZ_FIG})))
PDF_XFIG=          $(addsuffix .pdf,          $(basename ${EPS_XFIG}))
PNG_SVG=           $(addsuffix .png,          $(basename ${SVG_FIG}))
EPS_SVG=           $(addsuffix .eps,          $(basename ${SVG_FIG}))
PDF_SVG=           $(addsuffix .pdf,          $(basename ${SVG_FIG}))

TMPIMAGES= $(EPS_SVG)
IMAGES= $(EPS_XFIG) $(PSTEX_XFIG) $(PSTEX_T_XFIG) $(EPS_EPSGZ) $(PNG_PNGGZ) $(PDF_XFIG) $(PDF_SVG) $(PDF_PSTEX)

TMPFILES = *.aux *.log *.dvi *.bbl *.blg \
	   *.cb *.toc *.out *.lof *.lot *.los *.lom *.tmp \
	   $(shell find . -name "*~") \
	   $(shell find . -name "*.bak") \
	   $(shell find . -name "*.backup") \
	   $(shell find . -name "auto")

all: pdf

pdf: gen_pdf
ifeq ("${PDF_VIEWER}","")
	@ if `which evince 2>/dev/null >/dev/null`; \
	then \
		evince ${PDFFILE}; \
	elif `which acroread 2>/dev/null >/dev/null`; \
	then \
		acroread ${PDFFILE}; \
	elif `which xpdf 2>/dev/null >/dev/null`; \
	then \
		xpdf ${PDFFILE}; \
	fi	
else
	$$PDF_VIEWER ${PDFFILE}
endif

gen_pdf: ${TEXFILES} $(IMAGES)
	@ touch ${BBLFILE}&& \
	  pdflatex ${FILE} && \
	  if grep "\\citation" ${AUXFILE}; then \
	    bibtex ${FILE} && \
	    pdflatex ${FILE}; \
	  fi && \
	  pdflatex ${FILE} && \
	  pdflatex ${FILE}

bibtex: ${TEXFILES} $(IMAGES)
	@ pdflatex ${FILE} && \
          bibtex ${FILE}

clean:
	@ rm -f ${TMPFILES}

cleanall: clean
	@ rm -f ${PDFFILE} ${PSFILE} ${IMAGES} $(TMPIMAGES)

images: ${IMAGES}

showimages:
	@echo ${IMAGES}

$(EPS_XFIG): %.eps: %.fig
	@ fig2dev -L eps "$<" "$@"

$(PDF_XFIG): %.pdf: %.eps
	@ epstopdf --outfile="$@" "$<"

$(PDF_PSTEX): %.pdf: %.pstex
	@ epstopdf --outfile="$@" "$<"

$(PSTEX_XFIG): %.pstex: %.ltx.fig
	@ fig2dev -L pstex "$<" "$@"

$(PSTEX_T_XFIG): %.pstex_t: %.ltx.fig
	@ fig2dev -L pstex_t -p $*.pstex "$<" "$@" && \
	perl -p -i -e "s/.pstex//;" "$@"
#perl -p -i -e "s/.pstex//;s/includegraphics{/includegraphics[\\\\psteximgoptions]{/;" "$@"

$(EPS_EPSGZ): %.eps: %.eps.gz
	@ zcat "$<" > "$@"

$(PNG_PNGGZ): %.png: %.png.gz
	@ zcat "$<" > "$@"

$(PNG_SVG): %.png: %.svg
	@ inkscape --without-gui --export-png="$@" --export-background-opacity=0.0 --export-dpi=160 "$<"

$(EPS_SVG): %.eps: %.svg
	@ inkscape --without-gui --export-eps="$@" "$<"

$(PDF_SVG): %.pdf: %.eps
	@ epstopdf --outfile="$@" "$<"
