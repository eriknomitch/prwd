# ================================================
# PERSISTENT-WORKING-DIRECTORY ===================
# ================================================
WORKING_DIRECTORY_FILE=$HOME/.zsh-wd
WORKING_DIRECTORY_SYMBOLIC_LINK=$HOME/.wd

function lw()
{
  test -e $WORKING_DIRECTORY_FILE && cat $WORKING_DIRECTORY_FILE | sort
}

function sw()
{
  _target=$1

  # Default to 0
  if [[ -z $_target ]] ; then
    echo "setting target to 0"
    _target=0
  fi

  # Destroy the target if it exists
  sed -i "/^$_target:.*$/d" $WORKING_DIRECTORY_FILE

  # Add it to the working directory file
  echo "$_target:$PWD" >> $WORKING_DIRECTORY_FILE

  # ensure symbolic link is removed
  test -L $WORKING_DIRECTORY_SYMBOLIC_LINK && rm $WORKING_DIRECTORY_SYMBOLIC_LINK

  # create symbolc link
  ln -s $PWD $WORKING_DIRECTORY_SYMBOLIC_LINK

  lw
}

function gw()
{
  _target=$1

  # Default to 0
  if [[ -z $_target ]] ; then
    _target=0
  fi

  if [[ -e $WORKING_DIRECTORY_FILE ]] ; then
    clear
    cd `cat $WORKING_DIRECTORY_FILE | grep -E "^$_target:" | sed "s/^$_target://"`
  fi
}

