from ranger.api.commands import *


class fzf_select(Command):
    def execute(self):
        import subprocess
        import os.path

        if self.quantifier:
            # match only directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
                    -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        else:
            # match files and directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
                    -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode("utf-8").rstrip("\n"))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


import ranger.api
import ranger.core.linemode
import subprocess

from ranger.container.file import File
@ranger.api.register_linemode
class MyLinemode(ranger.core.linemode.LinemodeBase):
    name = "img"

    def filetitle(self, file, metadata):
        return file.relative_path

    def infostring(self, file, metadata):
        if type(file)==File and file.extension in ["jpg","png","bmp"]:
            try:
                output = subprocess.check_output(['identify', '-format', '%hx%w', file.path])
                return output.decode("utf-8")
            except:
                pass
class copypath(Command):
    def execute(self):
        mode=self.parse_flags()
        mode=mode[0] if len(mode)>0 else "p"
        n = self.fm.thistab.get_selection()
        if mode=="p":
            n = [n.path for n in n]
        elif mode=="n":
            n = [n.relative_path for n in n]
        n = "\n".join(n).encode("utf-8")
        subprocess.run('yank > /dev/tty', shell=True, input=n)
