# ================================================
# PERSISTENT-WORKING-DIRECTORY ===================
# ================================================
WORKING_DIRECTORY_FILE=$HOME/.zsh-wd
WORKING_DIRECTORY_SYMBOLIC_LINK=$HOME/.wd

function lw()
{
  test -e $WORKING_DIRECTORY_FILE && cat $WORKING_DIRECTORY_FILE
}

function sw()
{
  echo $PWD > $WORKING_DIRECTORY_FILE

  # ensure symbolic link is removed
  test -L $WORKING_DIRECTORY_SYMBOLIC_LINK && rm $WORKING_DIRECTORY_SYMBOLIC_LINK

  # create symbolc link
  ln -s $PWD $WORKING_DIRECTORY_SYMBOLIC_LINK

  lw
}

function gw()
{
  if [[ -e $WORKING_DIRECTORY_FILE ]] ; then
    clear
    cd `cat $WORKING_DIRECTORY_FILE`
  fi
}
