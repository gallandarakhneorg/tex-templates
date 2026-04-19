#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (C) 2026 Stephane Galland <galland@arakhne.org>
#
# This program is free library; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation; either version 3 of the
# License, or any later version.
#
# This library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; see the file COPYING.  If not,
# write to the Free Software Foundation, Inc., 59 Temple Place - Suite
# 330, Boston, MA 02111-1307, USA.

"""
setup.py - A minimal packaging script for tex-templates project.

Usage:
    python3 setup.py build          # Build the source files
    python3 setup.py sdist          # Create a source distribution archive
    python3 setup.py clean          # Clean the folders
    python3 setup.py deb            # Create the Debian packages
"""

import os
import sys
import re
import tarfile
import shutil
import subprocess
import argparse
from colorama import init, Fore, Style
from abc import ABC
from builtins import property
from datetime import datetime
from tempfile import TemporaryDirectory

from pip._internal.utils import temp_dir

BUILD_DIR = "build"

DIST_DIR = "dist"

DEBIAN_SIGN_EMAIL = "galland@arakhne.org"
DEBIAN_COMPRESS_WITH = "gzip"

SOURCE_DIRS = ["presentations", "reports", "spim", "papers"]
INFO_FILES = ['AUTHORS', 'Changelog', 'COPYING', 'README', 'VERSION']

CTAN_SOURCE_DIRS = {
    'ciad-beamertheme': {
        os.path.join('presentations', 'ciad-2025'): '',
        os.path.join('spim', 'README_CTAN'): 'README',
        os.path.join('spim', 'VERSION_CTAN'): 'VERSION'
    },
    'utbmciad-report': {
        os.path.join('reports', 'utbmciad-2025'): '',
        os.path.join('spim', 'README_CTAN'): 'README',
        os.path.join('spim', 'VERSION_CTAN'): 'VERSION'
    },
    'spim-phdthesisthemes': {
        os.path.join('spim', 'share', 'bst'): 'share',
        os.path.join('spim', 'share', 'sty'): 'share',
        os.path.join('spim', 'utbm', 'spimutbmphdthesis'): 'utbm',
        os.path.join('spim', 'umlp', 'spimumlpphdthesis'): 'umlp',
        os.path.join('spim', 'ube', 'spimubephdthesis'): 'ube',
        os.path.join('spim', 'README_CTAN'): 'README',
        os.path.join('spim', 'VERSION_CTAN'): 'VERSION'
    }
}
CTAN_INFO_FILES = ['AUTHORS', 'Changelog', 'COPYING']


class SetupCommand(ABC):

    def __init__(self, root_dir : str, dist_dir : str = DIST_DIR, build_dir : str = BUILD_DIR, verbosity : int = 0):
        """
        :param root_dir: the path to the root folder of TeX-templates
        :param dist_dir: the basename of the source distribution folder in which all the archives will be copied.
        :param build_dir: the basename of the temporary folder in which all results of building will be copied.
        :param verbosity: level of verbosity.
        """
        self.__verbosity = verbosity
        self.__current_version = None
        self.__current_tex_version = None
        self._root_dir = root_dir
        self._dist_dir = dist_dir
        self._build_dir = build_dir

    @property
    def current_version(self) -> str:
        if self.__current_version is None:
            self.__current_version = datetime.now().strftime("%Y%m%d")
            self.__current_tex_version = datetime.now().strftime("%Y/%m/%d")
        return self.__current_version

    @property
    def current_tex_version(self) -> str:
        if self.__current_tex_version is None:
            self.__current_tex_version = datetime.now().strftime("%Y/%m/%d")
            self.__current_version = datetime.now().strftime("%Y%m%d")
        return self.__current_tex_version

    def _get_archive_basename(self, name : str) -> str:
        """
        Compute the basename of the archive file.
        :param name: the name of the archived component.
        :return: the basename.
        """
        version_file = os.path.join(self._root_dir, 'VERSION')
        with open(version_file, 'r') as version_f:
            version_number = str(version_f.read()).strip()
        m = re.search(r'-([^-]+)$', version_number)
        if m:
            version_number = m.group(1)
        return f"{name}-{version_number}"

    def _get_archive_name(self, name : str) -> str:
        """
        Compute the name of the archive file with the ".tar.gz" extension.
        :param name: the name of the archived component.
        :return: the basename with ".tar.gz".
        """
        return self._get_archive_basename(name) + ".tar.gz"

    def _compute_sdist_archive_name(self, name : str) -> str:
        """
        Compute the filename of the sdist archive.
        :param name: the basename of the archive to generate.
        :return: the full path to the archive file.
        """
        dist_dir = os.path.join(self._root_dir, self._dist_dir)
        os.makedirs(dist_dir, exist_ok=True)
        archive_name = self._get_archive_name(name)
        archive_path = os.path.join(dist_dir, archive_name)
        return archive_path

    def error(self, *messages : str):
        """
        Show up an error message. This function exists the script with return code to 255.
        :param messages: the list of error messages. Each one will be shown one a line.
        """
        for message in messages:
            print(Fore.RED + f"ERROR  : {message}" + Style.RESET_ALL)
        sys.exit(255)

    def info(self, *messages : str):
        """
        Show up an information message.
        :param messages: the list of information messages. Each one will be shown one a line.
        """
        for message in messages:
            print(Fore.BLUE + "INFO   :" + Style.RESET_ALL + f" {message}")

    def info2(self, *messages : str):
        """
        Show up an information message of second level.
        :param messages: the list of information messages. Each one will be shown one a line.
        """
        if self.__verbosity >= 1:
            for message in messages:
                print(Fore.BLUE + "INFO   :     " + Style.RESET_ALL + f" {message}")

    def info3(self, *messages : str):
        """
        Show up an information message of third level.
        :param messages: the list of information messages. Each one will be shown one a line.
        """
        if self.__verbosity >= 2:
            for message in messages:
                print(Fore.BLUE + "INFO   :     " + Style.RESET_ALL + f" {message}")

    def success(self, *messages : str):
        """
        Show up a success message.
        :param messages: the list of information messages. Each one will be shown one a line.
        """
        for message in messages:
            print(Fore.GREEN + "SUCCESS:" + Style.RESET_ALL + f" {message}")


class CleanManager(SetupCommand):

    def __init__(self, root_dir : str,
                 dist_dir : str = DIST_DIR,
                 build_dir : str = BUILD_DIR,
                 verbosity : int = 0):
        """
        :param root_dir: the path to the root folder of TeX-templates
        :param dist_dir: the basename of the folder in which all the archives will be copied.
        :param build_dir: the basename of the folder in which the output of the building is copied.
        :param verbosity: level of verbosity.
        """
        super().__init__(root_dir, dist_dir, build_dir, verbosity)

    def run(self):
        removed_count = 0
        for cleanable in [self._dist_dir, self._build_dir]:
            dist_dir = os.path.join(self._root_dir, cleanable)
            if os.path.isdir(dist_dir):
                shutil.rmtree(dist_dir)
                self.info(f"Directory {dist_dir} removed")
                removed_count += 1
        self.success(f"Cleaning complete. Removed {removed_count} item(s).")




class SourceDistributionManager(SetupCommand):

    def __init__(self, root_dir : str, archive_name : str, inner_folder_name : str, ctan : bool,
                 dist_dir : str = DIST_DIR,
                 build_dir: str = BUILD_DIR,
                 sources: list[str] = SOURCE_DIRS,
                 info_files: list[str] = INFO_FILES,
                 ctan_sources : dict[str,dict[str,str]] = CTAN_SOURCE_DIRS,
                 ctan_info_files : list[str] = CTAN_INFO_FILES,
                 verbosity : int = 0):
        """
        :param root_dir: the path to the root folder of TeX-templates
        :param archive_name: the expected name of the main sdist archive.
        :param inner_folder_name: the name of the folder that will contain all the files inside the main sdist archive.
        :param dist_dir: the basename of the source distribution folder in which all the archives will be copied.
        :param build_dir: the basename of the folder in which the output of the building is copied.
        :param ctan: indicates if the CTAN archive files should be generated.
        :param ctan_sources: the dictionary for all the source files to be included in the CTAN archives.
        :param ctan_info_files: the list of information files to be included in the CTAN archives.
        :param verbosity: level of verbosity.
        """
        super().__init__(root_dir, dist_dir, build_dir, verbosity)
        self.__archive_name = archive_name
        self.__inner_folder_name = inner_folder_name
        self.__ctan = ctan
        self.__sources = sources
        self.__info_files = info_files
        self.__ctan_sources = ctan_sources
        self.__ctan_info_files = ctan_info_files

    def _add_directory_to_tar(self, tar: tarfile.TarFile, dir_to_add: str, archive_parent: str):
        """
        Recursively add files from root_dir into tar under "archive_parent/".
        :param tar: The TAR archive.
        :param dir_to_add: The path to the root folder of the files to add in the TAR archive.
        :param archive_parent: The relative path to the parent folder inside the archive. All the added files
        will be inside this "archive_parent" folder.
        """
        if not os.path.isdir(dir_to_add):
            self.error(f"Directory '{dir_to_add}' not found.")
        for dirpath, dirnames, filenames in os.walk(dir_to_add):
            for filename in filenames:
                full_path = os.path.join(dirpath, filename)
                rel_path = os.path.relpath(full_path, start=dir_to_add)
                arcname = os.path.join(archive_parent, rel_path)
                tar.add(full_path, arcname=arcname, recursive=False)

    def generate_sdist_archive(self):
        """
        Generate the sdist archive.
        """
        archive_path = self._compute_sdist_archive_name(self.__archive_name)

        if os.path.isfile(archive_path):
            os.unlink(archive_path)

        self.info(f"Creating source distribution: {archive_path}")
        with tarfile.open(archive_path, "w:gz") as tar:
            for src_dir in self.__sources:
                self._add_directory_to_tar(tar, src_dir, os.path.join(self.__inner_folder_name, src_dir))
            for info_file in self.__info_files:
                full_info_file = os.path.join(self._root_dir, info_file)
                arcname = os.path.join(self.__inner_folder_name, info_file)
                tar.add(full_info_file, arcname=arcname, recursive=False)

    def generate_ctan_sdist_archives(self):
        """
        Create the archive files for CTAN.
        """
        for archive_name, archive_elements in self.__ctan_sources.items():
            archive_path = self._compute_sdist_archive_name(f'ctan-{archive_name}')
            self.info(f"Creating CTAN source distribution: {archive_path}")
            with tarfile.open(archive_path, "w:gz") as tar:
                for source_name, target_name in archive_elements.items():
                    src_element = os.path.join(self._root_dir, source_name)
                    if os.path.isfile(src_element):
                        tar.add(src_element, arcname=os.path.join(archive_name, target_name), recursive=False)
                    else:
                        self._add_directory_to_tar(tar, src_element, os.path.join(archive_name, target_name))
                    for info_file in self.__ctan_info_files:
                        full_info_file = os.path.join(self._root_dir, info_file)
                        arcname = os.path.join(archive_name, info_file)
                        tar.add(full_info_file, arcname=arcname, recursive=False)
            self.success("CTAN source distribution archive created successfully.")

    def run(self):
        """
        Create a source distribution archives.
        """
        # Always cleaning before generating the archives.
        clean_cmd = CleanManager(root_dir=self._root_dir, dist_dir=self._dist_dir)
        clean_cmd.run()
        # Run the distribution command
        self.generate_sdist_archive()
        if self.__ctan:
            self.generate_ctan_sdist_archives()




class BuildManager(SetupCommand):

    def __init__(self, root_dir : str,
                 dist_dir : str = DIST_DIR,
                 build_dir : str = BUILD_DIR,
                 debug : bool = False,
                 disable_readme : bool = False,
                 disable_version : bool = False,
                 disable_tex_version_update : bool = False,
                 disable_ciadslide : bool = False,
                 disable_ciadreport : bool = False,
                 disable_spimutbm : bool = False,
                 disable_spimube : bool = False,
                 disable_spimumlp : bool = False,
                 disable_ingedoc : bool = False,
                 disable_ctan : bool = False,
                 verbosity : int = 0):
        """
        :param root_dir: the path to the root folder of TeX-templates
        :param dist_dir: the basename of the folder in which all the source distribution files will be copied.
        :param build_dir: the basename of the folder in which all the built files will be copied.
        :param debug: indicates if the builder is invoked in debug mode. The behavior of the builder may differ in debug mode.
        :param disable_readme: Disable the building of the README file.
        :param disable_version: Disable the building of the VERSION file.
        :param disable_tex_version_updates: Disable the updates of the dates in the TeX files(sty, cls)
        :param disable_ciadslide: Disable the building of the CIAD Beamer template.
        :param disable_ciadreport: Disable the building of the CIAD report.
        :param disable_spimutbm: Disable the building of the SPIM/UTBM PhD thesis template.
        :param disable_spimube: Disable the building of the SPIM/UBE PhD thesis template.
        :param disable_spimumlp: Disable the building of the SPIM/UMLP PhD thesis template.
        :param disable_ingedoc: Disable the building of the IngeDoc template.
        :param disable_ctan: Disable the building of elements related to CTAN.
        :param verbosity: level of verbosity.
        """
        super().__init__(root_dir, dist_dir, build_dir, verbosity)
        self.__debug = debug
        self.__disable_readme = disable_readme
        self.__disable_version = disable_version
        self.__disable_tex_version_update = disable_tex_version_update
        self.__disable_ciadslide = disable_ciadslide
        self.__disable_ciadreport = disable_ciadreport
        self.__disable_spimutbm = disable_spimutbm
        self.__disable_spimube = disable_spimube
        self.__disable_spimumlp = disable_spimumlp
        self.__disable_ingedoc = disable_ingedoc
        self.__disable_ctan = disable_ctan

    @staticmethod
    def _run_pdflatex(temp_dir: TemporaryDirectory, tex_file: str):
        """
        Run the pdflatex command on the given document.
        """
        self.info(f"Compiling {tex_file} with pdflatex...")
        # Save current working directory
        original_cwd = os.getcwd()
        try:
            os.chdir(temp_dir.name)
            # Run pdflatex with nonstop mode to avoid hanging on errors
            cmd = ["pdflatex", "-interaction=nonstopmode", tex_file]
            result = subprocess.run(cmd, capture_output=True, text=True, errors="replace")
            if result.returncode != 0:
                temp_dir.cleanup()
                self.error("LaTeX compilation failed. Here is the log:",
                           result.stdout if result.stdout else "",
                           result.stderr if result.stderr else "")
            else:
                self.info("LaTeX compilation succeeded.")
                # Run a second time to resolve cross-references (not required but common)
                self.info("Running pdflatex again to resolve references...")
                result2 = subprocess.run(cmd, capture_output=True, text=True, errors="replace")
                if result2.returncode != 0:
                    temp_dir.cleanup()
                    self.error("Second compilation had issues.",
                               result.stdout if result.stdout else "",
                               result.stderr if result.stderr else "")
                else:
                    self.success("Documentation generated successfully.")
        finally:
            os.chdir(original_cwd)

    def _prepare_documentation_dir(self, src_dir: str, pdf_filename: str,
                                  *additional_src_dirs: str) -> TemporaryDirectory:
        """
        Prepare the tmp/ folder for the generation of documentation.
        :param src_dir: folder from which the documentation could be found.
        :param pdf_filename: name of the PDF file of the documentation.
        :param additional_src_dirs: additional src folders to add to the documentation building process.
        """
        # Check prerequisites
        if not os.path.isdir(src_dir):
            self.error(f"Directory '{src_dir}' not found.")
        for additional_src_dir in additional_src_dirs:
            if not os.path.isdir(additional_src_dir):
                self.error(f"Directory '{additional_src_dir}' not found.")
        tmp_dir = TemporaryDirectory(delete=False)
        documentation_pdf_file = os.path.join(tmp_dir.name, pdf_filename)
        for input_dir in [src_dir] + [*additional_src_dirs]:
            # Walk through src directory
            for root, dirs, files in os.walk(input_dir):
                # Compute relative path from src_dir
                rel_path = os.path.relpath(root, input_dir)
                # Target directory
                target_dir = os.path.join(tmp_dir.name, rel_path)
                # Create target directory if it doesn't exist
                os.makedirs(target_dir, exist_ok=True)
                for file in files:
                    src_file = os.path.join(root, file)
                    link_path = os.path.join(target_dir, file)
                    # If the link already exists and is a symlink, remove it first (to avoid errors)
                    if os.path.islink(link_path):
                        os.unlink(link_path)
                    if link_path != documentation_pdf_file:
                        # Create the symlink (relative or absolute? Use absolute to be safe)
                        try:
                            # Use absolute path for source to make symlink robust
                            os.symlink(src_file, link_path)
                        except Exception as e:
                            tmp_dir.cleanup()
                            self.error(f"Cannot create symlink {link_path}: {e}")
        # Remove the document file from the tmp folder
        if os.path.exists(documentation_pdf_file):
            os.unlink(documentation_pdf_file)
            self.info(f"File {documentation_pdf_file} removed")
        return tmp_dir

    def _generate_documentation(self, src_dir: str, tex_filename: str, *additional_src_dirs: str):
        """
        Build the documentation.
        :param src_dir: folder from which the documentation could be found.
        :param tex_filename: name of the TeX file of the documentation.
        :param additional_src_dirs: additional src folders to add to the documentation building process.
        """
        pdf_filename = os.path.splitext(tex_filename)[0] + '.pdf'
        tmp_dir = self._prepare_documentation_dir(src_dir, pdf_filename, *additional_src_dirs)
        try:
            BuildManager._run_pdflatex(tmp_dir, tex_filename)
            shutil.copyfile(os.path.join(tmp_dir.name, pdf_filename),
                            os.path.join(src_dir, pdf_filename))
            self.info(f"File {pdf_filename} copied.")
        finally:
            if not self.__debug:
                tmp_dir.cleanup()

    def generate_readme(self):
        """
        Build the README file.
        """
        pandoc_cmd = shutil.which("pandoc")
        if not pandoc_cmd:
            self.error('Pandoc command cannot be found')
        readme_input = os.path.join(self._root_dir, "README.textile")
        if not os.path.isfile(readme_input):
            self.error(f"File '{readme_input}' not found, skipping README conversion.")
        readme_output = os.path.join(self._root_dir, "README")
        cmd = [pandoc_cmd, "-f", "textile", "-t", "plain", str(readme_input), "-o", str(readme_output)]
        try:
            subprocess.run(cmd, check=True)
            self.success(f"{readme_input} -> {readme_output}")
        except subprocess.CalledProcessError as e:
            self.error(f"Cannot run pandoc: {e}")

    def generate_version(self):
        """
        Generate the content of the VERSION file.
        """
        version = self.current_version
        version_file = os.path.join(self._root_dir, 'VERSION')
        with open(version_file, 'w') as version_f:
            version_f.write(f"tex-templates-{version}\n")
        self.success(f"Version {version} written in {version_file}")

    def update_versions_in_tex_files(self):
        """
        Update the versions of the STY and CLS in the packages so that it corresponds to the TeX-template version.
        """
        version = self.current_tex_version
        for dirpath, dirnames, filenames in os.walk(self._root_dir):
            for filename in filenames:
                is_sty = filename.endswith('.sty')
                is_cls = filename.endswith('.cls')
                if is_sty or is_cls:
                    full_path = os.path.join(dirpath, filename)
                    with open(full_path, 'r') as f:
                        content = f.read()
                    new_content = re.sub(r'\\gdef\s*\\insertciadbeamerthemeversion\s*\{.+?\}',
                                         '\\\\gdef\\\\insertciadbeamerthemeversion{' + re.escape(version) + '}',
                                         content, re.S + re.DOTALL)
                    new_content = re.sub(r'\\gdef\s*\\insertciadreportthemeversion\s*\{.+?\}',
                                         '\\\\gdef\\\\insertciadreportthemeversion{' + re.escape(version) + '}',
                                         content, re.S + re.DOTALL)
                    new_content = re.sub(r'\\gdef\s*\\@ingedoc@class@version\s*\{.+?\}',
                                         '\\\\gdef\\\\@ingedoc@class@version{' + re.escape(version) + '}',
                                         new_content, re.S + re.DOTALL)
                    if is_sty:
                        new_content = re.sub(r'\\ProvidesPackage\s*\{(.+?)\}\s*\[.*?\]',
                                             '\\\\ProvidesPackage{\\1}[' + re.escape(version) +']',
                                             new_content, re.S + re.DOTALL)
                    elif is_cls:
                        new_content = re.sub(r'\\ProvidesClass\s*\{(.+?)\}\s*\[.*?\]',
                                             '\\\\ProvidesPackage{\\1}[' + re.escape(version) + ']',
                                             new_content, re.S + re.DOTALL)
                    if new_content is not None and content != new_content:
                        with open(full_path, 'w') as f:
                            f.write(new_content)
                        self.success(f"Version {version} written in {full_path}")

    def update_versions_in_ctan_files(self):
        """
        Update the versions of the CTAN files so that it corresponds to the TeX-template version.
        """
        version = self.current_version
        for dirpath, dirnames, filenames in os.walk(self._root_dir):
            for filename in filenames:
                if filename == 'VERSION_CTAN':
                    full_path = os.path.join(dirpath, filename)
                    with open(full_path, 'r') as f:
                        content = f.read()
                    new_content = re.sub(r'[0-9]{8}', version, content, re.S + re.DOTALL)
                    if new_content is not None and content != new_content:
                        with open(full_path, 'w') as f:
                            f.write(new_content)
                    self.success(f"Version {version} written in {full_path}")

    def generate_ciadslide_documentation(self):
        """
        Build the documentation of the CIAD slides.
        """
        src_dir = os.path.join(self._root_dir, 'presentations', 'ciad-2025')
        self._generate_documentation(src_dir, 'ciadbeamer-documentation.tex')

    def generate_ciadreport_documentation(self):
        """
        Build the documentation of the CIAD reports.
        """
        src_dir = os.path.join(self._root_dir, 'reports', 'utbmciad-2025')
        self._generate_documentation(src_dir, 'utbmciadreport-doc.tex')

    def generate_spimutbm_phd_documentation(self):
        """
        Build the documentation of the SPIM/UTBM PhD dissertations.
        """
        bst_dir = os.path.join(self._root_dir, 'spim', 'share', 'bst')
        sty_dir = os.path.join(self._root_dir, 'spim', 'share', 'sty')
        src_dir = os.path.join(self._root_dir, 'spim', 'utbm', 'spimutbmphdthesis')
        self._generate_documentation(src_dir, 'spimutbmphdthesis_exemple_francais.tex', bst_dir, sty_dir)
        self._generate_documentation(src_dir, 'spimutbmphdthesis_example_english.tex', bst_dir, sty_dir)

    def generate_spimube_phd_documentation(self):
        """
        Build the documentation of the SPIM/UBE PhD dissertations.
        """
        bst_dir = os.path.join(self._root_dir, 'spim', 'share', 'bst')
        sty_dir = os.path.join(self._root_dir, 'spim', 'share', 'sty')
        src_dir = os.path.join(self._root_dir, 'spim', 'ube', 'spimubephdthesis')
        self._generate_documentation(src_dir, 'spimubephdthesis_exemple_francais.tex', bst_dir, sty_dir)
        self._generate_documentation(src_dir, 'spimubephdthesis_example_english.tex', bst_dir, sty_dir)

    def generate_spimube_hdr_documentation(self):
        """
        Build the documentation of the SPIM/UBE HDR dissertations.
        """
        bst_dir = os.path.join(self._root_dir, 'spim', 'share', 'bst')
        sty_dir = os.path.join(self._root_dir, 'spim', 'share', 'sty')
        src_dir = os.path.join(self._root_dir, 'spim', 'ube', 'spimubehdr')
        self._generate_documentation(src_dir, 'spimubehdr_exemple_francais.tex', bst_dir, sty_dir)
        self._generate_documentation(src_dir, 'spimubehdr_example_english.tex', bst_dir, sty_dir)

    def generate_spimube_hdrapplication_documentation(self):
        """
        Build the documentation of the SPIM/UBE HDR applications.
        """
        bst_dir = os.path.join(self._root_dir, 'spim', 'share', 'bst')
        sty_dir = os.path.join(self._root_dir, 'spim', 'share', 'sty')
        src_dir = os.path.join(self._root_dir, 'spim', 'ube', 'spimubehdrapplication')
        self._generate_documentation(src_dir, 'hdrapplication-exemple.tex', bst_dir, sty_dir)

    def generate_spimumlp_phd_documentation(self):
        """
        Build the documentation of the SPIM/UMLP PhD dissertations.
        """
        bst_dir = os.path.join(self._root_dir, 'spim', 'share', 'bst')
        sty_dir = os.path.join(self._root_dir, 'spim', 'share', 'sty')
        src_dir = os.path.join(self._root_dir, 'spim', 'umlp', 'spimumlpphdthesis')
        self._generate_documentation(src_dir, 'spimumlpphdthesis_exemple_francais.tex', bst_dir, sty_dir)
        self._generate_documentation(src_dir, 'spimumlpphdthesis_example_english.tex', bst_dir, sty_dir)

    def generate_ingedoc_documentation(self):
        """
        Build the documentation of the IngeDoc Article template.
        """
        src_dir = os.path.join(self._root_dir, 'papers', 'ingedoc')
        self._generate_documentation(src_dir, 'IngeDocGuidelines.tex')

    def run(self):
        if not self.__disable_readme:
            self.generate_readme()
        if not self.__disable_version:
            self.generate_version()
            if not self.__disable_ctan:
                self.update_versions_in_ctan_files()
        if not self.__disable_tex_version_update:
            self.update_versions_in_tex_files()
        if not self.__disable_ciadslide:
            self.generate_ciadslide_documentation()
        if not self.__disable_ciadreport:
            self.generate_ciadreport_documentation()
        if not self.__disable_spimutbm:
            self.generate_spimutbm_phd_documentation()
        if not self.__disable_spimube:
            self.generate_spimube_phd_documentation()
            self.generate_spimube_hdr_documentation()
            self.generate_spimube_hdrapplication_documentation()
        if not self.__disable_spimumlp:
            self.generate_spimumlp_phd_documentation()
        if not self.__disable_ingedoc:
            self.generate_ingedoc_documentation()



class DebianPackageManager(SetupCommand):

    def __init__(self, root_dir : str, archive_name : str, inner_folder_name : str,
                 sign_with : str = None, compress_with : str = None,
                 dist_dir : str = DIST_DIR, build_dir :str = BUILD_DIR,
                 verbosity : int = 0):
        """
        :param root_dir: the path to the root folder of TeX-templates
        :param archive_name: the expected name of the main sdist archive.
        :param inner_folder_name: the name of the folder that will contain all the files inside the main sdist archive.
        :param sign_with: the email that must be used for signing the Debian packages.
        :param compress_with: the name of the compression method for creating the Debian source archives.
        :param dist_dir: the basename of the folder in which all the source distribution files will be copied.
        :param build_dir: the basename of the folder in which all the built files will be copied.
        :param verbosity: level of verbosity.
        """
        super().__init__(root_dir, dist_dir, build_dir, verbosity)
        self.__archive_name = archive_name
        self.__inner_folder_name = inner_folder_name
        self.__sign_with = sign_with if sign_with else DEBIAN_SIGN_EMAIL
        self.__compress_with = compress_with if compress_with else DEBIAN_COMPRESS_WITH

    def generate_debian_packages(self):
        """
        Build the Debian packages using the scripts from Stephane Galland.
        """
        dpkg_command = shutil.which('dpkg-buildpackage')
        if not dpkg_command:
            self.error("Command dpkg-buildpackage not found in PATH")
        basename = self._get_archive_basename(self.__archive_name)
        build_dir = os.path.join(self._root_dir, self._build_dir)
        shutil.rmtree(build_dir, ignore_errors=True)
        source_folder = os.path.join(self._root_dir, 'packaging', 'debian')
        target_root_folder = os.path.join(build_dir, basename)
        target_folder = os.path.join(target_root_folder, 'debian')
        shutil.copytree(source_folder, target_folder, dirs_exist_ok=True)
        source_archive_path = self._compute_sdist_archive_name(self.__archive_name)
        target_source_archive_path = os.path.join(target_root_folder, 'upstream')
        os.makedirs(target_source_archive_path, exist_ok=True)
        shutil.copy(source_archive_path, target_source_archive_path)
        old_dir = os.getcwd()
        try:
            os.chdir(target_root_folder)
            cmd = ['dpkg-buildpackage', '-rfakeroot', '-k' + self.__sign_with, '-tc',
                   '-Z' + self.__compress_with]
            try:
                subprocess.run(cmd, check=True)
            except subprocess.CalledProcessError as e:
                self.error(f"Cannot run deb packaging command: {e}")
        finally:
            os.chdir(old_dir)

    def run(self):
        # Build the source archives
        sdist_cmd = SourceDistributionManager(root_dir=self._root_dir,
                                              dist_dir=self._dist_dir,
                                              archive_name=self.__archive_name,
                                              inner_folder_name=self.__inner_folder_name,
                                              ctan=False)
        sdist_cmd.run()
        # Build the Debian packages
        self.generate_debian_packages()



def main():
    current_root_dir = os.path.normpath(os.path.dirname(str(__file__)))
    parser = argparse.ArgumentParser(description="Configure tex-templates project.")
    parser.add_argument("command", choices=["build", "clean", "sdist", "deb"],
                        help="Command to run: 'build' (preparing source code), 'sdist' (create archive), 'clean' (remove files) or 'deb' for building the Debian packages")
    parser.add_argument('-v', action='count', default=0, help='Increase verbosity level')
    parser.add_argument("--noversion", action="store_true", help="Do not generate the VERSION file. Keep it as-is.")
    parser.add_argument("--notexversion", action="store_true", help="Do not update the versions in the TeX files.")
    parser.add_argument("--nociadslide", action="store_true", help="Do not generate the documentation for CIAD slides.")
    parser.add_argument("--nociadreport", action="store_true", help="Do not generate the documentation for CIAD reports.")
    parser.add_argument("--nospimutbm", action="store_true", help="Do not generate the documentation for SPIM UTBM PhD dissertation.")
    parser.add_argument("--nospimube", action="store_true", help="Do not generate the documentation for SPIM UBE PhD dissertation.")
    parser.add_argument("--nospimumlp", action="store_true", help="Do not generate the documentation for SPIM UMLP PhD dissertation.")
    parser.add_argument("--noingedoc", action="store_true", help="Do not generate the documentation for Ingedoc papers.")
    parser.add_argument("--noctan", action="store_true", help="Do not generate the source distribution archives for CTAN.")
    parser.add_argument("--debug", action="store_true", help="Do not remove temp files or temp folders.")
    parser.add_argument("--debsign", action="store", metavar='email', help=f"Specify the email with which the Debian packages must be signed. Default is {DEBIAN_SIGN_EMAIL}")
    parser.add_argument("--debcompress", action="store", metavar='method', help=f"Specify the compression method for the Debian source archives. Default is {DEBIAN_COMPRESS_WITH}")
    args = parser.parse_args()

    if args.command == "build":
        cmd = BuildManager(root_dir=current_root_dir,
                           disable_version=args.noversion,
                           disable_tex_version_update=args.notexversion,
                           disable_ciadslide=args.nociadslide,
                           disable_ciadreport=args.nociadreport,
                           disable_spimutbm=args.nospimutbm,
                           disable_spimube=args.nospimube,
                           disable_spimumlp=args.nospimumlp,
                           disable_ingedoc=args.noingedoc,
                           disable_ctan=args.noctan,
                           debug=args.debug,
                           verbosity=args.v)
    elif args.command == "sdist":
        cmd = SourceDistributionManager(root_dir=current_root_dir,
                                        archive_name='tex-templates',
                                        inner_folder_name='tex-templates',
                                        ctan=not args.noctan,
                                        verbosity=args.v)
    elif args.command == "clean":
        cmd = CleanManager(root_dir=current_root_dir,
                           verbosity=args.v)
    elif args.command == "deb":
        cmd = DebianPackageManager(root_dir=current_root_dir,
                                   archive_name='tex-templates',
                                   inner_folder_name='tex-templates',
                                   sign_with=args.debsign,
                                   compress_with=args.debcompress,
                                   verbosity=args.v)
    else:
        sys.exit(255)

    if cmd is not None:
        cmd.run()

if __name__ == "__main__":
    main()
