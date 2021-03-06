com! -nargs=1 -complete=dir DeployEclimd call s:deploy_eclimd(<f-args>)

function! s:deploy_eclimd(eclipsePath)
    let l:eclim_d = '/tmp/eclim'
    let l:eclipse_d = resolve(getcwd() . '/' . a:eclipsePath)
    let l:vim_d = '/tmp/vim-eclim'

    if ! filereadable(l:eclipse_d . '/eclipse.ini')
        echom 'Eclipse path invalid.'
        return
    endif

    " download code, build and then remove
    execute 'silent !git clone https://github.com/ervandew/eclim.git ' . l:eclim_d
    execute 'cd ' . l:eclim_d

    " always checkout last release to build from
    let l:last_tag = split(system('git tag'), '\n')[-1]
    execute 'silent !git checkout ' . l:last_tag
    execute 'silent !ant -Dvim.files=' . l:vim_d ' -Declipse.home=' . l:eclipse_d
    execute 'cd -'
    execute 'silent !rm -rf ' . l:eclim_d . ' ' . l:vim_d
endfunction
