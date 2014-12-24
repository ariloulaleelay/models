#!/usr/bin/env python
import sys
from math import sin, cos, atan, sqrt, pow

def spiral(segments_number):
    alphas = []

    for i in xrange (0, segments_number):
        alphas.append(float(i) / (segments_number - 1))

    polyline_text = ''
    polyline_text += ','.join(map(lambda alpha: 'p(angle*{0}, a0*exp(b0*angle_rad*{0}) - t({0}))'.format(alpha), alphas))
    polyline_text += ',' + ','.join(map(lambda alpha: 'p(angle*{0}, a1*exp(b1*angle_rad*{0}) + t({0}))'.format(alpha), reversed(alphas)))
    print '''
module disc_spiral_{segments_number}(radius_from, radius_to, thickness_from, thickness_to, height, angle, alpha_power=1.0) {{
    function p(phi,r) = [cos(phi)*r, sin(phi)*r];
    function t(alpha) = thickness_from/2 + pow(alpha, alpha_power) * (thickness_to-thickness_from)/2;

    angle_rad = angle / 180 * 3.1415926;
    a0 = radius_from;
    b0 = ln(radius_to / a0) / angle_rad;

    a1 = a0;
    b1 = b0;

    linear_extrude(height=height)
        polygon([{polyline_text}]);
}}
'''.format(
        polyline_text=polyline_text,
        segments_number=segments_number
    )

def main():
    segments_number = 16 
    while segments_number <= 4096:
        spiral(segments_number)
        segments_number *= 2
        
if __name__ == '__main__':
    main()
