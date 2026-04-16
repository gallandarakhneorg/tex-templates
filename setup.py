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
"""

import os
import sys
import re
import tarfile
import shutil
import subprocess
import argparse
from datetime import datetime
from tempfile import TemporaryDirectory

from pip._internal.utils import temp_dir

# ------------------------------------------------------------
# Configuration for sdist
# ------------------------------------------------------------
SOURCE_DIRS = ["presentations", "reports", "spim", "papers"]
INFO_FILES = ['AUTHORS', 'Changelog', 'COPYING', 'README', 'VERSION']
DIST_DIR = "dist"

def add_directory_to_tar(tar: tarfile.TarFile, root_dir: str, archive_parent: str):
    """
    Recursively add files from root_dir into tar under archive_parent/.
    """
    if not os.path.isdir(root_dir):
        print(f"Error: Directory '{root_dir}' not found.")
        sys.exit(255)

    for dirpath, dirnames, filenames in os.walk(root_dir):
        for filename in filenames:
            full_path = os.path.join(dirpath, filename)
            rel_path = os.path.relpath(full_path, start=root_dir)
            arcname = os.path.join(archive_parent, rel_path)
            tar.add(full_path, arcname=arcname, recursive=False)

def get_archive_basename(root_dir : str, basename : str) -> str:
    """
    Compute the basename of the archive file.
    """
    version_file = os.path.join(root_dir, 'VERSION')
    with open(version_file, 'r') as version_f:
        version_number = str(version_f.read()).strip()
    m = re.search(r'-([^-]+)$', version_number)
    if m:
        version_number = m.group(1)
    return f"{basename}-{version_number}"

def get_archive_name(root_dir : str, basename : str) -> str:
    """
    Compute the name of the archive file.
    """
    return get_archive_basename(root_dir, basename) + ".tar.gz"

def compute_sdist_archive_name(root_dir : str, archive_name : str) -> str:
    dist_dir = os.path.join(root_dir, DIST_DIR)
    os.makedirs(dist_dir, exist_ok=True)
    archive_name = get_archive_name(root_dir, archive_name)
    archive_path = os.path.join(dist_dir, archive_name)
    return archive_path

def cmd_sdist(root_dir : str, archive_name : str, folder_name : str):
    """
    Create a source distribution tar.gz archive.
    """
    archive_path = compute_sdist_archive_name(root_dir, archive_name)

    if os.path.isfile(archive_path):
        os.unlink(archive_path)

    print(f"Creating source distribution: {archive_path}")
    with tarfile.open(archive_path, "w:gz") as tar:
        for src_dir in SOURCE_DIRS:
            add_directory_to_tar(tar, src_dir, os.path.join(folder_name, src_dir))
        for info_file in INFO_FILES:
            full_info_file = os.path.join(root_dir, info_file)
            arcname = os.path.join(folder_name, info_file)
            tar.add(full_info_file, arcname=arcname, recursive=False)
    print("Done.")

def cmd_build_version(root_dir : str):
    """
    Generate the content of the VERSION file.
    """
    version = datetime.now().strftime("%Y%m%d")
    version_file = os.path.join(root_dir, 'VERSION')
    with open(version_file, 'w') as version_f:
        version_f.write(f"tex-templates-{version}\n")
    print(f"Version {version} written in {version_file}")

def cmd_build_readme(root_dir : str):
    """
    Build the README file.
    """
    readme_input = os.path.join(root_dir, "README.textile")
    readme_output = os.path.join(root_dir, "README")

    if not os.path.isfile(readme_input):
        print(f"Error: '{readme_input}' not found, skipping README conversion.")
        sys.exit(255)

    cmd = ["pandoc", "-f", "textile", "-t", "plain", str(readme_input), "-o", str(readme_output)]
    try:
        subprocess.run(cmd, check=True)
        print(f"Converted '{readme_input}' -> '{readme_output}'")
    except subprocess.CalledProcessError as e:
        print(f"Error running pandoc: {e}")
        sys.exit(255)

def prepare_documentation_dir(root_dir : str, src_dir : str, documentation_file : str, *additional_src_dirs : str) -> TemporaryDirectory:
    """
    Prepare the tmp/ folder for the generation of documentation.
    """
    # Check prerequisites
    if not os.path.isdir(src_dir):
        print(f"Error: '{src_dir}' directory not found.")
        sys.exit(255)
    for additional_src_dir in additional_src_dirs:
        if not os.path.isdir(additional_src_dir):
            print(f"Error: '{additional_src_dir}' directory not found.")
            sys.exit(255)
    tmp_dir = TemporaryDirectory(delete=False)
    for input_dir in [src_dir] + [*additional_src_dirs]:
        print(f"Creating symbolic links from {input_dir} into {tmp_dir.name}...")
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
                # Create the symlink (relative or absolute? Use absolute to be safe)
                try:
                    # Use absolute path for source to make symlink robust
                    os.symlink(src_file, link_path)
                    print(f"  {link_path} -> {src_file}")
                except Exception as e:
                    print(f"  Warning: Could not create symlink {link_path}: {e}")
                    tmp_dir.cleanup()
                    sys.exit(255)
    # Remove the document file from the tmp folder
    documentation_pdf_file = os.path.join(tmp_dir.name, documentation_file)
    if os.path.exists(documentation_pdf_file):
        os.unlink(documentation_pdf_file)
        print(f"File {documentation_pdf_file} removed")
    return tmp_dir

def run_pdflatex(temp_dir : TemporaryDirectory, tex_file : str):
    """
    Run the pdflatex command on the given document.
    """
    print(f"Compiling {tex_file} with pdflatex...")
    # Save current working directory
    original_cwd = os.getcwd()
    try:
        os.chdir(temp_dir.name)
        # Run pdflatex with nonstop mode to avoid hanging on errors
        cmd = ["pdflatex", "-interaction=nonstopmode", tex_file]
        result = subprocess.run(cmd, capture_output=True, text=True, errors="replace")
        if result.returncode != 0:
            print("LaTeX compilation failed. Here is the log:")
            # Print last 50 lines of stdout/stderr for debugging
            print(result.stdout[-2000:] if result.stdout else "")
            print(result.stderr[-2000:] if result.stderr else "")
            temp_dir.cleanup()
            sys.exit(255)
        else:
            print("LaTeX compilation succeeded.")
            # Run a second time to resolve cross-references (not required but common)
            print("Running pdflatex again to resolve references...")
            result2 = subprocess.run(cmd, capture_output=True, text=True, errors="replace")
            if result2.returncode != 0:
                print("Error: Second compilation had issues.")
                # Print last 50 lines of stdout/stderr for debugging
                print(result.stdout[-2000:] if result.stdout else "")
                print(result.stderr[-2000:] if result.stderr else "")
                temp_dir.cleanup()
                sys.exit(255)
            else:
                print("Documentation generated successfully.")
    finally:
        os.chdir(original_cwd)

def generate_documentation(root_dir : str, src_dir : str, tex_filename : str, *additional_src_dirs : str):
    """
    Build the documentation.
    """
    pdf_filename = os.path.splitext(tex_filename)[0] + '.pdf'
    tmp_dir = prepare_documentation_dir(root_dir, src_dir, pdf_filename, *additional_src_dirs)
    try:
        run_pdflatex(tmp_dir, tex_filename)
        shutil.copyfile(os.path.join(tmp_dir.name, pdf_filename),
                        os.path.join(src_dir, pdf_filename))
        print(f"Copied {pdf_filename} into {src_dir}.")
    finally:
        tmp_dir.cleanup()

def cmd_build_ciad_slide_doc(root_dir : str):
    """
    Build the documentation of the CIAD slides.
    """
    src_dir = os.path.join(root_dir, 'presentations', 'ciad-2025')
    generate_documentation(root_dir, src_dir, 'documentation.tex')

def cmd_build_ciad_slide_doc(root_dir : str):
    """
    Build the documentation of the CIAD slides.
    """
    src_dir = os.path.join(root_dir, 'presentations', 'ciad-2025')
    generate_documentation(root_dir, src_dir, 'documentation.tex')

def cmd_build_ciad_report_doc(root_dir : str):
    """
    Build the documentation of the CIAD reports.
    """
    src_dir = os.path.join(root_dir, 'reports', 'utbmciad-2025')
    generate_documentation(root_dir, src_dir, 'upmethodology-utbmciad-doc.tex')

def cmd_build_spim_utbm_doc(root_dir : str):
    """
    Build the documentation of the SPIM UTBM PhD dissertations and HDR.
    """
    bst_dir = os.path.join(root_dir, 'spim', 'share', 'bst')
    sty_dir = os.path.join(root_dir, 'spim', 'share', 'sty')
    src_dir = os.path.join(root_dir, 'spim', 'utbm', 'spimutbmphdthesis')
    generate_documentation(root_dir, src_dir, 'exemple_francais.tex', bst_dir, sty_dir)
    generate_documentation(root_dir, src_dir, 'example_english.tex', bst_dir, sty_dir)

def cmd_build_spim_ube_doc(root_dir : str):
    """
    Build the documentation of the SPIM UBE PhD dissertations.
    """
    # PhD Dissertation
    bst_dir = os.path.join(root_dir, 'spim', 'share', 'bst')
    sty_dir = os.path.join(root_dir, 'spim', 'share', 'sty')
    src_dir = os.path.join(root_dir, 'spim', 'ube', 'spimubephdthesis')
    generate_documentation(root_dir, src_dir, 'exemple_francais.tex', bst_dir, sty_dir)
    generate_documentation(root_dir, src_dir, 'example_english.tex', bst_dir, sty_dir)
    # HDR application
    src_dir = os.path.join(root_dir, 'spim', 'ube', 'spimubehdrapplication')
    generate_documentation(root_dir, src_dir, 'exemple.tex', bst_dir, sty_dir)
    # HDR
    src_dir = os.path.join(root_dir, 'spim', 'ube', 'spimubehdr')
    generate_documentation(root_dir, src_dir, 'exemple_francais.tex', bst_dir, sty_dir)
    generate_documentation(root_dir, src_dir, 'example_english.tex', bst_dir, sty_dir)

def cmd_build_spim_umlp_doc(root_dir : str):
    """
    Build the documentation of the SPIM UMLP PhD dissertations.
    """
    bst_dir = os.path.join(root_dir, 'spim', 'share', 'bst')
    sty_dir = os.path.join(root_dir, 'spim', 'share', 'sty')
    src_dir = os.path.join(root_dir, 'spim', 'umlp', 'spimumlpphdthesis')
    generate_documentation(root_dir, src_dir, 'exemple_francais.tex', bst_dir, sty_dir)
    generate_documentation(root_dir, src_dir, 'example_english.tex', bst_dir, sty_dir)

def cmd_build_ingedoc_doc(root_dir : str):
    """
    Build the documentation of the Ingedoc papers.
    """
    src_dir = os.path.join(root_dir, 'papers', 'ingedoc')
    generate_documentation(root_dir, src_dir, 'IngeDocGuidelines.tex')

def cmd_build(args, root_dir : str):
    """
    Build the source code.
    """
    if not args.noversion:
        cmd_build_version(root_dir)
    cmd_build_readme(root_dir)
    if not args.nociadslide:
        cmd_build_ciad_slide_doc(root_dir)
    if not args.nociadreport:
        cmd_build_ciad_report_doc(root_dir)
    if not args.nospimutbm:
        cmd_build_spim_utbm_doc(root_dir)
    if not args.nospimube:
        cmd_build_spim_ube_doc(root_dir)
    if not args.nospimumlp:
        cmd_build_spim_umlp_doc(root_dir)
    if not args.noingedoc:
        cmd_build_ingedoc_doc(root_dir)

def cmd_clean(root_dir : str):
    """
    Clean temporary files, generated files.
    """
    removed_count = 0
    for cleanable in ['dist', 'build']:
        dist_dir = os.path.join(root_dir, cleanable)
        if os.path.isdir(dist_dir):
            shutil.rmtree(dist_dir)
            print(f"Removed: {dist_dir}")
            removed_count += 1
    print(f"Cleaning complete. Removed {removed_count} item(s).")

def cmd_build_deb(root_dir : str, archive_name : str):
    """
    Build the Debian packages using the scripts from Stephane Galland
    """
    basename = get_archive_basename(root_dir, archive_name)
    build_dir = os.path.join(root_dir, 'build')
    shutil.rmtree(build_dir, ignore_errors=True)
    source_folder = os.path.join(root_dir, 'packaging', 'debian')
    target_root_folder = os.path.join(build_dir, basename)
    target_folder = os.path.join(target_root_folder, 'debian')
    shutil.copytree(source_folder, target_folder, dirs_exist_ok=True)
    source_archive_path = compute_sdist_archive_name(root_dir, archive_name)
    target_source_archive_path = os.path.join(target_root_folder, 'upstream')
    os.makedirs(target_source_archive_path, exist_ok=True)
    shutil.copy(source_archive_path, target_source_archive_path)
    old_dir = os.getcwd()
    try:
        os.chdir(target_root_folder)
        cmd = ["dpkg-buildpackages_i386_ia64_amd64", "any"]
        try:
            subprocess.run(cmd, check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error running deb packaging command: {e}")
            sys.exit(255)
    finally:
        os.chdir(old_dir)

def main():
    current_root_dir = os.path.normpath(os.path.dirname(str(__file__)))
    parser = argparse.ArgumentParser(description="Configure tex-templates project.")
    parser.add_argument("command", choices=["build", "clean", "sdist", "deb"],
                        help="Command to run: 'build' (preparing source code), 'sdist' (create archive), 'clean' (remove files) or 'deb' for building the Debian packages")
    parser.add_argument("--noversion", action="store_true", help="Do not generate the VERSION file. Keep it as-is.")
    parser.add_argument("--nociadslide", action="store_true", help="Do not generate the documentation for CIAD slides.")
    parser.add_argument("--nociadreport", action="store_true", help="Do not generate the documentation for CIAD reports.")
    parser.add_argument("--nospimutbm", action="store_true", help="Do not generate the documentation for SPIM UTBM PhD dissertation.")
    parser.add_argument("--nospimube", action="store_true", help="Do not generate the documentation for SPIM UBE PhD dissertation.")
    parser.add_argument("--nospimumlp", action="store_true", help="Do not generate the documentation for SPIM UMLP PhD dissertation.")
    parser.add_argument("--noingedoc", action="store_true", help="Do not generate the documentation for Ingedoc papers.")
    args = parser.parse_args()

    if args.command == "build":
        cmd_build(args, current_root_dir)
    elif args.command == "sdist":
        cmd_clean(current_root_dir)
        cmd_sdist(current_root_dir, 'tex-templates', 'arakhne-tex-templates')
    elif args.command == "clean":
        cmd_clean(current_root_dir)
    elif args.command == "deb":
        cmd_clean(current_root_dir)
        cmd_sdist(current_root_dir, 'tex-templates', 'tex-templates')
        cmd_build_deb(current_root_dir, 'tex-templates')
    else:
        print(f"Error: Unsupported command. Use 'build', 'sdist' or 'clean'.")
        sys.exit(255)


if __name__ == "__main__":
    main()
