filelist=$(find ./plugin/ -name rc.vim)

for file in $filelist
do
	plugin_name=$(basename $(dirname $file))
	echo '" =============================================================================='
	echo '" '${plugin_name}' {{{'
	echo '" =============================================================================='
	echo "if neobundle#tap('${plugin_name}')"
	echo ''
	cat $file
	echo ''
	echo 'call neobundle#untap()'
	echo 'endif'
	echo '" }}}'
done > vimrc_plugin

{
	echo '" =============================================================================='
	echo '" vim: set ft=vim fdm=marker ff=unix fileencoding=utf-8 expandtab ts=2 sw=2 :'
	echo '" =============================================================================='
} >> vimrc_plugin
