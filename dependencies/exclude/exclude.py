# exclude extension
#
# Copyright 2011 aragost Trifork
#
# This software may be used and distributed according to the terms of
# the GNU General Public License version 2 or any later version.

"""extension to exclude files by default

The exclude filters is set in the ``.hgexclude`` file. Furthermore it
is possible to specify further files to get exclude filters with the
``ui.exclude`` configuration option. This option supports the hook
syntax, thereby it is possible to specify multiple files with exclude
filter using something like::

  [ui]
  exclude.common = common-excludes
  exclude.other  = other-excludes

The format for the exclude file is the same as that for the
``.hgignore`` file.
"""

from mercurial import ignore, commands, extensions, util
from mercurial.i18n import _

def exclude(orig, ui, repo, *pats, **opts):
    """Use exclude patterns from file.

    Adds patterns from .hgexclude file to exclude option, except if
    no-exclude option is specified.
    
    Then call the original function.
    """
    if opts.get('no_exclude'):
        return orig(ui, repo, *pats, **opts)

    excludepatterns = opts.get('exclude')
    files = [repo.wjoin('.hgexclude')]
    
    for name, path in ui.configitems("ui"):
        if name == 'exclude' or name.startswith('exclude.'):
            files.append(util.expandpath(path))

    for filename in files:
        try:
            filepointer = open(filename)
            filepatterns, warnings = ignore.ignorepats(filepointer.readlines())
            excludepatterns.extend(filepatterns)

            for warning in warnings:
                ui.warn("%s\n" %  warning)

        except IOError:
            if filename != files[0]: # do not warn if its .hgexclude that can't
                                 # be opened, e.g. because it doesn't exist 
                ui.warn(_("could not open exclude file: %s\n") % filename)

    return orig(ui, repo, *pats, **opts)

def uisetup(_ui):
    """
    Wraps all commands using having the exclude option,
    and adds an option to not use .hgexclude
    """
    noexcludeopt = [('', 'no-exclude', None, _("do not take exclude files into "
                                               "into account"))]

    cmdtables = [commands.table]
    for _name, module in extensions.extensions():
        table = getattr(module, 'cmdtable', {})
        cmdtables.append(table)

    for table in cmdtables:
        for commandname in table:
            command = table[commandname]
            commandname = commandname.split('|')[0].strip('^')

            if commands.walkopts[1] in command[1]:
                entry = extensions.wrapcommand(table, commandname, exclude)
                entry[1].extend(noexcludeopt)
