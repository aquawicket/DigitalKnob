# Copyright (c) 2014 The Chromium Embedded Framework Authors. All rights
# reserved. Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file.

from optparse import OptionParser
import os
import shlex
import shutil
import subprocess
import sys
import tempfile
import urllib
import zipfile

##
# Default URLs.
##

depot_tools_url = 'https://chromium.googlesource.com/chromium/tools/depot_tools.git'
depot_tools_archive_url = 'https://src.chromium.org/svn/trunk/tools/depot_tools.zip'

cef_git_url = 'https://bitbucket.org/chromiumembedded/cef.git'


##
# Global system variables.
##

# Script directory.
script_dir = os.path.dirname(__file__)


##
# Helper functions.
##

def msg(message):
  """ Output a message. """
  sys.stdout.write('--> ' + message + "\n")

def run(command_line, working_dir, depot_tools_dir=None, output_file=None):
  """ Runs the specified command. """
  # add depot_tools to the path
  env = os.environ
  if not depot_tools_dir is None:
    env['PATH'] = depot_tools_dir+os.pathsep+env['PATH']

  sys.stdout.write('-------- Running "'+command_line+'" in "'+\
                   working_dir+'"...'+"\n")
  if not options.dryrun:
    args = shlex.split(command_line.replace('\\', '\\\\'))

    if not output_file:
      return subprocess.check_call(args, cwd=working_dir, env=env,
                                 shell=(sys.platform == 'win32'))
    with open(output_file, "w") as f:
      return subprocess.check_call(args, cwd=working_dir, env=env,
                                 shell=(sys.platform == 'win32'),
                                 stderr=subprocess.STDOUT, stdout=f)

def create_directory(path):
  """ Creates a directory if it doesn't already exist. """
  if not os.path.exists(path):
    msg("Creating directory %s" % (path));
    if not options.dryrun:
      os.makedirs(path)

def delete_directory(path):
  """ Removes an existing directory. """
  if os.path.exists(path):
    msg("Removing directory %s" % (path));
    if not options.dryrun:
      shutil.rmtree(path, onerror=onerror)

def copy_directory(source, target, allow_overwrite=False):
  """ Copies a directory from source to target. """
  if not options.dryrun and os.path.exists(target):
    if not allow_overwrite:
      raise Exception("Directory %s already exists" % (target))
    remove_directory(target)
  if os.path.exists(source):
    msg("Copying directory %s to %s" % (source, target));
    if not options.dryrun:
      shutil.copytree(source, target)

def move_directory(source, target, allow_overwrite=False):
  """ Copies a directory from source to target. """
  if not options.dryrun and os.path.exists(target):
    if not allow_overwrite:
      raise Exception("Directory %s already exists" % (target))
    remove_directory(target)
  if os.path.exists(source):
    msg("Moving directory %s to %s" % (source, target));
    if not options.dryrun:
      shutil.move(source, target)

def is_git_checkout(path):
  """ Returns true if the path represents a git checkout. """
  return os.path.exists(os.path.join(path, '.git'))

def exec_cmd(cmd, path):
  """ Execute the specified command and return the result. """
  out = ''
  err = ''
  sys.stdout.write("-------- Running \"%s\" in \"%s\"...\n" % (cmd, path))
  parts = cmd.split()
  try:
    process = subprocess.Popen(parts, cwd=path,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE,
                               shell=(sys.platform == 'win32'))
    out, err = process.communicate()
  except IOError, (errno, strerror):
    raise
  except:
    raise
  return {'out': out, 'err': err}

def get_git_hash(path, branch):
  """ Returns the git hash for the specified branch/tag/hash. """
  cmd = "%s rev-parse %s" % (git_exe, branch)
  result = exec_cmd(cmd, path)
  if result['out'] != '':
    return result['out'].strip()
  return 'Unknown'

def get_git_url(path):
  """ Returns the origin url for the specified path. """
  cmd = "%s config --get remote.origin.url" % (git_exe)
  result = exec_cmd(cmd, path)
  if result['out'] != '':
    return result['out'].strip()
  return 'Unknown'

def download_and_extract(src, target, contents_prefix):
  """ Extracts the contents of src, which may be a URL or local file, to the
      target directory. """
  temporary = False

  if src[:4] == 'http':
    # Attempt to download a URL.
    opener = urllib.FancyURLopener({})
    response = opener.open(src)

    temporary = True
    handle, archive_path = tempfile.mkstemp(suffix = '.zip')
    os.write(handle, response.read())
    os.close(handle)
  elif os.path.exists(src):
    # Use a local file.
    archive_path = src
  else:
    raise Exception('Path type is unsupported or does not exist: ' + src)

  if not zipfile.is_zipfile(archive_path):
    raise Exception('Not a valid zip archive: ' + src)

  def remove_prefix(zip, prefix):
    offset = len(prefix)
    for zipinfo in zip.infolist():
      name = zipinfo.filename
      if len(name) > offset and name[:offset] == prefix:
        zipinfo.filename = name[offset:]
        yield zipinfo

  # Attempt to extract the archive file.
  try:
    os.makedirs(target)
    zf = zipfile.ZipFile(archive_path, 'r')
    zf.extractall(target, remove_prefix(zf, contents_prefix))
  except:
    shutil.rmtree(target, onerror=onerror)
    raise
  zf.close()

  # Delete the archive file if temporary.
  if temporary and os.path.exists(archive_path):
    os.remove(archive_path)

def read_config_file(path):
  """ Read a configuration file. """
  if os.path.exists(path):
    fp = open(path, 'r')
    data = fp.read()
    fp.close()
  else:
    raise Exception("Path does not exist: %s" % (path))

  # Parse the contents.
  return eval(data, {'__builtins__': None}, None)

def write_config_file(path, contents):
  """ Write a configuration file. """
  msg('Writing file: %s' % path)
  if not options.dryrun:
    fp = open(path, 'w')
    fp.write("{\n")
    for key in sorted(contents.keys()):
      fp.write("  '%s': '%s',\n" % (key, contents[key]))
    fp.write("}\n")
    fp.close()

def read_branch_config_file(path):
  """ Read the CEF branch from the specified path. """
  config_file = os.path.join(path, 'cef.branch')
  if os.path.isfile(config_file):
    contents = read_config_file(config_file)
    if 'branch' in contents:
      return contents['branch']
  return ''

def write_branch_config_file(path, branch):
  """ Write the CEF branch to the specified path. """
  config_file = os.path.join(path, 'cef.branch')
  if not os.path.isfile(config_file):
    write_config_file(config_file, {'branch': branch})

def remove_deps_entry(path, entry):
  """ Remove an entry from the Chromium DEPS file at the specified path. """
  msg('Updating DEPS file: %s' % path)
  if not options.dryrun:
    # Read the DEPS file.
    fp = open(path, 'r')
    lines = fp.readlines()
    fp.close()

    # Write the DEPS file.
    # Each entry takes 2 lines. Skip both lines if found.
    fp = open(path, 'w')
    skip_next = False
    for line in lines:
      if skip_next:
        skip_next = False
        continue
      elif line.find(entry) >= 0:
        skip_next = True
        continue
      fp.write(line)
    fp.close()

def apply_deps_patch():
  """ Patch the Chromium DEPS file if necessary. """
  # Starting with 43.0.2357.126 the DEPS file is now 100% Git and the .DEPS.git
  # file is no longer created. Look for the older file first in case we're
  # building an older branch version.
  deps_file = '.DEPS.git'
  deps_path = os.path.join(chromium_src_dir, deps_file)
  if not os.path.isfile(deps_path):
    deps_file = 'DEPS'
    deps_path = os.path.join(chromium_src_dir, deps_file)

  if os.path.isfile(deps_path):
    msg("Chromium DEPS file: %s" % (deps_path))
    patch_file = os.path.join(cef_dir, 'patch', 'patches', deps_file + '.patch')
    if os.path.exists(patch_file):
      # Attempt to apply the DEPS patch file that may exist with newer branches.
      patch_tool = os.path.join(cef_dir, 'tools', 'patcher.py')
      run('%s %s --patch-file "%s" --patch-dir "%s"' %
              (python_exe, patch_tool, patch_file, chromium_src_dir),
          chromium_src_dir, depot_tools_dir)
    elif cef_branch != 'trunk' and int(cef_branch) <= 1916:
      # Release branch DEPS files older than 37.0.2007.0 may include a 'src'
      # entry. This entry needs to be removed otherwise `gclient sync` will
      # fail.
      remove_deps_entry(deps_path, "'src'")
  else:
    raise Exception("Path does not exist: %s" % (deps_path))

def onerror(func, path, exc_info):
  """
  Error handler for ``shutil.rmtree``.

  If the error is due to an access error (read only file)
  it attempts to add write permission and then retries.

  If the error is for another reason it re-raises the error.

  Usage : ``shutil.rmtree(path, onerror=onerror)``
  """
  import stat
  if not os.access(path, os.W_OK):
    # Is the error an access error ?
    os.chmod(path, stat.S_IWUSR)
    func(path)
  else:
    raise


##
# Program entry point.
##

# Cannot be loaded as a module.
if __name__ != "__main__":
  sys.stderr.write('This file cannot be loaded as a module!')
  sys.exit()

# Parse command-line options.
disc = """
This utility implements automation for the download, update, build and
distribution of CEF.
"""

parser = OptionParser(description=disc)

# Setup options.
parser.add_option('--download-dir', dest='downloaddir', metavar='DIR',
                  help='Download directory with no spaces [required].')
parser.add_option('--depot-tools-dir', dest='depottoolsdir', metavar='DIR',
                  help='Download directory for depot_tools.', default='')
parser.add_option('--depot-tools-archive', dest='depottoolsarchive',
                  help='Zip archive file that contains a single top-level '+\
                       'depot_tools directory.', default='')
parser.add_option('--branch', dest='branch',
                  help='Branch of CEF to build (trunk, 1916, ...). This '+\
                       'will be used to name the CEF download directory and '+\
                       'to identify the correct URL if --url is not '+\
                       'specified. The default value is trunk.',
                  default='trunk')
parser.add_option('--url', dest='url',
                  help='CEF download URL. If not specified the default URL '+\
                       'will be used.',
                  default='')
parser.add_option('--checkout', dest='checkout',
                  help='Version of CEF to checkout. If not specified the '+\
                       'most recent remote version of the branch will be used.',
                  default='')
parser.add_option('--chromium-checkout', dest='chromiumcheckout',
                  help='Version of Chromium to checkout (Git '+\
                       'branch/hash/tag). This overrides the value specified '+\
                       'by CEF in CHROMIUM_BUILD_COMPATIBILITY.txt.',
                  default='')

# Miscellaneous options.
parser.add_option('--force-config',
                  action='store_true', dest='forceconfig', default=False,
                  help='Force creation of a new gclient config file.')
parser.add_option('--force-clean',
                  action='store_true', dest='forceclean', default=False,
                  help='Force a clean checkout of Chromium and CEF. This will'+\
                       ' trigger a new update, build and distribution.')
parser.add_option('--force-clean-deps',
                  action='store_true', dest='forcecleandeps', default=False,
                  help='Force a clean checkout of Chromium dependencies. Used'+\
                       ' in combination with --force-clean.')
parser.add_option('--dry-run',
                  action='store_true', dest='dryrun', default=False,
                  help="Output commands without executing them.")
parser.add_option('--dry-run-platform', dest='dryrunplatform', default=None,
                  help='Simulate a dry run on the specified platform '+\
                       '(windows, macosx, linux). Must be used in combination'+\
                       ' with the --dry-run flag.')

# Update-related options.
parser.add_option('--force-update',
                  action='store_true', dest='forceupdate', default=False,
                  help='Force a Chromium and CEF update. This will trigger a '+\
                       'new build and distribution.')
parser.add_option('--no-update',
                  action='store_true', dest='noupdate', default=False,
                  help='Do not update Chromium or CEF. Pass --force-build or '+\
                       '--force-distrib if you desire a new build or '+\
                       'distribution.')

# Build-related options.
parser.add_option('--force-build',
                  action='store_true', dest='forcebuild', default=False,
                  help='Force CEF debug and release builds. This builds '+\
                       'cefclient on all platforms and chrome_sandbox on '+\
                       'Linux.')
parser.add_option('--no-build',
                  action='store_true', dest='nobuild', default=False,
                  help='Do not build CEF.')
parser.add_option('--build-tests',
                  action='store_true', dest='buildtests', default=False,
                  help='Also build the cef_unittests target.')
parser.add_option('--no-debug-build',
                  action='store_true', dest='nodebugbuild', default=False,
                  help="Don't perform the CEF debug build.")
parser.add_option('--no-release-build',
                  action='store_true', dest='noreleasebuild', default=False,
                  help="Don't perform the CEF release build.")
parser.add_option('--verbose-build',
                  action='store_true', dest='verbosebuild', default=False,
                  help='Show all command lines while building.')
parser.add_option('--build-log-file',
                  action='store_true', dest='buildlogfile', default=False,
                  help='Write build logs to file. The file will be named '+\
                       '"build-[branch]-[debug|release].log" in the download '+\
                       'directory.')
parser.add_option('--x64-build',
                  action='store_true', dest='x64build', default=False,
                  help='Build for 64-bit systems (Windows and Mac OS X only).')

# Distribution-related options.
parser.add_option('--force-distrib',
                  action='store_true', dest='forcedistrib', default=False,
                  help='Force creation of a CEF binary distribution.')
parser.add_option('--no-distrib',
                  action='store_true', dest='nodistrib', default=False,
                  help="Don't create a CEF binary distribution.")
parser.add_option('--minimal-distrib',
                  action='store_true', dest='minimaldistrib', default=False,
                  help='Create a minimal CEF binary distribution.')
parser.add_option('--minimal-distrib-only',
                  action='store_true', dest='minimaldistribonly', default=False,
                  help='Create a minimal CEF binary distribution only.')
parser.add_option('--client-distrib',
                  action='store_true', dest='clientdistrib', default=False,
                  help='Create a client CEF binary distribution.')
parser.add_option('--client-distrib-only',
                  action='store_true', dest='clientdistribonly', default=False,
                  help='Create a client CEF binary distribution only.')
parser.add_option('--no-distrib-docs',
                  action='store_true', dest='nodistribdocs', default=False,
                  help="Don't create CEF documentation.")
parser.add_option('--no-distrib-archive',
                  action='store_true', dest='nodistribarchive', default=False,
                  help="Don't create archives for output directories.")
parser.add_option('--clean-artifacts',
                  action='store_true', dest='cleanartifacts', default=False,
                  help='Clean the artifacts output directory.')

(options, args) = parser.parse_args()

if options.downloaddir is None:
  print "The --download-dir option is required."
  parser.print_help(sys.stderr)
  sys.exit()

if options.noupdate and options.forceupdate or \
   options.nobuild and options.forcebuild or \
   options.nodistrib and options.forcedistrib:
  print "Invalid combination of options."
  parser.print_help(sys.stderr)
  sys.exit()

if (options.noreleasebuild and \
     (options.minimaldistrib or options.minimaldistribonly or \
      options.clientdistrib or options.clientdistribonly)) or \
   (options.minimaldistribonly and options.clientdistribonly):
  print 'Invalid combination of options.'
  parser.print_help(sys.stderr)
  sys.exit()

# Operating system.
if options.dryrun and options.dryrunplatform is not None:
  platform = options.dryrunplatform
  if not platform in ['windows', 'macosx', 'linux']:
    print 'Invalid dry-run-platform value: %s' % (platform)
    sys.exit()
elif sys.platform == 'win32':
  platform = 'windows'
elif sys.platform == 'darwin':
  platform = 'macosx'
elif sys.platform.startswith('linux'):
  platform = 'linux'
else:
  print 'Unknown operating system platform'
  sys.exit()

# Script extension.
if platform == 'windows':
  script_ext = '.bat'
else:
  script_ext = '.sh'

if options.x64build and platform != 'windows' and platform != 'macosx':
  print 'The x64 build option is only used on Windows and Mac OS X.'
  sys.exit()

if platform == 'windows' and not 'GYP_MSVS_VERSION' in os.environ.keys():
  print 'You must set the GYP_MSVS_VERSION environment variable on Windows.'
  sys.exit()

# CEF branch.
if options.branch != 'trunk' and not options.branch.isdigit():
  print 'Invalid branch value: %s' % (options.branch)
cef_branch = options.branch

if cef_branch != 'trunk' and int(cef_branch) <= 1453:
  print 'The requested branch is too old to build using this tool'
  sys.exit()

# True if the requested branch is 2272 or newer.
branch_is_2272_or_newer = (cef_branch == 'trunk' or int(cef_branch) >= 2272)

# True if the requested branch is 2357 or newer.
branch_is_2357_or_newer = (cef_branch == 'trunk' or int(cef_branch) >= 2357)

# Starting with 43.0.2357.126 the DEPS file is now 100% Git and the .DEPS.git
# file is no longer created.
if branch_is_2357_or_newer:
  deps_file = 'DEPS'
else:
  deps_file = '.DEPS.git'

if platform == 'macosx' and not options.x64build and branch_is_2272_or_newer:
  print '32-bit Mac OS X builds are no longer supported with 2272 branch and '+\
        'newer. Add --x64-build flag to generate a 64-bit build.'
  sys.exit()

# True if GYP_DEFINES=target_arch=x64 must be set.
gyp_needs_target_arch_x64 = options.x64build and \
  (platform == 'windows' or \
    (platform == 'macosx' and not branch_is_2272_or_newer))

# Options that force the sources to change.
force_change = options.forceclean or options.forceupdate

if platform == 'windows':
  # Avoid errors when the "vs_toolchain.py update" Chromium hook runs.
  os.environ['DEPOT_TOOLS_WIN_TOOLCHAIN'] = '0'


##
# Manage the download directory.
##

# Create the download directory if necessary.
download_dir = os.path.abspath(options.downloaddir)
create_directory(download_dir)

msg("Download Directory: %s" % (download_dir))


##
# Manage the depot_tools directory.
##

# Check if the depot_tools directory exists.
if options.depottoolsdir != '':
  depot_tools_dir = os.path.abspath(options.depottoolsdir)
else:
  depot_tools_dir = os.path.join(download_dir, 'depot_tools')

msg("Depot Tools Directory: %s" % (depot_tools_dir))

if not os.path.exists(depot_tools_dir):
  if platform == 'windows' and options.depottoolsarchive == '':
    # On Windows download depot_tools as an archive file since we can't assume
    # that git is already installed.
    options.depottoolsarchive = depot_tools_archive_url

  if options.depottoolsarchive != '':
    # Extract depot_tools from an archive file.
    msg('Extracting %s to %s.' % \
        (options.depottoolsarchive, depot_tools_dir))
    if not options.dryrun:
      download_and_extract(options.depottoolsarchive, depot_tools_dir, \
                           'depot_tools/')
  else:
    # On Linux and OS X check out depot_tools using Git.
    run('git clone '+depot_tools_url+' '+depot_tools_dir, download_dir)

if not options.noupdate:
  # Update depot_tools.
  # On Windows this will download required python and git binaries.
  if platform == 'windows':
    run('update_depot_tools.bat', depot_tools_dir, depot_tools_dir);
  else:
    run('update_depot_tools', depot_tools_dir, depot_tools_dir);

# Determine the executables to use.
if platform == 'windows':
  # Force use of the version bundled with depot_tools.
  git_exe = os.path.join(depot_tools_dir, 'git.bat')
  python_exe = os.path.join(depot_tools_dir, 'python.bat')
  if options.dryrun and not os.path.exists(git_exe):
    sys.stdout.write("WARNING: --dry-run assumes that depot_tools" \
                     " is already in your PATH. If it isn't\nplease" \
                     " specify a --depot-tools-dir value.\n")
    git_exe = 'git.bat'
    python_exe = 'python.bat'
else:
  git_exe = 'git'
  python_exe = 'python'


##
# Manage the cef directory.
##

cef_dir = os.path.join(download_dir, 'cef')

# Delete the existing CEF directory if requested.
if options.forceclean and os.path.exists(cef_dir):
  delete_directory(cef_dir)

# Determine the type of CEF checkout to use.
if os.path.exists(cef_dir) and not is_git_checkout(cef_dir):
  raise Exception("Not a valid CEF Git checkout: %s" % (cef_dir))

# Determine the CEF download URL to use.
if options.url == '':
  cef_url = cef_git_url
else:
  cef_url = options.url

# Verify that the requested CEF URL matches the existing checkout.
if os.path.exists(cef_dir):
  cef_existing_url = get_git_url(cef_dir)
  if cef_url != cef_existing_url:
    raise Exception(
        'Requested CEF checkout URL %s does not match existing URL %s' %
        (cef_url, cef_existing_url))

msg("CEF Branch: %s" % (cef_branch))
msg("CEF URL: %s" % (cef_url))
msg("CEF Source Directory: %s" % (cef_dir))

# Determine the CEF Git branch to use.
if options.checkout == '':
  # Target the most recent branch commit from the remote repo.
  if cef_branch == 'trunk':
    cef_checkout = 'origin/master'
  else:
    cef_checkout = 'origin/' + cef_branch
else:
  cef_checkout = options.checkout

# Create the CEF checkout if necessary.
if not options.noupdate and not os.path.exists(cef_dir):
  cef_checkout_new = True
  run('%s clone %s %s' % (git_exe, cef_url, cef_dir), download_dir, \
      depot_tools_dir)
else:
  cef_checkout_new = False

# Update the CEF checkout if necessary.
if not options.noupdate and os.path.exists(cef_dir):
  cef_current_hash = get_git_hash(cef_dir, 'HEAD')

  if not cef_checkout_new:
    # Fetch new sources.
    run('%s fetch' % (git_exe), cef_dir, depot_tools_dir)

  cef_desired_hash = get_git_hash(cef_dir, cef_checkout)
  cef_checkout_changed = cef_checkout_new or force_change or \
                         cef_current_hash != cef_desired_hash

  msg("CEF Current Checkout: %s" % (cef_current_hash))
  msg("CEF Desired Checkout: %s (%s)" % (cef_desired_hash, cef_checkout))

  if cef_checkout_changed:
    # Checkout the requested branch.
    run('%s checkout %s%s' %
      (git_exe, ('--force ' if options.forceclean else ''), cef_checkout), \
      cef_dir, depot_tools_dir)
else:
  cef_checkout_changed = False


##
# Manage the out directory.
##

out_dir = os.path.join(download_dir, 'out_' + cef_branch)

# Delete the existing out directory if requested.
if options.forceclean and os.path.exists(out_dir):
  delete_directory(out_dir)

msg("CEF Output Directory: %s" % (out_dir))


##
# Manage the chromium directory.
##

# Create the chromium directory if necessary.
chromium_dir = os.path.join(download_dir, 'chromium')
create_directory(chromium_dir)

chromium_src_dir = os.path.join(chromium_dir, 'src')
cef_src_dir = os.path.join(chromium_src_dir, 'cef')
out_src_dir = os.path.join(chromium_src_dir, 'out')

# Create gclient configuration file.
gclient_file = os.path.join(chromium_dir, '.gclient')
if not os.path.exists(gclient_file) or options.forceconfig:
  # Exclude unnecessary directories. Intentionally written without newlines.
  gclient_spec = \
      "solutions = [{"+\
        "u'managed': False,"+\
        "u'name': u'src', "+\
        "u'url': u'https://chromium.googlesource.com/chromium/src.git', "+\
        "u'custom_deps': {"+\
          "u'build': None, "+\
          "u'build/scripts/command_wrapper/bin': None, "+\
          "u'build/scripts/gsd_generate_index': None, "+\
          "u'build/scripts/private/data/reliability': None, "+\
          "u'build/scripts/tools/deps2git': None, "+\
          "u'build/third_party/lighttpd': None, "+\
          "u'commit-queue': None, "+\
          "u'depot_tools': None, "+\
          "u'src/chrome_frame/tools/test/reference_build/chrome': None, "+\
          "u'src/chrome/tools/test/reference_build/chrome_linux': None, "+\
          "u'src/chrome/tools/test/reference_build/chrome_mac': None, "+\
          "u'src/chrome/tools/test/reference_build/chrome_win': None, "+\
        "}, "+\
        "u'deps_file': u'" + deps_file + "', "+\
        "u'safesync_url': u''"+\
      "}]"

  msg('Writing file: %s' % gclient_file)
  if not options.dryrun:
    fp = open(gclient_file, 'w')
    fp.write(gclient_spec)
    fp.close()

# Initial Chromium checkout.
if not options.noupdate and not os.path.exists(chromium_src_dir):
  chromium_checkout_new = True
  run("gclient sync --nohooks --with_branch_heads --jobs 16", chromium_dir, \
      depot_tools_dir)
else:
  chromium_checkout_new = False

# Verify the Chromium checkout.
if not options.dryrun and not is_git_checkout(chromium_src_dir):
  raise Exception('Not a valid git checkout: %s' % (chromium_src_dir))

if os.path.exists(chromium_src_dir):
  msg("Chromium URL: %s" % (get_git_url(chromium_src_dir)))

# Determine the Chromium checkout options required by CEF.
if options.chromiumcheckout == '':
  # Read the build compatibility file to identify the checkout name.
  compat_path = os.path.join(cef_dir, 'CHROMIUM_BUILD_COMPATIBILITY.txt')
  config = read_config_file(compat_path)

  if 'chromium_checkout' in config:
    chromium_checkout = config['chromium_checkout']
  else:
    raise Exception("Missing chromium_checkout value in %s" % (compat_path))
else:
  chromium_checkout = options.chromiumcheckout

# Determine if the Chromium checkout needs to change.
if not options.noupdate and os.path.exists(chromium_src_dir):
  chromium_current_hash = get_git_hash(chromium_src_dir, 'HEAD')
  chromium_desired_hash = get_git_hash(chromium_src_dir, chromium_checkout)
  chromium_checkout_changed = chromium_checkout_new or force_change or \
                              chromium_current_hash != chromium_desired_hash

  msg("Chromium Current Checkout: %s" % (chromium_current_hash))
  msg("Chromium Desired Checkout: %s (%s)" % \
      (chromium_desired_hash, chromium_checkout))
else:
  chromium_checkout_changed = options.dryrun

# Delete the existing src/cef directory. It will be re-copied from the download
# directory later.
if cef_checkout_changed and os.path.exists(cef_src_dir):
  delete_directory(cef_src_dir)  

# Delete the existing src/out directory if requested.
if options.forceclean and os.path.exists(out_src_dir):
  delete_directory(out_src_dir)

# Move the existing src/out directory to the correct location in the download
# directory. It will be moved back from the download directory later.
if os.path.exists(out_src_dir):
  old_branch = read_branch_config_file(out_src_dir)
  if old_branch != '' and (chromium_checkout_changed or \
                           old_branch != cef_branch):
    old_out_dir = os.path.join(download_dir, 'out_' + old_branch)
    move_directory(out_src_dir, old_out_dir)

# Update the Chromium checkout.
if chromium_checkout_changed:
  if not chromium_checkout_new:
    if options.forceclean and options.forcecleandeps:
      # Remove all local changes including third-party git checkouts managed by
      # gclient.
      run("%s clean -dffx" % (git_exe), chromium_src_dir, depot_tools_dir)
    else:
      # Revert all changes in the Chromium checkout.
      run("gclient revert --nohooks", chromium_dir, depot_tools_dir)

  # Fetch new sources.
  run("%s fetch" % (git_exe), chromium_src_dir, depot_tools_dir)
  # Also fetch tags, which are required for release branch builds.
  run("%s fetch --tags" % (git_exe), chromium_src_dir, depot_tools_dir)

  # Checkout the requested branch.
  run("%s checkout %s%s" % \
    (git_exe, ('--force ' if options.forceclean else ''), chromium_checkout), \
    chromium_src_dir, depot_tools_dir)

  # Patch the Chromium DEPS file if necessary.
  apply_deps_patch()

  # Set the GYP_CHROMIUM_NO_ACTION value temporarily so that `gclient sync` does
  # not run gyp.
  os.environ['GYP_CHROMIUM_NO_ACTION'] = '1'

  # Update third-party dependencies including branch/tag information.
  run("gclient sync %s--with_branch_heads --jobs 16" % \
      (('--reset ' if options.forceclean else '')), \
      chromium_dir, depot_tools_dir)

  # Clear the GYP_CHROMIUM_NO_ACTION value.
  del os.environ['GYP_CHROMIUM_NO_ACTION']

  # Delete the src/out directory created by `gclient sync`.
  delete_directory(out_src_dir)

# Restore the src/cef directory.
if os.path.exists(cef_dir) and not os.path.exists(cef_src_dir):
  copy_directory(cef_dir, cef_src_dir)

# Restore the src/out directory.
out_src_dir_exists = os.path.exists(out_src_dir)
if os.path.exists(out_dir) and not out_src_dir_exists:
  move_directory(out_dir, out_src_dir)
  out_src_dir_exists = True
elif not out_src_dir_exists:
  create_directory(out_src_dir)

# Write the config file for identifying the branch.
write_branch_config_file(out_src_dir, cef_branch)


##
# Build CEF.
##

if not options.nobuild and (chromium_checkout_changed or \
                            cef_checkout_changed or options.forcebuild or \
                            not out_src_dir_exists):
  # Building should also force a distribution.
  options.forcedistrib = True

  # Set GYP environment variables.
  os.environ['GYP_GENERATORS'] = 'ninja'
  if gyp_needs_target_arch_x64:
    if 'GYP_DEFINES' in os.environ.keys():
      os.environ['GYP_DEFINES'] = os.environ['GYP_DEFINES'] + ' ' + \
                                  'target_arch=x64'
    else:
      os.environ['GYP_DEFINES'] = 'target_arch=x64'

  # Print all build-related environment variables including any that were set
  # previously.
  for key in os.environ.keys():
    if key.startswith('GYP_') or key.startswith('DEPOT_TOOLS_'):
      msg('%s=%s' % (key, os.environ[key]))

  # Run the cef_create_projects script to generate project files.
  path = os.path.join(cef_src_dir, 'cef_create_projects'+script_ext)
  run(path, cef_src_dir, depot_tools_dir)

  # Build using Ninja.
  command = 'ninja -C '
  if options.verbosebuild:
    command = 'ninja -v -C'
  target = ' cefclient'
  if options.buildtests:
    target = target + ' cef_unittests'
  if platform == 'linux':
    target = target + ' chrome_sandbox'
  build_dir_suffix = ''
  if platform == 'windows' and options.x64build:
    build_dir_suffix = '_x64'

  if not options.nodebugbuild:
    # Make a CEF Debug build.
    run(command + os.path.join('out', 'Debug' + build_dir_suffix) + target, \
        chromium_src_dir, depot_tools_dir,
        os.path.join(download_dir, 'build-%s-debug.log' % (cef_branch)) \
          if options.buildlogfile else None)

  if not options.noreleasebuild:
    # Make a CEF Release build.
    run(command + os.path.join('out', 'Release' + build_dir_suffix) + target, \
        chromium_src_dir, depot_tools_dir,
        os.path.join(download_dir, 'build-%s-release.log' % (cef_branch)) \
          if options.buildlogfile else None)


##
# Create the CEF binary distribution.
##

if not options.nodistrib and (chromium_checkout_changed or \
                              cef_checkout_changed or options.forcedistrib):
  if not options.forceclean and options.cleanartifacts:
    # Clean the artifacts output directory.
    artifacts_path = os.path.join(cef_src_dir, 'binary_distrib')
    delete_directory(artifacts_path)

  # Determine the requested distribution types.
  distrib_types = []
  if options.minimaldistribonly:
    distrib_types.append('minimal')
  elif options.clientdistribonly:
    distrib_types.append('client')
  else:
    distrib_types.append('standard')
    if options.minimaldistrib:
      distrib_types.append('minimal')
    if options.clientdistrib:
      distrib_types.append('client')

  cef_tools_dir = os.path.join(cef_src_dir, 'tools')

  # Create the requested distribution types.
  first_type = True
  for type in distrib_types:
    path = os.path.join(cef_tools_dir, 'make_distrib'+script_ext)
    if options.nodebugbuild or options.noreleasebuild or type != 'standard':
      path = path + ' --allow-partial'
    path = path + ' --ninja-build'
    if options.x64build:
      path = path + ' --x64-build'

    if type == 'minimal':
      path = path + ' --minimal'
    elif type == 'client':
      path = path + ' --client'

    if first_type:
      if options.nodistribdocs:
        path = path + ' --no-docs'
      if options.nodistribarchive:
        path = path + ' --no-archive'
      first_type = False
    else:
      # Don't create the symbol archives or documentation more than once.
      path = path + ' --no-symbols --no-docs'

    # Create the distribution.
    run(path, cef_tools_dir, depot_tools_dir)
