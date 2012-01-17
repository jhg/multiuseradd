##############################################################################
##                                                                          ##
## Multiuseradd is a script for linux that add news users from csv file.    ##
##                                                                          ##
## multiuseradd.sh (C) 2011 Jesús Hernández Gormaz.                         ##
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

.SILENT:

all:
	echo "Use make install as root for install multiuseradd"

install:
	cp ./multiuseradd.sh /bin/multiuseradd.sh
	ln --symbolic /bin/multiuseradd.sh /bin/multiuseradd
	chmod 755 /bin/multiuseradd
	chmod 755 /bin/multiuseradd.sh

