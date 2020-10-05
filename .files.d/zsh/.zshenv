# set common variables
export ROOT=/System/Volumes/Data
export HOME=$ROOT/Users/asdingfs

# PATH exports
export PATH="/usr/local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# Python
export PATH="/usr/local/opt/python/bin:$PATH"

# RVM & Rubies
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
