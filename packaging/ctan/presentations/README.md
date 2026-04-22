# ciad-beamertheme

The CIAD Beamer Theme, classes and packages constitute a comprehensive LaTeX presentation theme designed from the guidelines and recommandations from the ["Connaissance et Intelligence Artificielle Distribuees"](https://www.ciad-lab.fr) (CIAD UR 7533) research laboratory at the ["Universite de Technologie Belfort Montbeliard"](https://www.utbm.fr) and ["Universite Bourgogne Europe"](https://www.ube.fr) in France.

It provides a professional, visually consistent presentation style with an extensive set of high-level commands that emulate the ease of use found in PowerPoint's Smart Objects and other graphical layout tools.

These Beamer Theme, classes and packages could be easily extended and adapted to reach the requirements and recommandations from your own institution.

ciad-beamertheme is part of the larger project [TeX-templates](https://www.arakhne.org/latex/tex-templates).

## 1. Major Features

### 1.1. PowerPoint-like Smart Objects

The theme offers numerous ready-to-use slide layouts and graphical components that function like PowerPoint's smart objects, allowing you to build complex, polished slides without manual positioning:


| Feature            | Command/Environment              | Purpose                                          |
|--------------------|----------------------------------|--------------------------------------------------|
| Title on the right | `righttitleframe`                | Slide with an additional title on the right side |
| Text + Picture     | `textpictureframe`               | Text on left, image in a green area on the right |
| Left/Right Lawn    | `leftlawnframe`/`rightlawnframe` | Vertical green area with text and a picture      |
| Grid of Icons      | `\cell`, \addgridpicture`        | Arrange icons in a grid with descriptive text    |
| Single Figure      | `figureslide`                    | Full-slide centered figure                       |
| Animated Figure    | `animatedfigureslide`            | Multi-layer SVG animation across frames          |
| Embedded Video     | `embeddedvideoslide`             | Full-slide embedded video                        |
| Text + Video       | `textvideoframe`                 | Text on left, video player on the right          |
| Book Description   | `libraryslide`                   | Dedicated slide for book presentation            |
| Final Slide        | `thanksslide`                    | Automatic ending slide (thanks/questions)        |


### 1.2. Predefined Boxes & Blocks

Create consistent, styled content blocks with simple commands:

* Basic bordered box
* Box with a title header
* Decorative box with corner triangle and icon
* Vertical/horizontal icon boxes
* Blocks with circular side anchors
* Arrow sequences with custom colors and decorations


### 1.3. Visual Customization

* 10 predefined background pictures (set globally or per frame)
* Random background selection from candidate images
* Customizable title page with replaceable left, right, and background figures
* Color palette: `CIADblue`, `CIADmagenta`, `CIADgreen`, `CIADdarkgreen`, `CIADlightgreen`, `CIADdarkgray`, `CIADlightgray`, and more
* Code highlighting styles (keyword, string, comment, identifier)


### 1.4. Special Title Pages

* Standard presentation: with standard title page from the theme
* PhD/Master oral defense: dedicated layout with `oraldefense` option
* Conference presentation: dedicated layout with `conferencepresentation` option
* Configurable logos, background, date, and place


### 1.5. Enhanced Text & Lists

* Compact versions of `itemize`, `description`, and `enumerate` environments
* Colorized tables with `stabularx` environment
* Fancy first letters (`\colorizedfirstletters`) and tail words (`\colorizedtailwords`)
* Localized quotes (English, French, Latin)
* Emphasized text with `\emph` and `\Emph`
* Notes or citations on the side of the slide


### 1.6. Embedded videos

- `\embeddedvideo`: Inline video player
- More slides with embedded videos


### 1.7. Documentation & Tutorial

Full documentation is available on https://www.arakhne.org/latex/tex-templates or https://www.arakhne.org/download/latex/slides%20-%20beamer/ciadbeamer-documentation.pdf . It is strongly recommended to read the Beamer user guide alongside this theme documentation.

A tutorial is also available: https://www.arakhne.org/latex/tex-templates/ciadslides_tutorial.html

## 2. Requirements

- Beamer class
- xcolor package
- PGF/TikZ
- AutoLaTeX (for animated figures)

## 3. Download

The package is available for downloading from the official webpage at https://www.arakhne.org/latex/tex-templates/

## 4. Licenses

- All LaTeX source code (everything in the `src/` a`nd `doc/` directories) is licensed under the GNU Lesser General Public License v3.0.
- The university and institution logos (in the `logos/` directory) are not free software. They are included with permission of the university and institution and may be redistributed unchanged, but may not be modified. See `logos/LICENSE.logos` for details.
    
