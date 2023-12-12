#!/usr/bin/python3
# -*-encoding: utf-8-*-
"""
The script invokes multiple unit tests for */assets/xsl/dme-app.xsl using XSpec (https://github.com/xspec/xspec)

file: */unit_tests/run_unit_tests.py
"""
import os
from sys import platform
import glob
import shutil
from lxml import etree
import argparse
from pathlib import WindowsPath


class XslUnitTests:
    def __init__(self):
        parser = argparse.ArgumentParser()
        parser.add_argument("xspec_path",
                            help="Absolute or relative path to the .xspec files.")
        args = parser.parse_args()
        # Get XSpec test files
        self.xspec_tests_base = args.xspec_path

        self.isWindows = False
        if platform == "win32":
            self.isWindows = True

        if self.isWindows:
            self.xspec_tests_base = WindowsPath(args.xspec_path)
        else:
            self.xspec_tests_base = args.xspec_path
        # self.xspec_tests_base = os.path.join('.', 'xsl')
        self.xspec_files = glob.glob(os.path.join(self.xspec_tests_base, '*.xspec'),
                                     recursive=True)

        # self.xspec_files = glob.glob(os.path.join('.', 'xsl', '*.xspec'),
        #                              recursive=False)
        self.results_path = os.path.join('.', 'results')

        # XSpec executable
        self.xspec_src_base = os.path.join(".", "@latest", "bin")
         # Saxon executable
        self.saxon_path = os.path.join(".", "saxon", "saxon-he-11.6.jar")

        if self.isWindows:
            xspec_extension = "bat"
        else:
            xspec_extension = "sh"

        self.xspec_executable_filename = "xspec." + xspec_extension
        self.xspec_executable_path = os.path.join(self.xspec_src_base, self.xspec_executable_filename)
        # set environment variable for Saxon
        os.environ['SAXON_CP'] = self.saxon_path
        self.clean_up_results_dir()
        self.ns = {'mei': 'http://www.music-encoding.org/ns/mei', 'xml': 'http://www.w3.org/XML/1998/namespace'}

    def clean_up_results_dir(self):
        # self.results_path = os.path.dirname(os.path.realpath(self.xspec_files[0]))
        shutil.rmtree(self.results_path, ignore_errors=True)
        os.mkdir(self.results_path)
        result_files = self.list_result_files()
        for result_file in result_files:
            os.remove(result_file)

    def list_result_files(self):
        folder_path = os.path.join(self.xspec_tests_base, 'xspec')
        files = glob.glob(os.path.join(folder_path, '*.xsl'))
        files.extend(glob.glob(os.path.join(folder_path, '*.html')))
        files.extend(glob.glob(os.path.join(folder_path, '*.xml')))
        return files

    def move_result_files(self, file_path, filename):
        source = file_path
        new_folder = os.path.join(self.results_path, filename.split('.')[0])
        if not os.path.exists(new_folder):
            os.mkdir(new_folder)
        destination = new_folder

        try:
            shutil.move(source, destination)
        # If source and destination are same
        except shutil.SameFileError:
            print("Source and destination represents the same file.")
        # If there is any permission issue
        except PermissionError:
            print("Permission denied.")
        # For other errors
        except:
            print("Error occurred while moving results file.")

    def summary(self):
        # XSpec outputs result also in form of xml
        xml_results = glob.glob(os.path.join(self.results_path, '**', '*.xml'),
                                recursive=True)
        failed = []
        # create xml parser
        parser = etree.XMLParser(recover=True)
        for xml_result in xml_results:
            tree = etree.parse(xml_result, parser)
            success_vals = tree.xpath('//@successful')
            all_success = all(elem == 'true' for elem in success_vals)
            if not all_success:
                real_path = os.path.realpath(xml_result)
                dir_path = os.path.dirname(real_path)
                dir_basename = os.path.basename(dir_path)
                failed.append(dir_basename)
        if not failed and xml_results:
            print("All tests passed!")
        else:
            print(f"Following tests failed: {failed}")


if __name__ == '__main__':
    xut = XslUnitTests()
    counter = 1
    for xspec_test_file in xut.xspec_files:
        print(f"{'_' * 50}")
        print(f"Test {counter}")
        print(f"{'_' * 50}")
        counter += 1
        filename = os.path.basename(xspec_test_file)

        # Run Xspec from the command line
        cmd = xut.xspec_executable_path + " -t " + xspec_test_file
        os.system(cmd)

        # Xspec ouputs at least three files (.html, .xml. .xspec) to the XSPEC_HOME folder which is ./xspec. When running multiple .xspec files the folder becomes overloaded. The following code performs sorting of the output files during the runtime.

        result_files = xut.list_result_files()
        for result_file in result_files:
            xut.move_result_files(result_file, filename)

    # Remove the default XSpec output folder
    shutil.rmtree(os.path.join(xut.xspec_tests_base, 'xspec'), ignore_errors=True)

    print(f"{'_' * 50}")
    print(f"Result files are moved to {os.path.realpath(xut.results_path)}.")
    print(f"{'_' * 50}")
    xut.summary()
