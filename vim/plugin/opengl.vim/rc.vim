Autocmd BufRead *.c,*.h,*.cpp,*.hpp call MyOpenGLCheck()
function! MyOpenGLCheck()
  if search('^#include <gl.*\.h>','n') > 0 ||
  \  search('^#include <GL.*/gl.*\.h>', 'n') > 0 ||
  \  search('^#include <EGL/egl.h>', 'n') > 0
    NeoBundleSource opengl.vim
  endif
endfunction
