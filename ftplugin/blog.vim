" post blog entry to my Drupal site
" Use :e blog/nodeID_which_is_digits to open an existing entry for editting;
"     For example :e blog/12
" Use :e blog/anything_other_than_digits to open a new entry for editing
"     For example :e blog/blah
" Use :w to post it.
" Use :w blog/anything to post a file as a new blog entry

python << EOF

strUserName = 'Palpatineli'
strPassword = 'tomlikeji'
strDrupal = 'http://www.keji.li'

import vim
import xmlrpclib
import re

def PostBlog():

  #
  # If first line contains a blog entry ID then edit existing post,
  # otherwise write a new one.
  #
  nFirstLine = 0
  strID = vim.current.buffer[0]
  if not re.match( '^\d+$', strID):
    strID = ''
  else:
    nFirstLine = 1

  strTitle = vim.current.buffer[nFirstLine]
  strText = "\n".join( vim.current.buffer[nFirstLine+1:])

  oDrupal = xmlrpclib.ServerProxy( strDrupal + '/xmlrpc.php')

  oPost = { 'title': strTitle, 'description': strText}

  if strID == '':
    strID = oDrupal.metaWeblog.newPost( 'blog', strUserName, strPassword, oPost, True)
  else:
    bSuccess = oDrupal.metaWeblog.editPost( strID, strUserName, strPassword, oPost, True)

  print "Posted entry %s" % strID

  #
  # Don't intend to write posts to disk so unmodify the buffer and
  # allow easy quit from VIM.
  #
  vim.command( 'set nomodified')

def ReadBlog( strID ):
  
  #
  # So html plugin is automatically enabled for editing the post
  # with auto-completion and syntax highlighting
  #
  vim.command('setfiletype html')

  if not strID.isdigit():
    print "New blog entry"
    return

  oDrupal = xmlrpclib.ServerProxy( strDrupal + '/xmlrpc.php')

  oBlog = oDrupal.metaWeblog.getPost( strID, strUserName, strPassword )

  vim.current.buffer[:] = []
  vim.current.buffer[0] = strID
  vim.current.buffer.append( oBlog['title'])
  vim.current.buffer.append( '')
  for strLine in oBlog['description'].split('\n'):
    vim.current.buffer.append( strLine)

EOF

:au BufWriteCmd blog/* py PostBlog() 
:au BufReadCmd blog/* py ReadBlog(vim.eval("expand('<afile>:t')"))

syntax on
