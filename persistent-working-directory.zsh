# ================================================
# PERSISTENT-WORKING-DIRECTORY ===================
# ================================================
WORKING_DIRECTORY_FILE=$HOME/.zsh-wd

function lw()
{
  test -e $WORKING_DIRECTORY_FILE && cat $WORKING_DIRECTORY_FILE | sort
}

function sw()
{
  _target=$1

  # Default to 0
  if [[ -z $_target ]] ; then
    _target=0
  fi

  # Destroy the target if it exists
  if [[ -e $WORKING_DIRECTORY_FILE ]] ; then
    sed -i "/^$_target:.*$/d" $WORKING_DIRECTORY_FILE
  fi

  # Add it to the working directory file
  echo "$_target:$PWD" >> $WORKING_DIRECTORY_FILE

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

# Clear working directory file
function cw()
{
  rm $WORKING_DIRECTORY_FILE
}

