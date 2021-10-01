" Configurable variables
let g:react_component_trigger_word = 'comp'

function DeleteAtLine(line_num)
  execute 'normal! ' . a:line_num . 'Gdd'
endfunction

"Take in the word and output a command that inserts those words at the
"specified line number
function AppendReactComponent(name, line_num)
  let lines = [
      \'const ' . a:name . ' = () => {',
      \'  return (',
      \'     ',
      \'  )',
      \'}',
      \'',
      \'export default ' . a:name
  \]
  call append(a:line_num, lines)
endfunction

function AppendReactComponentOnThisLine(name)
  call AppendReactComponent(a:name, line('.'))
endfunction

function AppendReactComponentAndDelete(name, line_num)
  call AppendReactComponent(a:name, a:line_num)
  call DeleteAtLine(a:line_num)
endfunction

function AppendReactComponentAndDeleteOnThisLine(name)
  call AppendReactComponentOnThisLine(a:name)
  call DeleteAtLine(line('.'))
endfunction

function CheckThisLineAndMaybeInsertReactComponent()
  let line = getline('.')
  let full_search_term = '.' . g:react_component_trigger_word . ' '
  " The entire line must equal this term exactly for the replacement to happen
  if matchstr(line, full_search_term) == full_search_term
    let comp_name = line[0:stridx(line, '.') - 1]
    " Append new lines
    call AppendReactComponentAndDeleteOnThisLine(comp_name)
    " Move cursor inside div
    normal $2j$
  endif
endfunction

augroup react_auto_commands
  au!
  au TextChangedI *.js :call CheckThisLineAndMaybeInsertReactComponent()
augroup END

" Simple abbreviations
iab reactimp import<space>React<space>from<space>'react'
