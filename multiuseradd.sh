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
if [ $# -lt 2 ]
then
  cat <<HELP
Multiuseradd (C) 2012 Jesús Hernández Gormaz
Only parameter of this script is the CSV file with users and passwords.
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

# Count line of file
number_line=0
# Read file line to line
#  will read and check while not end file.
while read line
do
  # Increment number of line
  number_line=`expr $number_line + 1`
  # Count number of commas per line
  echo $number_line $line
done < $1

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
