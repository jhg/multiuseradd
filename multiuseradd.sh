##############################################################################
##                                                                          ##
## Multiuseradd is a script for linux that add news users from csv file.    ##
##                                                                          ##
## multiuseradd.sh (C) 2012 Jesús Hernández Gormaz.                         ##
##                                                                          ##
##   This program is free software; you can redistribute it and/or          ##
##     modify it under the terms of the GNU General Public License as       ##
##     published by the Free Software Foundation; either version 3, or      ##
##     (at your option) any later version.                                  ##
##     This program is distributed in the hope that it will be useful,      ##
##     but WITHOUT ANY WARRANTY; without even the implied warranty of       ##
##     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the         ##
##     GNU General Public License for more details.                         ##
##     You should have received a copy of the GNU General Public License    ##
##     along with this program; if not, write to the Free Software          ##
##     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.            ##
##                                                                          ##
##############################################################################

# Help
if [ $# -lt 1 ] || [ $1 = "--help" ]
then
  cat <<HELP
Multiuseradd (C) 2012 Jesús Hernández Gormaz
  This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 3, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

Multiuseradd is a script for linux that add news users from csv file.
Only parameter of this script is the CSV file with users and passwords.
HELP
  exit
fi

# Help
if [ $1 = "--version" ]
then
  cat <<HELP
Multiuseradd 0.0.0
HELP
  exit
fi

# Check if file exist and is readable
if [ ! -r "$1" ]
then
  # Exit
  echo "File $1 no exist."
  exit
fi

# Valid for default
valid=1
# Count line of file
number_line=0
# Read file line to line
#  will read and check while not end file.
while read line
do
  # Increment number of line
  number_line=`expr $number_line + 1`
  # Check first char no comma
  if [ ${line:0:1} = "," ]
  then
    echo "In file $1 in line $number_line have not user name, the first char is comma."
    valid=0
  fi
  # Check end char no comma
  if [ ${line:`expr $(expr length $line) - 1`:1} = "," ]
  then
    echo "In file $1 in line $number_line have not password, the end char is comma."
    valid=0
  fi
  # Count number of commas per line
  # Check char to char
  for c in $(seq 0 `expr $(expr length $line) - 1` )
  do
    if [ $c = 0 ]
    then
      number_commas=0
      continue
    else
      # Check if is comma
      if [ ${line:$c:1} = "," ]
      then
        number_commas=`expr $number_commas + 1`
      fi
    fi
    # Check end char
    if [ $c = `expr $(expr length $line) - 1` ]
    then
      # Check total of commas
        if [ ! $number_commas = 1 ]
        then
          echo "In file $1 in line $number_line have $number_commas commas."
          valid=0
        fi
    fi
  done
done < $1

# Check if file is valid
if [ $valid = 0 ]
then
  exit
fi

# Read file line to line and split user and password
#  IFS is variable of Internal Field Separator, and the internal command read
#  will read and split line to line while not end file.
while IFS="," read user pass
do
  # Encrypt password
  pass_encrypt=`perl ./crypt.pl $pass`
  # Create new user
  #useradd -p $pass_encrypt $user
  echo $pass_encrypt
done < $1
