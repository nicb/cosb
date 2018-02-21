= cosb

* https://github.com/nicb/cosb

== DESCRIPTION:

`cosb` --- Csound Orchestra Spatializer Builder

+cosb+ is a generator of  orchestra  instruments  for  +csound+  to  run
spatial simulations for any kind of location and any technological setup
(from mono to stereo to multichannel to high-order ambisonics). +cosb+ reads
a configuration file for the physical location, the setup and the virtual
location and create the appropriate orchestra instruments in order to
play with the wanted space.

== FEATURES/PROBLEMS:

*This code is brand new. As such, it is certainly full of bugs, missing
features, and so on. You are welcome to contribute.*

== INSTALLATION

1. clone [the repository](https://github.com/nicb/cosb)
1. `cd cosb`
1. (`rvm current` should now show `ruby-2.4.2@prometeo-sacd`)
1. `gem install bundler`
1. `bundle install`

== SYNOPSIS:

  `cosb [-s] [-c config]`

	* -s : separates the reverb output from the direct one
	* -c : read file +<config>+

== REQUIREMENTS:

1. `rvm`: please use [`rvm`](https://rvm.io). Upon entering the `cosb`
   directory it should automatically set the proper gemset for you
1. Install the bundler gem (see [above](#INSTALLATION)), then run bundle install and this will fix all gem requirements.

== INSTALL:

<tt>rake install</tt>

== DEVELOPERS:

After checking out the source, position inside the directory containing the software and run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

GPL 2.0

Copyright (c) 2012-2018 Nicola Bernardini

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

== README VERSION:

Nicola Bernardini (Wed Feb 21 04:56:06 CET 2018)
Daniele Scarano (Dom  8 Dic 2013 16:13:48 CET)
