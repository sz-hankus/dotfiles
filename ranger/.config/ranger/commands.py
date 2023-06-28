# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()


class change_name(Command):
    """:change_name

    Opens the console with the rename command and the filename of the currently
    selected file trimmed to the last period character. 
    """

    def execute(self):
        if self.arg(1):
            self.fm.notify('This command does not take any arguments. See help for more info.', bad=True)
            return

        target_filename = self.fm.thisfile
        ext = target_filename.extension

        trimmed = f'.{ext}' if ext != None else ''
        self.fm.open_console(f'rename {trimmed}', position=7)
        return

    def tab(self, tabnum):
        return self._tab_directory_content()


class zip(Command):
    """:zip [target]

    Zips all currently selected items into `target.zip` using the `zip` program.
    If no target filename is provided, it uses the first selected item as the name.
    """

    def execute(self):
        selection = self.fm.thistab.get_selection()
        paths = [ os.path.relpath(fs_obj.realpath) for fs_obj in selection ]
        if not self.arg(1):
            name = f'{selection[0].basename}.zip'
        else:
            name = f'{self.arg(1)}.zip'

        self.fm.run(['zip', '-r', name] + paths, flags='p')  # pipes output to pager
        return

    def tab(self, tabnum):
        return self._tab_directory_content()


class ext_select(Command):
    """:ext_select <extension>

    Selects all files with the provided extension in the current working directory.
    """

    def execute(self):
        if not self.arg(1):
            self.fm.notify(f'Extension not provided.', bad=True)
        ext = self.arg(1)
        tab = self.fm.thistab
        files = tab.thisdir.files
        for file in files:
            if file.extension == ext:
                tab.thisdir.mark_item(file, True)

        self.fm.ui.browser.main_column.request_redraw()
        return

    def tab_directory_extensions(self):
        extensions = [ file.extension for file in self.fm.thistab.thisdir.files if file.extension ]
        return (self.start(1) + ext for ext in extensions)

    def tab(self, tabnum):
        return self.tab_directory_extensions()

