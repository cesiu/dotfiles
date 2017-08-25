" Projector Mode
"
" Use the 'ToggleProjectorMode' command to switch between your default
" colourscheme and a clearer projector colourscheme. Very useful for those of
" us who like dark themes and occasionally have to present in light rooms.
"
" Set the following in your vimrc to pick the themes to toggle between:
" g:default_colorscheme <default-colorscheme>
" g:projector_colorscheme <projector-colorscheme>
"
" You can bind this in your vimrc like this:
" noremap <silent> <leader>p :ToggleProjectorMode<CR>
"
" Thrown together by Adam Whittingham, 2013.
" Licensed under the WTFPL 2.0 (Do What the Fuck You Want to Public License)

let g:projector_scheme_name=''

function! ToggleProjectorMode()
  if (g:colors_name != g:projector_scheme_name)
    exec "color ". g:projector_colorscheme
    let g:projector_scheme_name=g:colors_name
    let g:airline_theme=g:airline_projector_theme
    set background=light
  else
    exec "color ". g:default_colorscheme
    let g:airline_theme=g:airline_default_theme
    set background=dark
  endif
endfunction

command! Beam :call ToggleProjectorMode()
