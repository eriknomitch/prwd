# ================================================
# PERSISTENT-WORKING-DIRECTORY ===================
# ================================================

# ------------------------------------------------
# GLOBALS ----------------------------------------
# ------------------------------------------------
WORKING_DIRECTORY_FILE=$HOME/.zsh-wd

# If the user has not set PWD_BIND_TO_WORKSPACE, default to false.
if [[ -z $PWD_BIND_TO_WORKSPACE ]] ; then
  PWD_BIND_TO_WORKSPACE=false
fi

# ------------------------------------------------
# UTILITY ----------------------------------------
# ------------------------------------------------
function _current_workspace()
{
  if ( $PWD_BIND_TO_WORKSPACE ) ; then
    wmctrl -d | grep "*" | awk '{print $1}'
  else
    echo 0
  fi
}

# ------------------------------------------------
# COMMANDS ---------------------------------------
# ------------------------------------------------
function lw()
{
  test -e $WORKING_DIRECTORY_FILE && cat $WORKING_DIRECTORY_FILE | sort
}

function sw()
{
  _target=$1
  _workspace=`_current_workspace`

  # Default to 0
  if [[ -z $_target ]] ; then
    _target=0
  fi

  # Destroy the target if it exists
  if [[ -e $WORKING_DIRECTORY_FILE ]] ; then

    # OS X sed is different and takes a preliminary "backup" arg
    if [[ `uname` == "Darwin" ]] ; then
      sed -i "" "/^$_target:[0-9]:.*$/d" $WORKING_DIRECTORY_FILE
    else
      sed -i "/^$_target:[0-9]:.*$/d" $WORKING_DIRECTORY_FILE
    fi
  fi

  # Add it to the working directory file
  echo "$_target:$_workspace:$PWD" >> $WORKING_DIRECTORY_FILE

  lw
}

function gw()
{
  _target=$1
  _workspace=0
  
  # Default to 0 if target was not passed
  if [[ -z $_target ]] ; then
    _target=0
  fi

  # Default to 0 if we aren't binding to workspaces
  if ( $PWD_BIND_TO_WORKSPACE ) ; then
    _workspace=`_current_workspace`
  fi

  if [[ -e $WORKING_DIRECTORY_FILE ]] ; then
    clear

    _directory=`cat $WORKING_DIRECTORY_FILE | grep -E "^$_target:$_workspace" | sed "s/^$_target:$_workspace://"`

    cd $_directory
  fi
}

# Clear working directory file
function cw()
{
  rm $WORKING_DIRECTORY_FILE
}

# ------------------------------------------------
# MAIN -------------------------------------------
# ------------------------------------------------

# Create the file and set a default working directory (HOME)
if [[ ! -f $WORKING_DIRECTORY_FILE ]] ; then
  echo "0:0:$HOME" >> $WORKING_DIRECTORY_FILE
fi

