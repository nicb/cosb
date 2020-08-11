## Copyright (C) 2018 Nicola Bernardini
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.
##
## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} rect (@var{wid}, @var{depth})
## @cindex indx 1
##
## create a rectangle out of dimensions @var{wid} and @var{depth} by
## sequencing angles over 2*pi
##
## @seealso{tan(), cot()}
## @end deftypefn

## Author: Nicola Bernardini <nicb@nicb-p302u>
## Created: 2018-06-17

function [x, y] = rect(wid, depth)
  hw = wid/2;
  hd = depth/2;
  hdiag = sqrt(hw**2 + hd**2);
  step = 0.0001;

  a1 = [-pi/4:step:pi/4-step];
  a2 = [pi/4:step:(3*pi)/4-step];
  a3 = [(3*pi)/4:step:(5*pi)/4-step];
  a4 = [(5*pi)/4:step:(7*pi)/4-step];

  m1 = hw./cot(a1); x1 = m1.*cot(a1); y1 = hd.*tan(a1);
  m2 = hd./tan(a2); x2 = hw.*cot(a2); y2 = m2.*tan(a2);
  m3 = -(hw./cot(a3)); x3 = m3.*cot(a3); y3 = -hd.*tan(a3);
  m4 = -(hd./tan(a4)); x4 = -hw.*cot(a4); y4 = m4.*tan(a4);

  x = [x1 x2 x3 x4];
  y = [y1 y2 y3 y4];

  [x, y];

endfunction
